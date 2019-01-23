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
@property(weak, nonatomic) IBOutlet UISegmentedControl *segementControl;
@property(nonatomic) UIViewController <IMModuleType> *vc;
@end

@implementation MainIMViewController

- (IBAction)loadModule:(id)sender {
    [self clear:sender];
    ModuleResponse *response = [ModuleProvider request:@protocol(IMModuleType)
                                                params:@[@"Yamazhiki"]
                                             condition:(ModuleIndex) self.segementControl.selectedSegmentIndex];
    NSLog(@"%@", response);
    self.vc = response.object;
    self.vc.view.frame = self.view.bounds;
    [self.view addSubview:self.vc.view];
    [self addChildViewController:self.vc];
}

- (IBAction)clear:(id)sender {
    if (self.vc) {
        [self.vc willMoveToParentViewController:nil];
        [self.vc.view removeFromSuperview];
        [self.vc removeFromParentViewController];
        self.vc = nil;
    }
}

@end
