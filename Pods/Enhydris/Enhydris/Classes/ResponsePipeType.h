//
// Created by Yamazhiki on 2018/8/27.
// Copyright (c) 2018 AsiaInnovations. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol Request;

@protocol ResponsePipeType <NSObject>
- (id)pipe:(id <Request>)request responseObject:(id)responseObject error:(NSError *)error;
@end

NS_ASSUME_NONNULL_END
