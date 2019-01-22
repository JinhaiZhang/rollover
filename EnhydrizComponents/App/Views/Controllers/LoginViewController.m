//
//  LoginViewController.m
//  EnhydrizComponents
//
//  Created by 王斌 on 2019/1/11.
//  Copyright © 2019 Yamazhiki. All rights reserved.
//

#import "LoginViewController.h"
#import "ApplicationStackImp.h"
#import "User.h"
#import "UINavigationController+ModuleAction.h"
#import "IMModuleType.h"
#import "ModuleProvider.h"
@import Enhydris;

@interface LoginViewController ()
@property(weak, nonatomic) IBOutlet UITextField *username;
@property(weak, nonatomic) IBOutlet UITextField *password;
@property(weak, nonatomic) IBOutlet UIButton *login;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    @weakify(self)
    RAC(self.login, enabled) = [[RACSignal combineLatest:@[
            self.username.rac_textSignal,
            self.password.rac_textSignal
    ]] map:(id (^)(RACTuple *)) ^id(RACTwoTuple<NSString *, NSString *> *value) {
        return @((value.first && [value.first length] > 6) && (value.second && [value.second length] > 6));
    }];

    [[[self.login rac_signalForControlEvents:UIControlEventTouchUpInside] flattenMap:^RACSignal *(__kindof UIControl *value) {
        @strongify(self)
        return self.username.rac_textSignal;
    }] subscribeNext:^(NSString *username) {
        @strongify(self)
        id <ApplicationStackType> app = [ModuleProvider request:@protocol(ApplicationStackType)];
        [app updateUser:[User userWithIdentifier:10 username:username sign:@"南风"]];
        [self dismissViewControllerAnimated:true completion:nil];
    }];
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)toIM:(id)sender {
    [self.navigationController push:@protocol(IMModuleType) animated:YES];
}

@end
