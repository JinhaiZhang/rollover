//
// Created by Yamazhiki on 2018/7/24.
// Copyright (c) 2018 AsiaInnovations. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ResponseStatus<__covariant T>: NSObject
@property(readonly) NSInteger serverCode;
@property(readonly) NSError *error;
@property(readonly) T data;
@property(readonly) NSInteger code;

- (instancetype)initWithData:(T)data serverCode:(NSInteger)serverCode error:(NSError *)error;

@end