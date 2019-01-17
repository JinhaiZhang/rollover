//
// Created by Yamazhiki on 2018/8/27.
// Copyright (c) 2018 AsiaInnovations. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Request;

@protocol RequestMakerType <NSObject>
- (NSURLRequest *)make:(id <Request>)request baseURL:(NSURL *)baseURL;
@end