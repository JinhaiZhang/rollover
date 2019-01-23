//
//  IMViewController.m
//  IM
//
//  Created by 王斌 on 2019/1/15.
//  Copyright © 2019 Yamazhiki. All rights reserved.
//

#import "IMViewController.h"
#import "ApplicationStackType.h"
#import "ModuleProvider.h"
#import "User.h"
#import "MallModuleType.h"
#import "ModuleCreatorType.h"

@interface IMViewController () <ModuleCreatorType>
@property(nonatomic) NSString *userName;
@property(weak, nonatomic) IBOutlet UITextField *nameInput;
@end

@implementation IMViewController


- (id)initWithParams:(NSArray *)params {
    self = [super initWithNibName:@"IM" bundle:nil];
    self.userName = params[0];
    return self;
}

+ (instancetype)initWithUser:(id <MallModuleType>)userName {
    IMViewController *im = [[IMViewController alloc] initWithNibName:@"IM" bundle:nil];
    return im;
}

- (instancetype)initWithUser:(NSString *)userName {
    self = [super initWithNibName:@"IM" bundle:nil];
    self.userName = userName;
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)changeName:(id)sender {
    id <ApplicationStackType> applicationStack = [ModuleProvider request:@protocol(ApplicationStackType)].object;
    [applicationStack updateUser:[[User alloc] initWithIdentifier:10 username:self.nameInput.text sign:@""]];
}

@end
