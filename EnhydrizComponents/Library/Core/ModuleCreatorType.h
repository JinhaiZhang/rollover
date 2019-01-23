//
// Created by 王斌 on 2019-01-23.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ModuleCreatorType <NSObject>
- (id)initWithParams:(id)params, ...;
@end