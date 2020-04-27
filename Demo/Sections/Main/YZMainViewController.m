//
//  YZMainViewController.m
//  Demo
//
//  Created by administrator on 2020/4/27.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "YZMainViewController.h"
#import "YZMainViewModel.h"

#import <Masonry/Masonry.h>

@interface YZMainViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YZMainViewModel *viewModel;
@end

@implementation YZMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Demo";
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self constructUI];
}

#pragma mark - private

- (void)constructUI {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellid"];
    }
    
    YZMainItemModel *model = self.viewModel.dataSource[indexPath.row];
    
    cell.textLabel.text = model.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YZMainItemModel *model = self.viewModel.dataSource[indexPath.row];
    UIViewController *vc = [[NSClassFromString(model.vcClassName) alloc] init];
    vc.title = model.title;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (YZMainViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [YZMainViewModel new];
    }
    return _viewModel;
}
@end
