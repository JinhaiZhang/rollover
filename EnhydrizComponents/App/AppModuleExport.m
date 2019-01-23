//
// Created by 王斌 on 2019-01-15.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import "AppModuleExport.h"
#import "ModuleDefinition.h"
#import "ApplicationStackImp.h"


@implementation AppModuleExport
+ (NSArray<ModuleDefinition *> *)services {
    return @[
            [ModuleDefinition definitionWithProtocol:@protocol(ApplicationStackType)
                                       configuration:^NSArray<ModuleConfig *> * {
                                           return @[
                                                   [[ModuleConfig alloc] initWithCls:[ApplicationStackImp class] scope:ModuleScopeSingleton]];
                                       }]
    ];
}
@end
