//
// Created by Yamazhiki on 2018/7/24.
// Copyright (c) 2018 AsiaInnovations. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ServerConfig<NSObject>
@property(readonly) NSString *apiBaseURL;
@property(readonly) NSString *logBaseURL;
@property(readonly) int mode;
@end