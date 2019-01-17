//
// Created by 王斌 on 2019-01-11.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Enhydris;

@protocol UserType;

@protocol MotorType <NSObject>
@property(readonly) id <UserType> user;
@property(readonly) Enhydris *api;
@end