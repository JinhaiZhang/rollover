//
// Created by 王斌 on 2019-01-08.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import "ModuleProvider.h"
#import "ModuleExportType.h"
#import "ModuleDefinition.h"
#import <objc/runtime.h>

static NSMutableDictionary<NSString *, ModuleDefinition * > *instancePlaceholder;
static NSMutableDictionary<NSString *, NSObject *> *container;
static NSMapTable<NSString *, NSObject *> *weakRef;


@implementation ModuleProvider {

}

+ (void)load {
    instancePlaceholder = [NSMutableDictionary new];
    container = [NSMutableDictionary new];
    weakRef = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsStrongMemory
                                        valueOptions:NSPointerFunctionsWeakMemory
                                            capacity:0];
    [self setUp];
}

+ (void)setUp {
    int countOfClass = objc_getClassList(NULL, 0);
    Class *list = (Class *) malloc(sizeof(Class) * countOfClass);
    objc_getClassList(list, countOfClass);
    for (int idx = 0; idx < countOfClass; idx++) {
        Class c = list[idx];
        if (class_conformsToProtocol(c, @protocol(ModuleExportType))) {
            id <ModuleExportType> export = (id <ModuleExportType>) c;
            NSArray < ModuleDefinition * > *services = [export services];
            [services enumerateObjectsUsingBlock:^(ModuleDefinition *obj, NSUInteger idx, BOOL *stop) {
                instancePlaceholder[NSStringFromProtocol(obj.aProtocol)] = obj;
            }];
        }
    }
}

+ (id)request:(Protocol *)aProtocol {
    return [self request:aProtocol params:nil];
}

+ (id)request:(Protocol *)aProtocol params:(id)args, ... {
    NSString *key = NSStringFromProtocol(aProtocol);
    id result = nil;
    @synchronized (self) {
        ModuleDefinition *definition = instancePlaceholder[key];
        if (definition) {
            switch (definition.scope) {
                case ModuleScopeObjectGraph:
                    return [definition createInstance:args];
                case ModuleScopeSingleton: {
                    result = container[key];
                    if (!result) {
                        result = [definition createInstance:args];
                        container[key] = result;
                    }
                    break;
                }
                case ModuleScopeWeakSingleton: {
                    result = [weakRef objectForKey:key];
                    if (!result) {
                        result = [definition createInstance:args];
                        [weakRef setObject:result forKey:key];
                    }
                    break;
                }
                default:
                    break;
            }
        }
    }
    return result;
}


@end
