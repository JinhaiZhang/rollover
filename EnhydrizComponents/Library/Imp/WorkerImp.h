//
// Created by 王斌 on 2018/5/24.
// Copyright (c) 2018 Yamazhiki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MotorType.h"

@protocol UserType;
@class User;

@interface WorkerImp : NSObject <MotorType>
- (instancetype)initWithUser:(User *)user api:(Enhydris *)api;
+ (instancetype)impWithUser:(User *)user api:(Enhydris *)api;

@end
