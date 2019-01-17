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
                                         targetClass:[MallViewController class]
                                       configuration:^(ModuleDefinition *definition) {
                                           [definition defineConstructorMethod:[MethodDefinition classMethod:@selector(initWithCategoryId:)]];
                                       }],
            [ModuleDefinition definitionWithProtocol:@protocol(TestModuleType)
                                         targetClass:[TestModuleImp class]
                                       configuration:^(ModuleDefinition *definition) {
                                           [definition defineConstructorMethod:[MethodDefinition instanceMethod:@selector(initWithPrefix:)]];
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
