//
// Created by Yamazhiki on 01/06/2018.
// Copyright (c) 2018 Yamazhiki. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger) {
    AppHttpMethod_GET = 0,
    AppHttpMethod_POST = 1,
} Method;

@protocol Request <NSObject>
/**
 模块ID
 */
@optional
@property(readonly) NSInteger moduleID;
/**
 * 路径
 */
@required
@property(readonly) NSString *path;
/**
 * HttpMethod GET，POST
 */
@optional
@property(readonly) Method method;
/**
 * 自定义header
 */
@optional
@property(readonly) NSDictionary<NSString *, NSString *> *headers;
/**
 * 参数
 */
@optional
@property(readonly) id parameters;

@end
