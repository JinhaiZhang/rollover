//
// Created by 王斌 on 2019-01-11.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import "User.h"


@implementation User {

}
- (instancetype)initWithIdentifier:(NSInteger)identifier username:(NSString *)username sign:(NSString *)sign {
    self = [super init];
    if (self) {
        _identifier = identifier;
        _username = username;
        _sign = sign;
    }

    return self;
}

+ (instancetype)userWithIdentifier:(NSInteger)identifier username:(NSString *)username sign:(NSString *)sign {
    return [[self alloc] initWithIdentifier:identifier username:username sign:sign];
}

@end