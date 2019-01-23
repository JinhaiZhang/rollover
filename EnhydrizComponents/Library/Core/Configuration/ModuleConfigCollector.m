//
// Created by 王斌 on 2019-01-22.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import "ModuleConfigCollector.h"
#import "ModuleJsonConfigProcessor.h"

static NSString *ModuleConfigJsonFileName = @"moduleConfigs";

@interface ModuleConfigCollector ()
@property(readonly) id appDelegate;
@end

@implementation ModuleConfigCollector
- (instancetype)initWithAppDelegate:(id)appDelegate {
    self = [super init];
    _appDelegate = appDelegate;
    return self;
}

- (NSArray *)retrieveConfig {
    NSMutableArray *result = [NSMutableArray array];
    [result addObjectsFromArray:[self retrieveConfigFromAppDelegate]];
    [result addObjectsFromArray:[self retrieveConfigFromJson]];
    return result;
}

- (NSArray *)retrieveConfigFromJson {
    NSBundle *bundle = [NSBundle bundleForClass:[self.appDelegate class]];
    NSString *configPath = [bundle pathForResource:ModuleConfigJsonFileName ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:configPath];
    NSError *error;
    NSArray<NSDictionary<NSString *, NSDictionary *> *> *configs = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSMutableArray *array = [NSMutableArray array];
    if (!error) {
        for (id item in configs) {
            [array addObject:[ModuleJsonConfigProcessor process:item]];;
        }
    }
    return array;
}

- (NSArray *)retrieveConfigFromAppDelegate {
    if ([self.appDelegate respondsToSelector:@selector(moduleConfigFileNames)]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        return [self.appDelegate performSelector:@selector(moduleConfigFileNames)];
#pragma clang diagnostic pop
    }
    return @[];
}


@end