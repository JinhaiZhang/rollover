//
// Created by Yamazhiki on 2018/7/30.
// Copyright (c) 2018 AsiaInnovations. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ModuleType <NSObject>
+ (NSString *)modulePath:(NSInteger)moduleID;
@end