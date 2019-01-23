//
// Created by 王斌 on 2019-01-23.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import "NSArray+Params.h"

NSArray *VarArgs(va_list ap) {
    id obj;
    NSMutableArray *array = [NSMutableArray array];

    while ((obj = va_arg(ap, id))) {
        [array addObject:obj];
    }
    return array;
}

@implementation NSArray (Params)
@end