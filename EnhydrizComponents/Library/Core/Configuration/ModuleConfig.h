//
// Created by 王斌 on 2019-01-17.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MethodDefinition;


/**
 * Module作用域
 */
typedef NS_ENUM(NSInteger, ModuleScope) {
    /**
     * 始终创建新的实例
     */
            ModuleScopePrototype,
    /**
     * 作用域随着ModuleProvider, 且唯一单例
     */
            ModuleScopeSingleton,
    /**
     * 弱引用单例 从生成实例开始 直到不被任何对象持有 释放
     */
            ModuleScopeWeakSingleton,
};


@interface ModuleConfig : NSObject

/**
 * 实现协议的类型
 */
@property(readonly) Class cls;
/**
 * 构造参数
 */
@property(readonly) MethodDefinition *constructMethod;
/**
 * 作用域
 */
@property(readonly) ModuleScope scope;

/**
 * 构造实例
 * @param cls 实现类
 * @return ModuleConfig
 */
- (instancetype)initWithCls:(Class)cls;

- (instancetype)initWithCls:(Class)cls scope:(ModuleScope)scope;


/**
 * 创建实例
 * @param params 参数
 * @return 实例
 */
- (id)create:(NSArray *)params;
@end
