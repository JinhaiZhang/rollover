//
// Created by 王斌 on 2019-01-22.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ModuleConfig;

@protocol ModuleProcessorType <NSObject>
+ (NSDictionary<NSString *, NSArray<ModuleConfig *> *> *)process:(id)resource;
@end