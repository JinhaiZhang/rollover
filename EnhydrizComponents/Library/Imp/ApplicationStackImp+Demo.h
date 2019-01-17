//
// Created by 王斌 on 2019-01-11.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApplicationStackImp.h"
#import "WorkerImp.h"
#import "User.h"

@interface ApplicationStackImp (Demo)
+ (ApplicationStackImp *)manager;

@property(readonly) WorkerImp *worker;
@end

@interface WorkerImp (Demo)
@property(readonly) User *appUser;
@end