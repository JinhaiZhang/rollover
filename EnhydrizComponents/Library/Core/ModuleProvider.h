//
// Created by 王斌 on 2019-01-08.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ModuleResponse;


@interface ModuleProvider : NSObject

/*初始化设定*/
+ (void)setUp;

/**
 * 此方法获取被注册协议的实现
 * @param aProtocol 协议
 * @return 协议的实现 id<aProtocol>
 */
+ (id)request:(Protocol *)aProtocol;

/**
 * 获得被注册的协议实现
 * @param aProtocol 协议
 * @param args      协议实例构造所需要的参数
 * @return          协议实例
 */
+ (id)request:(Protocol *)aProtocol params:(id)args, ...;
@end