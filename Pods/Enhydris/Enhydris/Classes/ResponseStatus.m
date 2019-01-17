//
// Created by Yamazhiki on 2018/7/24.
// Copyright (c) 2018 AsiaInnovations. All rights reserved.
//

#import "ResponseStatus.h"


@implementation ResponseStatus {

}
- (instancetype)initWithData:(id)data serverCode:(NSInteger)serverCode error:(NSError *)error {
    self = [super init];
    _data = data;
    _serverCode = serverCode;
    _error = error;
    return self;
}

- (NSInteger)code {
    if (_serverCode) return _serverCode;
    return _error ? _error.code : 0;
}

@end