//
// Created by 王斌 on 2019-01-14.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import "MallModel.h"

@implementation Product

- (instancetype)initWithProductID:(NSInteger)productID name:(NSString *)name {
    self = [super init];
    if (self) {
        _productID = productID;
        _name = name;
    }
    return self;
}

@end