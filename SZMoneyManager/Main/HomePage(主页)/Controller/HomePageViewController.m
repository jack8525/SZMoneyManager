//
//  HomePageViewController.m
//  SZMoneyManager
//
//  Created by 张杰华 on 2019/3/19.
//  Copyright © 2019 张杰华. All rights reserved.
//

#import "HomePageViewController.h"
#import "HomePageSectionHeaderView.h"
#import "HomePageTableViewCell.h"

@interface HomePageViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HomePageSectionHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    view.frame = CGRectMake(0, 0, SZ_SCREEN_WIDTH, 30);
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomePageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:false];
}

- (void)setupUI {
    UIView *headerView = [[UIView alloc]init];
    headerView.frame = CGRectMake(0, 0, SZ_SCREEN_WIDTH, 100);

    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = DefaultBackgroundColor;
    tableView.tableHeaderView = headerView;
    [tableView registerClass:HomePageTableViewCell.class forCellReuseIdentifier:@"cell"];
    [tableView registerClass:HomePageSectionHeaderView.class forHeaderFooterViewReuseIdentifier:@"header"];
    [self.view addSubview:tableView];

    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
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
