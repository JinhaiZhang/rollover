//
// Created by 王斌 on 2019-01-22.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import <GameplayKit/GameplayKit.h>
#import <objc/runtime.h>
#import "ModuleFactory.h"
#import "ModuleDefinition.h"
#import "ModuleExportType.h"
#import "ModuleResponse.h"

@interface ModuleFactory ()
@property(readonly) NSMutableDictionary<NSString *, ModuleDefinition * > *definitions;
@property(readonly) NSMutableDictionary<NSString *, NSObject *> *singletonRefs;
@property(readonly) NSMapTable<NSString *, NSObject *> *weakRefs;
@end

@implementation ModuleFactory

+ (instancetype)defaultFactory {
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[ModuleFactory alloc] init];
    });

    return _sharedInstance;
}


- (instancetype)init {
    self = [super init];
    _definitions = [NSMutableDictionary new];
    _singletonRefs = [NSMutableDictionary new];
    _weakRefs = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsStrongMemory
                                          valueOptions:NSPointerFunctionsWeakMemory
                                              capacity:0];
    [self setUp];
    return self;
}

- (void)setUp {
    int countOfClass = objc_getClassList(NULL, 0);
    Class *list = (Class *) malloc(sizeof(Class) * countOfClass);
    objc_getClassList(list, countOfClass);
    for (int idx = 0; idx < countOfClass; idx++) {
        Class c = list[idx];
        if (class_conformsToProtocol(c, @protocol(ModuleExportType))) {
            id <ModuleExportType> export = (id <ModuleExportType>) c;
            NSArray < ModuleDefinition * > *services = [export services];
            [services enumerateObjectsUsingBlock:^(ModuleDefinition *obj, NSUInteger idx, BOOL *stop) {
                self.definitions[NSStringFromProtocol(obj.aProtocol)] = obj;
            }];
        }
    }
}

- (void)combineWithObtainedConfigs:(NSArray<NSDictionary<NSString *, NSArray<ModuleConfig *> *> *> *)configs {
    [configs enumerateObjectsUsingBlock:^(NSDictionary<NSString *, NSArray<ModuleConfig *> *> *obj, NSUInteger idx, BOOL *stop) {
        if (obj.count) {
            NSString *protocolString = obj.allKeys.firstObject;
            ModuleDefinition *definition = self.definitions[protocolString];
            if (!definition) {
                definition = [ModuleDefinition definitionWithProtocol:NSProtocolFromString(protocolString) configuration:^NSArray<ModuleConfig *> * {
                    return @[];
                }];
                self.definitions[protocolString] = definition;
            }
            [definition addConfigs:obj.allValues.firstObject];
        }
    }];
}


- (ModuleResponse *)obtainModuleByProtocol:(Protocol *)aProtocol params:(NSArray *)params condition:(ModuleIndex)condition {
    NSString *key = NSStringFromProtocol(aProtocol);
    ModuleDefinition *definition = _definitions[key];
    if (definition) {
        ModuleConfig *config = definition[condition];
        id instance = nil;
        switch (config.scope) {
            case ModuleScopePrototype: {
                instance = [config create:params];
                break;
            }
            case ModuleScopeSingleton: {
                instance = self.singletonRefs[key];
                if (!instance)
                    instance = [config create:params];
                self.singletonRefs[key] = instance;
                break;
            }
            case ModuleScopeWeakSingleton: {
                instance = [self.weakRefs objectForKey:key];
                if (!instance)
                    instance = [config create:params];
                [self.weakRefs setObject:instance forKey:key];
                break;
            }
            default:
                break;
        }
        return [ModuleResponse responseWithObject:instance];
    } else {
        return [ModuleResponse responseWithError:[NSError errorWithDomain:@"com.isa.enhydriz" code:404 userInfo:@{@"protocol": NSStringFromProtocol(aProtocol)}]];
    }
}

@end