//
// Created by 王斌 on 2019-01-14.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/message.h>
#import "ModuleDefinition.h"
#import "MethodDefinition.h"
#import "ModuleConfig.h"

#define NSArrayObjectMaybeNil(__ARRAY__, __INDEX__) ((__INDEX__ >= [__ARRAY__ count]) ? nil : [__ARRAY__ objectAtIndex:__INDEX__])

#define Args(__ARRAY_NAME__)\
NSArrayObjectMaybeNil(__ARRAY_NAME__, 0),\
NSArrayObjectMaybeNil(__ARRAY_NAME__, 1),\
NSArrayObjectMaybeNil(__ARRAY_NAME__, 2),\
NSArrayObjectMaybeNil(__ARRAY_NAME__, 3),\
NSArrayObjectMaybeNil(__ARRAY_NAME__, 4),\
NSArrayObjectMaybeNil(__ARRAY_NAME__, 5),\
NSArrayObjectMaybeNil(__ARRAY_NAME__, 6),\
NSArrayObjectMaybeNil(__ARRAY_NAME__, 7),\
NSArrayObjectMaybeNil(__ARRAY_NAME__, 8),\
NSArrayObjectMaybeNil(__ARRAY_NAME__, 9),\
nil

@interface ModuleDefinition ()
@property(nonatomic) MethodDefinition *constructMethod;

- (instancetype)initWithProtocol:(Protocol *)aProtocol cls:(id)cls;
@end

@implementation ModuleDefinition
- (instancetype)initWithProtocol:(Protocol *)aProtocol cls:(id)cls {
    self = [super init];
    if (self) {
        _aProtocol = aProtocol;
        _cls = cls;
    }

    return self;
}

+ (instancetype)definitionWithProtocol:(Protocol *)aProtocol cls:(id)cls {
    return [[self alloc] initWithProtocol:aProtocol cls:cls];
}

+ (instancetype)definitionWithProtocol:(Protocol *)aProtocol targetClass:(Class)targetClass configuration:(void (^)(ModuleDefinition *))configuration {
    ModuleDefinition *definition = [[ModuleDefinition alloc] initWithProtocol:aProtocol cls:targetClass];
    if (configuration) configuration(definition);
    return definition;
}

- (id)createInstance:(id)params, ... {
    id result = nil;
    if (self.constructMethod) {
        switch (self.constructMethod.type) {
            case MethodDefinitionTypeInstanceMethod: {
                id classInstance = [self.cls alloc];
                id (*create)(id, SEL, ...) = (id (*)(id, SEL, ...)) [classInstance methodForSelector:self.constructMethod.method];
                return create(classInstance, self.constructMethod.method, params);
            }
            default: {
                id (*create)(id, SEL, ...) =  (id (*)(id, SEL, ...)) [self.cls methodForSelector:self.constructMethod.method];
                return create(self.cls, self.constructMethod.method, params);
            }
        }
    } else {
        result = [[self.cls alloc] init];
    }
    return result;
}


- (void)defineConstructorMethod:(MethodDefinition *)methodConfig {
    self.constructMethod = methodConfig;
}

- (void)replaceWithConfig:(ModuleConfig *)config {

}


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"


#pragma clang diagnostic pop


@end
