//
// Created by 王斌 on 2019-01-14.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIViewController;

/**
 * 请求模块响应类
 */
@interface ModuleResponse<__covariant ViewModel> : NSObject
/**
 * 包括ViewController
 */
@property(nonatomic) UIViewController *viewController;
/**
 * 可相互通信的ViewModel
 */
@property(nonatomic) ViewModel viewModel;

- (instancetype)initWithViewController:(UIViewController *)viewController viewModel:(id)viewModel;

+ (instancetype)responseWithViewController:(UIViewController *)viewController viewModel:(id)viewModel;

@end