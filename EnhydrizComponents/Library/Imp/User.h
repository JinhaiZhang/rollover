//
// Created by 王斌 on 2019-01-11.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserType.h"


@interface User : NSObject <UserType>
@property(readonly) NSInteger identifier;
@property(readonly) NSString *username;
@property(readonly) NSString *sign;

- (instancetype)initWithIdentifier:(NSInteger)identifier username:(NSString *)username sign:(NSString *)sign;

+ (instancetype)userWithIdentifier:(NSInteger)identifier username:(NSString *)username sign:(NSString *)sign;

@end