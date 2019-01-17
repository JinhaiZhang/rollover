//
// Created by 王斌 on 2019-01-08.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ServiceExportType <NSObject>
@property(readonly) NSString *name;
@property(readonly) NSString *action;
@property(readonly) Protocol *aProtocol;
@end