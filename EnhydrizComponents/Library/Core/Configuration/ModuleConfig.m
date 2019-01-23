//
// Created by 王斌 on 2019-01-17.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import "ModuleConfig.h"

@interface ModuleConfig ()
@end


@implementation ModuleConfig
- (instancetype)initWithCls:(Class)cls {
    return [self initWithCls:cls scope:ModuleScopePrototype];
}

- (instancetype)initWithCls:(Class)cls scope:(ModuleScope)scope {
    self = [super init];
    if (self) {
        _cls = cls;
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