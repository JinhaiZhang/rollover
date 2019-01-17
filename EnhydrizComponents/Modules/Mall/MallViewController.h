//
// Created by 王斌 on 2019-01-14.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MallModuleType.h"


@interface MallViewController : UIViewController <MallModuleType>
+ (instancetype)initWithCategoryId:(NSNumber *)categoryId;
@end