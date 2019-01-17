//
// Created by 王斌 on 2019-01-14.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import <ReactiveObjC/RACSignal.h>

/**
 * 此头文件用于发布
 */

@protocol TestModuleInputsType
- (void)setName:(NSString *)name;
@end

@protocol TestModuleOutputsType
@property(readonly) RACSignal<NSString *> *testSignal;

@property(readonly) RACSignal *continuousSignal;
@end

@protocol TestModuleType <TestModuleInputsType, TestModuleOutputsType>
@property(readonly) id <TestModuleInputsType> inputs;
@property(readonly) id <TestModuleOutputsType> outputs;
@end
