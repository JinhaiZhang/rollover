//
// Created by 王斌 on 2019-01-17.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import "ModuleConfig.h"
#import "MethodDefinition.h"

@interface ModuleConfig ()
@end


@implementation ModuleConfig
- (instancetype)initWithCls:(Class)cls {
    return [self initWithCls:cls constructMethod:nil scope:ModuleScopeObjectGraph];
}

- (instancetype)initWithCls:(Class)cls constructMethod:(MethodDefinition *)constructMethod {
    return [self initWithCls:cls constructMethod:constructMethod scope:ModuleScopeObjectGraph];
}

- (instancetype)initWithCls:(Class)cls scope:(ModuleScope)scope {
    return [self initWithCls:cls constructMethod:nil scope:scope];
}

- (instancetype)initWithCls:(Class)cls constructMethod:(MethodDefinition *)constructMethod scope:(ModuleScope)scope {
    self = [super init];
    if (self) {
        _cls = cls;
        if (!constructMethod) {
            constructMethod = [MethodDefinition methodWithString:@"-init"];
        }
        _constructMethod = constructMethod;
        _scope = scope;
    }

    return self;
}


- (id)create:(NSArray *)params {
    ModuleConfig *config = self;
    id result = nil;
    if (config) {
        id classInstance = [config.cls alloc];
        return [classInstance performSelector:@selector(initWithParams:) withObject:params];
    }
    return result;
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[self class]]) {
        ModuleConfig *target = object;
        return [NSStringFromClass(target.cls) isEqualToString:NSStringFromClass(self.cls)];
    }
    return false;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"scope: %d, class: %@", self.scope, NSStringFromClass(self.cls)];
}


@end