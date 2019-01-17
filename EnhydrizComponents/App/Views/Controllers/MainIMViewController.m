//
//  MainIMViewController.m
//  App
//
//  Created by 王斌 on 2019/1/16.
//  Copyright © 2019 Yamazhiki. All rights reserved.
//

#import "MainIMViewController.h"
#import "IMModuleType.h"
#import "ModuleProvider.h"

@interface MainIMViewController ()

@end

@implementation MainIMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIViewController <IMModuleType> *vc = [ModuleProvider request:@protocol(IMModuleType)];
    vc.view.frame = self.view.bounds;
    [self.view addSubview:vc.view];
    [self addChildViewController:vc];

    // Do any additional setup after loading the view.
}

@end
