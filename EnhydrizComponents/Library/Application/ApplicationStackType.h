//
// Created by 王斌 on 2019-01-10.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

@protocol ApiConfigType;
@protocol LanguageType;
@protocol UserType;
@protocol MotorType;

@protocol ApplicationStackType <NSObject>


@property(readonly) RACSignal<NSNumber *> *events;

/**
 * 获取单例
 * @return ApplicationStackType
 */
+ (id <ApplicationStackType>)shared;

/**
 * 获取当前栈中最新的Worker
 * @return WorkerType
 */
- (id <MotorType>)current;

/**
 * 切换Api配置
 * @param apiConfig  ApiConfigType
 */
- (void)switchApiConfig:(id <ApiConfigType>)apiConfig;

/**
 * 切换语言
 * @param language LanguageType
 */
- (void)switchLanguage:(id <LanguageType>)language;

/**
 * 更新用户
 * @param user UserType
 */
- (void)updateUser:(id <UserType>)user;
@end