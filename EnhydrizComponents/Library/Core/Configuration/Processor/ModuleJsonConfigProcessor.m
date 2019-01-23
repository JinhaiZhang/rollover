//
// Created by 王斌 on 2019-01-22.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import "ModuleJsonConfigProcessor.h"
#import "ModuleConfig.h"


@implementation ModuleJsonConfigProcessor

+ (NSDictionary<NSString *, NSArray<ModuleConfig *> *> *)process:(id)resource {
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    if (resource) {
        NSDictionary<NSString *, id> *source = resource;
        NSString *key = source[@"type"];
        NSArray *children = source[@"configs"];
        __block NSMutableArray *configs = [NSMutableArray array];
        [children enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            NSNumber *number = obj[@"scope"];
            NSString *className = obj[@"class"];
            if (className) {
                [configs addObject:[[ModuleConfig alloc] initWithCls:NSClassFromString(className) scope:number ? (ModuleScope) number.integerValue : ModuleScopePrototype]];
            }
        }];
        if (children.count) result[key] = configs;
    }
    return result;
}

@end