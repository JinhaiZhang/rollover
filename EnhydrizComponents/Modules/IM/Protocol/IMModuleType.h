//
// Created by 王斌 on 2019-01-15.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol IMModuleInputsType <NSObject>

@end

@protocol IMModuleOutputsType <NSObject>

@end

@protocol IMModuleType
@property(readonly) id <IMModuleInputsType> inputs;
@property(readonly) id <IMModuleOutputsType> outputs;
@end