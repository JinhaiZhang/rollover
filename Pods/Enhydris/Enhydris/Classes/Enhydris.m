//
// Created by Yamazhiki on 04/06/2018.
// Copyright (c) 2018 AsiaInnovations. All rights reserved.
//

#import "ResponsePipeType.h"
#import "RequestMakerType.h"
#import "ResponseStubType.h"
#import "Enhydris.h"
#import "Plugin.h"

@interface Enhydris ()
@property(nonatomic) NSString *baseURLString;
@property(nonatomic) StubType stubType;
@property(nonatomic) EnhydrisConfiguration *config;
@end

@implementation EnhydrisConfiguration
- (instancetype)initWithRequestMaker:(id <RequestMakerType>)requestMaker responsePipe:(id <ResponsePipeType>)responsePipe plugins:(NSArray *)plugins {
    self = [super init];
    if (self) {
        _requestMaker = requestMaker;
        _responsePipe = responsePipe;
        _plugins = plugins;
    }

    return self;
}

+ (instancetype)configurationWithRequestMaker:(id <RequestMakerType>)requestMaker responsePipe:(id <ResponsePipeType>)responsePipe plugins:(NSArray *)plugins {
    return [[self alloc] initWithRequestMaker:requestMaker responsePipe:responsePipe plugins:plugins];
}

@end

@implementation Enhydris {
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"Enhydris" reason:@"not support init" userInfo:nil];
    return nil;
}

+ (instancetype)new {
    @throw [NSException exceptionWithName:@"Enhydris" reason:@"not support new" userInfo:nil];
    return nil;
}

- (instancetype)initWithBaseURLString:(NSString *)baseURLString {
    return [self initWithBaseURLString:baseURLString stubType:StubTypeNone config:[[EnhydrisConfiguration alloc] init]];
}

- (instancetype)initWithBaseURLString:(NSString *)baseURLString stubType:(StubType)type {
    return [self initWithBaseURLString:baseURLString stubType:type config:[[EnhydrisConfiguration alloc] init]];
}

- (instancetype)initWithBaseURLString:(NSString *)baseURLString stubType:(StubType)type config:(EnhydrisConfiguration *)config {
    self = [super init];
    self.baseURLString = baseURLString;
    self.stubType = type;
    self.config = config;
    return self;
}


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"

- (NSURLSessionTask *)request:(id <Request>)request completion:(void (^)(id, NSError *))completion {
    switch (self.stubType) {
        case StubTypeSimulation: {
            if ([request conformsToProtocol:@protocol(ResponseStubType)]) {
                id <ResponseStubType> stub = (id <ResponseStubType>) request;
                if ([stub respondsToSelector:@selector(sampleData)] && [stub respondsToSelector:@selector(delay)]) {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (stub.delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        completion(stub.sampleData, nil);
                    });
                } else {
                    @throw [NSException exceptionWithName:NSStringFromClass(request.class) reason:@"must imp <ResponseStubType> all method" userInfo:nil];
                }
            }
            return nil;
        }
        default: {
            if (self.config.requestMaker) {
                NSURLSession *defaultSession = NSURLSession.sharedSession;
                NSURLRequest *targetRequest = [self.config.requestMaker make:request baseURL:[[NSURL alloc] initWithString:self.baseURLString]];
                [self start:targetRequest];
                NSURLSessionTask *task = [defaultSession dataTaskWithRequest:targetRequest
                                                           completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                               if (self.config.responsePipe) {
                                                                   id logicObject = [self.config.responsePipe pipe:request responseObject:data error:error];
                                                                   [self end:response data:logicObject error:error];
                                                                   completion(logicObject, error);
                                                               } else {
                                                                   [self end:response data:data error:error];
                                                                   completion(data, error);
                                                               }
                                                           }];
                [task resume];
                return task;
            } else {
                @throw [NSException exceptionWithName:NSStringFromClass(self.class)
                                               reason:@"EnhydrisConfiguration 缺少 id<RequestMakerType>"
                                             userInfo:nil];
            }
        }
    }
}

#pragma clang diagnostic pop

- (void)start:(NSURLRequest *)request {
    [self.config.plugins enumerateObjectsUsingBlock:^(id <Plugin> obj, NSUInteger idx, BOOL *stop) {
        [obj start:request];
    }];
}

- (void)end:(NSURLResponse *)response data:(id)data error:(NSError *)error {
    [self.config.plugins enumerateObjectsUsingBlock:^(id <Plugin> obj, NSUInteger idx, BOOL *stop) {
        [obj end:response data:data error:error];
        *stop = obj.shouldIntercept;
    }];
}

@end
