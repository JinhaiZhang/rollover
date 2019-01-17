//
// Created by Yamazhiki on 04/06/2018.
// Copyright (c) 2018 Yamazhiki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Request.h"
#import "ResponseStatus.h"

NS_ASSUME_NONNULL_BEGIN

@protocol Plugin;
@protocol ResponsePipeType;
@protocol RequestMakerType;

typedef NS_ENUM(NSInteger, StubType) {
    StubTypeNone,
    StubTypeSimulation
};


/**
 配置
 */
@interface EnhydrisConfiguration : NSObject

/**
 请求组装
 */
@property(readonly) id <RequestMakerType> requestMaker;

/**
 相应处理流
 */
@property(readonly) id <ResponsePipeType> responsePipe;

/**
 插件
 */
@property(readonly) NSArray<id <Plugin>> *plugins;

- (instancetype)initWithRequestMaker:(id <RequestMakerType>)requestMaker responsePipe:(id <ResponsePipeType>)responsePipe plugins:(NSArray *)plugins;

+ (instancetype)configurationWithRequestMaker:(id <RequestMakerType>)requestMaker responsePipe:(id <ResponsePipeType>)responsePipe plugins:(NSArray *)plugins;


@end

@interface Enhydris : NSObject

- (instancetype)init UNAVAILABLE_ATTRIBUTE;

+ (instancetype)new UNAVAILABLE_ATTRIBUTE;


/**
 根据基础URL创建实例

 @param baseURLString 基础URL
 @return ClientManager 实例 (默认没有Stub)
 */
- (instancetype)initWithBaseURLString:(NSString *)baseURLString __attribute__((deprecated));

/**
 * 构造
 * @param baseURLString 基础URl
 * @param type Stub类型
 * @return ClientManager 实例
 */
- (instancetype)initWithBaseURLString:(NSString *)baseURLString stubType:(StubType)type __attribute__((deprecated));

/**
 构造

 @param baseURLString 基础地质
 @param type Stub类型
 @param config 配置
 @return 实例
 */
- (instancetype)initWithBaseURLString:(NSString *)baseURLString stubType:(StubType)type config:(EnhydrisConfiguration *)config;

/**
 执行请求

 @param request 任何实现 <Request> 的类
 @param completion 成功回调(结果,错误)
 @return NSURLSessionTask *实例 可用于取消
 */
- (NSURLSessionTask *)request:(id <Request>)request completion:(void (^)(id, NSError *))completion;
@end

NS_ASSUME_NONNULL_END
