//
// Created by 王斌 on 2019-01-14.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import  "TestModuleType.h"

@interface TestModuleImp : NSObject <TestModuleOutputsType, TestModuleInputsType, TestModuleType>
- (instancetype)initWithPrefix:(NSString *)prefix;
@end


