//
// Created by 王斌 on 2019-01-14.
// Copyright (c) 2019 Yamazhiki. All rights reserved.
//

#import "MallViewController.h"
#import "MallModel.h"
#import "ModuleCreatorType.h"

@interface MallViewController () <UITableViewDelegate, UITableViewDataSource, MallModuleOutputsType, MallModuleInputsType, ModuleCreatorType>
@property(weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic) NSArray<Product *> *products;
@property(nonatomic) NSInteger categoryId;

/*For module type*/
@property(nonatomic) RACSubject<Product *> *selectProductSubject;
@end

@implementation MallViewController {

}


+ (instancetype)initWithCategoryId:(NSNumber *)categoryId {
    MallViewController *rlt = [UIStoryboard storyboardWithName:@"Mall" bundle:nil].instantiateInitialViewController;
    rlt.categoryId = categoryId.integerValue;
    return rlt;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectProductSubject = RACSubject.subject;
    self.products = @[
            [[Product alloc] initWithProductID:1 name:@"茶杯"],
            [[Product alloc] initWithProductID:2 name:@"茶几"]];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = self.products[(NSUInteger) indexPath.row].name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.selectProductSubject sendNext:self.products[(NSUInteger) indexPath.row]];
}

- (id <MallModuleInputsType>)inputs {
    return self;
}

- (id <MallModuleOutputsType>)outputs {
    return self;
}

- (RACSignal<Product *> *)didSelectProduct {
    return self.selectProductSubject;
}

@end

