//
// Created by 王斌 on 2019-01-14.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/message.h>
#import "ModuleDefinition.h"

@interface ModuleDefinition ()

@property(nonatomic, readwrite) NSArray<ModuleConfig *> *configCollection;

- (instancetype)initWithProtocol:(Protocol *)aProtocol;

@end

@implementation ModuleDefinition


- (instancetype)initWithProtocol:(Protocol *)aProtocol {
    self = [super init];
    if (self) {
        _aProtocol = aProtocol;
    }
    return self;
}

+ (instancetype)definitionWithProtocol:(Protocol *)aProtocol configuration:(NSArray<ModuleConfig *> *(^)(void))configuration {
    ModuleDefinition *definition = [[ModuleDefinition alloc] initWithProtocol:aProtocol];
    if (configuration) {
        definition.configCollection = [NSMutableSet setWithArray:configuration()].allObjects;
    }
    return definition;
}

- (ModuleConfig *)objectAtIndexedSubscript:(NSUInteger)idx {
    return self.configCollection[idx];
}

- (void)addConfigs:(NSArray<ModuleConfig *> *)configs {

    __block NSMutableArray *temp = [NSMutableArray arrayWithArray:self.configCollection];

    [configs enumerateObjectsUsingBlock:^(ModuleConfig *obj, NSUInteger idx, BOOL *stop) {
        if ([temp containsObject:obj]) {
            [temp removeObject:obj];
        }

        [temp addObject:obj];
    }];
    self.configCollection = temp;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@", @{@"Protocol": NSStringFromProtocol(self.aProtocol), @"configs": self.configCollection}];
}


@end
