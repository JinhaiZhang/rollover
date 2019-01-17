//
// Created by 王斌 on 2019-01-11.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import <Enhydris/Enhydris.h>
#import "ApiConfig.h"
#import "RequestMakerImp.h"
#import "ResponsePipeImp.h"


@implementation ApiConfig

@synthesize mode = _mode;

- (instancetype)initWithMode:(ApiMode)mode {
    self = [super init];
    _mode = mode;
    return self;
}

- (NSString *)baseUrl {
    switch (self.mode) {
        case ApiModeStage:
            return @"http://www.baidu.com";
        case ApiModeProduction:
            return @"http://google.com";
        default:
            return nil;
    }
}

- (Enhydris *)base {
    return [[Enhydris alloc] initWithBaseURLString:self.baseUrl
                                          stubType:StubTypeNone
                                            config:[[EnhydrisConfiguration alloc] initWithRequestMaker:[RequestMakerImp new]
                                                                                          responsePipe:[ResponsePipeImp new]
                                                                                               plugins:@[]]];
}


@end