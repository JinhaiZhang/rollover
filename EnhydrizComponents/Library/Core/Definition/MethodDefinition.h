//
// Created by 王斌 on 2019-01-15.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MethodDefinitionType) {
    MethodDefinitionTypeInstanceMethod,
    MethodDefinitionTypeClassMethod
};

@interface MethodDefinition : NSObject
@property(readonly) MethodDefinitionType type;
@property(readonly) SEL method;

+ (instancetype)classMethod:(SEL)classMethod;

+ (instancetype)instanceMethod:(SEL)instanceMethod;
@end