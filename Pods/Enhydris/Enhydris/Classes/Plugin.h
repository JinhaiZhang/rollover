//
// Created by Yamazhiki on 2018/9/11.
// Copyright (c) 2018 AsiaInnovations. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 插件系统
 */
@protocol Plugin <NSObject>


/**
 是否拦截
 拦截器会按照顺序执行，直到某个shouldIntercept为YES才终止(之后的拦截器不会执行)
 */
@property(readonly) BOOL shouldIntercept;

/*发送请求之前*/
- (void)start:(NSURLRequest *)request;


/**
 请求结束后回调

 @param response NSURLResponse
 @param data 最终处理过的数据 ResponsePipeType->TransformType
 @param error 错误
 */
- (void)end:(NSURLResponse *)response data:(id)data error:(NSError *)error;

@end
