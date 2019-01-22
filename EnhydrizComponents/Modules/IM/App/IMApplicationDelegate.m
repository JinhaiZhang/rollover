//
//  IMApplicationDelegate.m
//  IM
//
//  Created by 王斌 on 2019/1/15.
//  Copyright © 2019 Yamazhiki. All rights reserved.
//

#import "IMApplicationDelegate.h"
#import "IMViewController.h"

@interface IMApplicationDelegate ()
@end

@implementation IMApplicationDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[IMViewController alloc] initWithNibName:@"IM" bundle:nil];
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {

}


- (void)applicationDidEnterBackground:(UIApplication *)application {

}


- (void)applicationWillEnterForeground:(UIApplication *)application {
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
}


- (void)applicationWillTerminate:(UIApplication *)application {
}


@end
