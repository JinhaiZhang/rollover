//
// Created by 王斌 on 2019-01-14.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModuleResponse.h"


@implementation ModuleResponse {

}
- (instancetype)initWithViewController:(UIViewController *)viewController viewModel:(id)viewModel {
    self = [super init];
    if (self) {
        self.viewController = viewController;
        self.viewModel = viewModel;
    }

    return self;
}

+ (instancetype)responseWithViewController:(UIViewController *)viewController viewModel:(id)viewModel {
    return [[self alloc] initWithViewController:viewController viewModel:viewModel];
}

@end