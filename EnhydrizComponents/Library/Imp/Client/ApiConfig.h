//
// Created by 王斌 on 2019-01-11.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApiConfigType.h"

@class Enhydris;

@interface ApiConfig : NSObject <ApiConfigType>
- (instancetype)initWithMode:(ApiMode)mode;
@end

@interface ApiConfig (Enhydris)
- (Enhydris *)base;
@end