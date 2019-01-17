//
// Created by 王斌 on 2019-01-14.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Product : NSObject
@property(readonly) NSInteger productID;
@property(readonly) NSString *name;

- (instancetype)initWithProductID:(NSInteger)productID name:(NSString *)name;

@end