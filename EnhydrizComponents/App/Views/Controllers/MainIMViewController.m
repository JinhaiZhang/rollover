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
#import "ModuleResponse.h"

@interface MainIMViewController ()
@property(nonatomic, retain) UIViewController <IMModuleType> *vc;
@end

@implementation MainIMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!self.vc) {
        ModuleResponse *response = [ModuleProvider request:@protocol(IMModuleType) params:@[@"Yamazhiki"]];
        self.vc = response.object;
    }
    self.vc.view.frame = self.view.bounds;
    [self.view addSubview:self.vc.view];
    [self addChildViewController:self.vc];
}

- (IBAction)clear:(id)sender {
    if (self.vc) {
        [self.vc willMoveToParentViewController:nil];
        [self.vc.view removeFromSuperview];
        [self.vc removeFromParentViewController];
        [self.vc didMoveToParentViewController:nil];
        self.vc = nil;
    }
}

@end
