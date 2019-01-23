//
// Created by 王斌 on 2019-01-14.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import  "TestModuleType.h"
#import "ModuleCreatorType.h"

@interface TestModuleImp : NSObject <TestModuleOutputsType, TestModuleInputsType, TestModuleType, ModuleCreatorType>
@end


