//
// Created by 王斌 on 2019-01-11.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import "ApplicationStackImp+Demo.h"

@implementation ApplicationStackImp (Demo)
+ (instancetype)manager {
    return self.shared;
}

- (WorkerImp *)worker {
    if ([self.current isKindOfClass:[WorkerImp class]])
        return self.current;
    else
        return nil;
}
@end

@implementation WorkerImp (Demo)
- (User *)appUser {
    return self.user;
}
@end