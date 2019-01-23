//
// Created by 王斌 on 2019-01-14.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/message.h>
#import "ModuleDefinition.h"

#define NSArrayObjectMaybeNil(__ARRAY__, __INDEX__) ((__INDEX__ >= [__ARRAY__ count]) ? nil : [__ARRAY__ objectAtIndex:__INDEX__])

#define Args(__ARRAY_NAME__)\
NSArrayObjectMaybeNil(__ARRAY_NAME__, 0),\
NSArrayObjectMaybeNil(__ARRAY_NAME__, 1),\
NSArrayObjectMaybeNil(__ARRAY_NAME__, 2),\
NSArrayObjectMaybeNil(__ARRAY_NAME__, 3),\
NSArrayObjectMaybeNil(__ARRAY_NAME__, 4),\
NSArrayObjectMaybeNil(__ARRAY_NAME__, 5),\
NSArrayObjectMaybeNil(__ARRAY_NAME__, 6),\
NSArrayObjectMaybeNil(__ARRAY_NAME__, 7),\
NSArrayObjectMaybeNil(__ARRAY_NAME__, 8),\
NSArrayObjectMaybeNil(__ARRAY_NAME__, 9),\
nil

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


- (id)obtainInstance:(NSArray *)params {
    if (self.configCollection.firstObject)
        return [self.configCollection.firstObject create:params];
    return nil;
}

- (void)addConfigs:(NSArray<ModuleConfig *> *)configs {
    NSMutableArray *source = [NSMutableArray arrayWithArray:configs];
    [source removeObjectsInArray:self.configCollection];
    NSMutableSet *ori = [NSMutableSet setWithArray:source];
    NSMutableSet *in = [NSMutableSet setWithArray:configs];
    [ori unionSet:in];
    self.configCollection = ori.allObjects;
}


@end
