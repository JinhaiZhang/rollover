//
// Created by 王斌 on 2018/5/24.
// Copyright (c) 2018 Yamazhiki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApplicationStackType.h"
#import <ReactiveObjC/ReactiveObjC.h>

@protocol ApiConfigType;
@protocol LanguageType;
@protocol MotorType;
@protocol UserType;

typedef NS_ENUM(NSInteger) {
    AppEnvEventTypeEnvChanged,
    AppEnvEventTypeUserInfoUpdate,
    AppEnvEventTypeUserLogout,
    AppEnvEventTypeLanguageChanged
} AppEnvEventType;

@interface ApplicationStackImp : NSObject <ApplicationStackType>
@end
