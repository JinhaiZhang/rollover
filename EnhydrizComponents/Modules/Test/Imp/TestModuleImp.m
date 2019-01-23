//
// Created by 王斌 on 2019-01-14.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import <ReactiveObjC/RACSubject.h>
#import "TestModuleImp.h"

@interface TestModuleImp ()
@property(readonly) RACSubject *continuousSubject;
@property(readonly) RACSubject<NSString *> *nameSubject;
@property(readonly) NSString *name;
@end

@implementation TestModuleImp

- (id)initWithParams:(NSArray *)params {
    self = [super init];
    _continuousSubject = RACSubject.subject;
    _nameSubject = RACSubject.subject;
    _name = params.firstObject;
    return self;
}

- (RACSignal *)testSignal {
    return [_nameSubject map:^id(NSString *value) {
        return [NSString stringWithFormat:@"%@  %@", self.name, value];
    }];
}

- (void)setName:(NSString *)name {
    [_nameSubject sendNext:name];
}

- (RACSignal *)continuousSignal {
    return self.continuousSubject;
}

- (id <TestModuleInputsType>)inputs {
    return self;
}

- (id <TestModuleOutputsType>)outputs {
    return self;
}

@end
