//
//  Test1ViewController.m
//  EnhydrizComponents
//
//  Created by 王斌 on 2019/1/11.
//  Copyright © 2019 Yamazhiki. All rights reserved.
//

#import "Test1ViewController.h"
#import "ApplicationStackImp+Demo.h"
#import "TestModuleType.h"
#import "ModuleProvider.h"
#import "MallModuleType.h"
#import "MallModel.h"

@interface Test1ViewModel : NSObject
@property(nonatomic) RACSignal *userInfoUpdate;
@end

@implementation Test1ViewModel
- (instancetype)init {
    self = [super init];
    id <ApplicationStackType> stack = [ModuleProvider request:@protocol(ApplicationStackType)];
    _userInfoUpdate = [RACSignal merge:@[
            [stack.events filter:^BOOL(NSNumber *value) {
                return AppEnvEventTypeUserInfoUpdate == value.integerValue;
            }],
            [RACSignal return:RACUnit.defaultUnit]
    ]];
    return self;
}
@end

@interface Test1ViewController ()

@property(weak, nonatomic) IBOutlet UILabel *login;
@property(weak, nonatomic) IBOutlet UILabel *moduleLabel;

@property(nonatomic) Test1ViewModel *viewModel;
@property(nonatomic) id <TestModuleType> remoteModule;
@property(weak, nonatomic) IBOutlet UIView *containerView;
@end

@implementation Test1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    id app = [ModuleProvider request:@protocol(ApplicationStackType)];
    NSLog(@"---->%@", app);
    [self bindViewModel];
    // Do any additional setup after loading the view.
}

- (void)bindViewModel {

    //self.viewModel = [ModuleProvider request:@protocol(ApplicationStackType)];

    self.viewModel = [[Test1ViewModel alloc] init];
    @weakify(self)
    [self.viewModel.userInfoUpdate subscribeNext:^(id x) {
        @strongify(self)
        id <ApplicationStackType> stack = [ModuleProvider request:@protocol(ApplicationStackType)];
        WorkerImp *imp = stack.current;
        self.login.text = imp.appUser.username;
    }];
}


- (IBAction)loadModule:(id)sender {
    @weakify(self)
/*这我们加载TestModule*/
    self.remoteModule = [ModuleProvider request:@protocol(TestModuleType) params:@"Hello"];
    [self bindNewViewModel];

    UIViewController <MallModuleType> *viewController = [ModuleProvider request:@protocol(MallModuleType) params:@1];
    viewController.view.frame = self.containerView.bounds;
    [self.containerView addSubview:viewController.view];
    [self addChildViewController:viewController];
    [viewController.outputs.didSelectProduct subscribeNext:^(Product *x) {
        @strongify(self)
        self.moduleLabel.text = [NSString stringWithFormat:@"你选择了 %@", x.name];
    }];
}

- (void)bindNewViewModel {
    @weakify(self)
    [self.remoteModule.outputs.testSignal subscribeNext:^(NSString *x) {
        @strongify(self)
        self.moduleLabel.text = x;
    }];

}

- (IBAction)applyModule:(id)sender {
    [self.remoteModule.inputs setName:@"Yamazhiki"];
}

@end
