//
// Created by 王斌 on 2019-01-08.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ModuleResponse;


@interface ModuleProvider : NSObject

/**
 * 此方法获取被注册协议的实现
 * @param aProtocol 协议
 * @return 协议的实现 id<aProtocol>
 */
+ (ModuleResponse *)request:(Protocol *)aProtocol;

/**
 * 获得被注册的协议实现
 * @param aProtocol 协议
 * @param params      协议实例构造所需要的参数
 * @return          ModuleResponse 实例
 */
+ (ModuleResponse *)request:(Protocol *)aProtocol params:(NSArray *)params;
@end
