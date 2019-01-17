//
// Created by Yamazhiki on 2018/8/1.
// Copyright (c) 2018 AsiaInnovations. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TransformType
@required
- (id)transform:(id)src;
@optional
- (void)errorResult:(id)errorResult;
@end
