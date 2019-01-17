//
// Created by 王斌 on 2019-01-15.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MethodDefinition.h"


@implementation MethodDefinition

@synthesize type = _type, method = _method;

- (instancetype)initWithType:(MethodDefinitionType)type method:(SEL)method {
    self = [super init];
    _type = type;
    _method = method;
    return self;
}

+ (instancetype)classMethod:(SEL)classMethod {
    return [[MethodDefinition alloc] initWithType:MethodDefinitionTypeClassMethod method:classMethod];
}

+ (instancetype)instanceMethod:(SEL)instanceMethod {
    return [[MethodDefinition alloc] initWithType:MethodDefinitionTypeInstanceMethod method:instanceMethod];
}

@end