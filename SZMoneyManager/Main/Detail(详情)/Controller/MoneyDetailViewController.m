//
//  MoneyDetailViewController.m
//  SZMoneyManager
//
//  Created by 张杰华 on 2019/3/20.
//  Copyright © 2019 张杰华. All rights reserved.
//

#import "MoneyDetailViewController.h"
#import "MoneyAddViewController.h"

@interface MoneyDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *detailTitleArray;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MoneyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _titleArray = @[
                    @"类别",
                    @"收支",
                    @"金额",
                    @"日期",
                    @"备注"
                    ];
    _detailTitleArray = @[
                          _model.type,
                          _model.inOutC,
                          _model.costString,
                          [_model.insertTime stringByAppendingString:_model.weekDayC],
                          _model.remark
                          ];
    [self setupUI];
}

- (void)deleteBtnAction
{
    [self sz_presentAlertView:@"确定删除?" completion:^(NSInteger index) {
        if (index == 1) {
            [[SZMoneyManager defaultManager] delete:self.model];
            self.reload();
            [self.navigationController popViewControllerAnimated:true];
        }
    }];
}

- (void)editBtnAction
{
    MoneyAddViewController *vc = [[MoneyAddViewController alloc]init];
    vc.model = _model;
    vc.sendBlock = ^(SZMoneyModel *model) {
        [[SZMoneyManager defaultManager] update:model];

        self.detailTitleArray = @[
                              self.model.type,
                              self.model.inOutC,
                              self.model.costString,
                              [self.model.insertTime stringByAppendingString:self.model.weekDayC],
                              self.model.remark
                              ];
        [self.tableView reloadData];
        self.reload();
    };
    [self.navigationController pushViewController:vc animated:true];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellReuseIdentifier];
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.detailTextLabel.text = _detailTitleArray[indexPath.row];
    return cell;
}

- (void)setupUI {
    self.navigationItem.rightBarButtonItems = @[
                                                [[UIBarButtonItem alloc]initWithTitle:@"删除" style:UIBarButtonItemStyleDone target:self action:@selector(deleteBtnAction)],
                                                [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(editBtnAction)]];

    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableFooterView = [[UIView alloc]init];
    [tableView registerClass:UITableViewCell.class forCellReuseIdentifier:CellReuseIdentifier];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
}

@end
