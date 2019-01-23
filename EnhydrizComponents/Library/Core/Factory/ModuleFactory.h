//
// Created by 王斌 on 2019-01-22.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ModuleDefinition;
@class ModuleResponse;
@class ModuleConfig;


@interface ModuleFactory : NSObject
+ (instancetype)defaultFactory;

/**
 * 重组现有的ModuleDefinition
 * @param configs 获取到的配置
 */
- (void)combineWithObtainedConfigs:(NSArray<NSDictionary<NSString *, NSArray<ModuleConfig *> *> *> *)configs;

- (ModuleResponse *)obtainModuleByProtocol:(Protocol *)aProtocol params:(NSArray *)params;

- (id)obtainModule:(ModuleDefinition *)definition params:(id)params, ...;
@end