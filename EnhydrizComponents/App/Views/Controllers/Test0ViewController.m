//
//  Test0ViewController.m
//  EnhydrizComponents
//
//  Created by 王斌 on 2019/1/11.
//  Copyright © 2019 Yamazhiki. All rights reserved.
//

#import "Test0ViewController.h"
#import "ModuleProvider.h"
#import "ApplicationStackType.h"

@interface Test0ViewController ()

@end

@implementation Test0ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    id app = [ModuleProvider request:@protocol(ApplicationStackType)];
    NSLog(@"---->%@", app);
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
