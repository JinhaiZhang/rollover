//
// Created by 王斌 on 2019-01-10.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ApiMode) {
    /*测试环境*/
            ApiModeStage,
    /*正式环境*/
            ApiModeProduction
};

@protocol ApiConfigType <NSObject>
/**
 * Api主地址
 */
@property(readonly) NSString *baseUrl;
/**
 * 所属Mode
 */
@property(readonly) ApiMode mode;
@end