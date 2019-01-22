//
// Created by 王斌 on 2019-01-16.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import "IMModuleExport.h"
#import "ModuleDefinition.h"
#import "IMModuleType.h"
#import "IMViewController.h"
#import "MethodDefinition.h"


@implementation IMModuleExport {
}

+ (NSArray<ModuleDefinition *> *)services {
    return @[
            [ModuleDefinition definitionWithProtocol:@protocol(IMModuleType)
                                         targetClass:[IMViewController class] configuration:^(ModuleDefinition *definition) {
                        definition.scope = ModuleScopeWeakSingleton;
                        [definition defineConstructorMethod:[MethodDefinition classMethod:@selector(initWithUser:)]];
                    }]
    ];
}
@end
