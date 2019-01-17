#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "Enhydris.h"
#import "ModuleType.h"
#import "Plugin.h"
#import "Request.h"
#import "RequestMakerType.h"
#import "ResponsePipeType.h"
#import "ResponseStatus.h"
#import "ResponseStubType.h"
#import "SampleResponseConfig.h"
#import "ServerConfig.h"
#import "TransformType.h"

FOUNDATION_EXPORT double EnhydrisVersionNumber;
FOUNDATION_EXPORT const unsigned char EnhydrisVersionString[];

