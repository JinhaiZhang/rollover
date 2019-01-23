//
// Created by 王斌 on 2019-01-08.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModuleExport.h"
#import "TestModuleImp.h"
#import "ModuleDefinition.h"
#import "MallViewController.h"
#import "MethodDefinition.h"

@interface ModuleExport ()
@property(readonly) TestModuleImp *imp;
@end


@implementation ModuleExport {

}

- (instancetype)init {
    self = [super init];
    _imp = [[TestModuleImp alloc] init];
    return self;
}

- (NSString *)name {
    return @"Hello world";
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"

+ (NSArray<ModuleDefinition *> *)services {
    return @[
            [ModuleDefinition definitionWithProtocol:@protocol(MallModuleType)
                                       configuration:^NSArray<ModuleConfig *> * {
                                           return @[
                                                   [[ModuleConfig alloc] initWithCls:[MallViewController class]
                                                                     constructMethod:[MethodDefinition methodWithInstance:@selector(initWithCategoryId:)]]];
                                       }],
            [ModuleDefinition definitionWithProtocol:@protocol(TestModuleType) configuration:^NSArray<ModuleConfig *> * {
                return @[
                        [[ModuleConfig alloc] initWithCls:[TestModuleImp class]
                                          constructMethod:[MethodDefinition methodWithInstance:@selector(initWithPrefix:)]]
                ];
            }]
    ];
}

#pragma clang diagnostic pop

- (id <TestModuleInputsType>)inputs {
    return self.imp;
}

- (id <TestModuleOutputsType>)outputs {
    return self.imp;
}

- (void)setName:(NSString *)name {
    [self.imp.inputs setName:name];
}

- (RACSignal *)testSignal {
    return self.imp.outputs.testSignal;
}

- (RACSignal *)continuousSignal {
    return self.imp.outputs.testSignal;
}

+ (instancetype)creator {
    return [ModuleExport new];
}


@end
