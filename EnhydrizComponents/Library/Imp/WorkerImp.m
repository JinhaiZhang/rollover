//
// Created by 王斌 on 2018/5/24.
// Copyright (c) 2018 Yamazhiki. All rights reserved.
//
#import "WorkerImp.h"
#import "User.h"

@implementation WorkerImp

@synthesize user = _user, api = _api;

- (instancetype)initWithUser:(User *)user api:(Enhydris *)api {
    self = [super init];
    if (self) {
        _user = user;
        _api = api;
    }

    return self;
}

+ (instancetype)impWithUser:(User *)user api:(Enhydris *)api {
    return [[self alloc] initWithUser:user api:api];
}

@end
