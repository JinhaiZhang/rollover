//
// Created by 王斌 on 2019-01-08.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import "ModuleProvider.h"
#import "ModuleDefinition.h"
#import "ModuleFactory.h"
#import <objc/runtime.h>

static NSMutableDictionary<NSString *, ModuleDefinition * > *instancePlaceholder;
static NSMutableDictionary<NSString *, NSObject *> *container;
static NSMapTable<NSString *, NSObject *> *weakRef;


@implementation ModuleProvider {

}

+ (id)request:(Protocol *)aProtocol {
    return [self request:aProtocol params:nil];
}

+ (id)request:(Protocol *)aProtocol params:(NSArray *)params {
    return [ModuleFactory.defaultFactory obtainModuleByProtocol:aProtocol params:params];
}


@end
