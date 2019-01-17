//
// Created by 王斌 on 2019-01-14.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

@class Product;

@protocol MallModuleInputsType <NSObject>
@end

@protocol MallModuleOutputsType <NSObject>
@property(readonly) RACSignal<Product *> *didSelectProduct;
@end

@protocol MallModuleType
@property(readonly) id <MallModuleInputsType> inputs;
@property(readonly) id <MallModuleOutputsType> outputs;
@end