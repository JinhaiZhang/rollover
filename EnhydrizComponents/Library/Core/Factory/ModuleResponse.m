//
// Created by 王斌 on 2019-01-22.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import <GameplayKit/GameplayKit.h>
#import "ModuleResponse.h"


@implementation ModuleResponse

- (instancetype)initWithObject:(id)object error:(NSError *)error {
    self = [super init];
    if (self) {
        _object = object;
        _error = error;
    }
    return self;
}

+ (instancetype)responseWithError:(NSError *)error {
    return [[ModuleResponse alloc] initWithObject:nil error:error];
}

+ (instancetype)responseWithObject:(id)object {
    return [[ModuleResponse alloc] initWithObject:object error:nil];
}


@end