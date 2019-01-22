//
// Created by 王斌 on 2019-01-14.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "ModuleConfig.h"

@class MethodDefinition;
@class ModuleConfig;

/**
 * 模块定义类 （同是也是扩展点）
 * 如果 协议 id<Type> 则 aProtocol 为 Protocol<A>; cls 必须具备实现<A> 同时具有Creator协议的方法
 *
 */
@interface ModuleDefinition : NSObject
/**
 * 被导出模块的协议
 */
@property(readonly) Protocol *aProtocol;
/**
 * 被导出模块的实现
 */
@property(readonly) Class cls;
/**
 * 模块作用域
 */
@property(nonatomic) ModuleScope scope;

+ (instancetype)definitionWithProtocol:(Protocol *)aProtocol
                           targetClass:(Class)targetClass
                         configuration:(void (^)(ModuleDefinition *))configuration;

- (void)defineConstructorMethod:(MethodDefinition *)methodConfig;

- (id)createInstance:(id)params, ...;

- (void)replaceWithConfig:(ModuleConfig *)config;

@end
