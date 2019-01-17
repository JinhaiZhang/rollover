//
// Created by 王斌 on 2018/5/24.
// Copyright (c) 2018 Yamazhiki. All rights reserved.
//

#import <pthread.h>
#import "ApplicationStackImp.h"
#import "UserType.h"
#import "WorkerImp.h"
#import "ApiConfig.h"

static pthread_rwlock_t lock = PTHREAD_RWLOCK_INITIALIZER;

@interface ApplicationStackImp ()
@property(readonly) RACSubject *eventsSubject;
@property(readonly) NSMutableArray<id <MotorType>> *stack;
@end

@implementation ApplicationStackImp

- (instancetype)init {
    self = [super init];
    if (self) {
        _stack = [NSMutableArray array];
        _eventsSubject = [RACSubject subject];
        [self.stack addObject:[[WorkerImp alloc] initWithUser:nil api:[[ApiConfig alloc] initWithMode:ApiModeStage].base]];
    }
    return self;
}

+ (ApplicationStackImp *)shared {
    static ApplicationStackImp *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ApplicationStackImp alloc] init];
    });
    return instance;
}

- (RACSignal *)events {
    return self.eventsSubject;
}

- (void)switchApiConfig:(ApiConfig *)apiConfig {
    WorkerImp *imp = [WorkerImp impWithUser:(id) self.current.user api:apiConfig.base];
    [self _replaceEnv:imp];
    [self.eventsSubject sendNext:@(AppEnvEventTypeEnvChanged)];
}

- (void)switchLanguage:(id <LanguageType>)language {
}

- (void)updateUser:(id <UserType>)user {
    WorkerImp *imp = [[WorkerImp alloc] initWithUser:(id) user api:self.current.api];
    [self _replaceEnv:imp];
    if (user)
        [self.eventsSubject sendNext:@(AppEnvEventTypeUserInfoUpdate)];
    else
        [self.eventsSubject sendNext:@(AppEnvEventTypeUserLogout)];
}

- (WorkerImp *)current {
    pthread_rwlock_rdlock(&lock);
    id <MotorType> env = self.stack.lastObject;
    pthread_rwlock_unlock(&lock);
    return env;
}

- (void)_replaceEnv:(WorkerImp *)env {
    pthread_rwlock_rdlock(&lock);
    [self.stack addObject:env];
    [self.stack removeObjectAtIndex:self.stack.count - 2];
    pthread_rwlock_unlock(&lock);
}
@end

