//
//  HomePageViewController.m
//  SZMoneyManager
//
//  Created by 张杰华 on 2019/3/19.
//  Copyright © 2019 张杰华. All rights reserved.
//

#import "HomePageViewController.h"
#import "MoneyAddViewController.h"
#import "MoneyDetailViewController.h"
#import "HomePageHeaderView.h"
#import "HomePageSectionHeaderView.h"
#import "HomePageTableViewCell.h"
#import "SZMoneyModel.h"
#import "SZMoneySectionModel.h"
#import "PGDatePickManager+Category.h"
#import <YYKit.h>

@interface HomePageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray<SZMoneySectionModel *> *dataArray;

@property (nonatomic, strong) HomePageHeaderView *headerView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSDate *selectedDate;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _selectedDate = [NSDate date];
    _dataArray = [NSMutableArray array];
    [self setupUI];

    [self filterAllModelArray];

}

- (void)filterAllModelArray
{
    //全部数据
    NSMutableArray<SZMoneyModel *> *allModelArray = [SZMoneyManager defaultManager].allModelArray.mutableCopy;
    //过滤掉非本月的
    [allModelArray filterUsingPredicate:[NSPredicate predicateWithFormat:@"year = %@",[NSString stringWithFormat:@"%ld",_selectedDate.year]]];
    [allModelArray filterUsingPredicate:[NSPredicate predicateWithFormat:@"month = %@",[NSString stringWithFormat:@"%ld",_selectedDate.month]]];
    //按日期由大到小
    [allModelArray sortUsingComparator:^NSComparisonResult(SZMoneyModel *obj1, SZMoneyModel *obj2) {
        return [obj1.insertTime compare:obj2.insertTime] == NSOrderedAscending;
    }];
    //组成数据源
    [_dataArray removeAllObjects];
    for (NSInteger i = 0; i < allModelArray.count; i++) {
        SZMoneyModel *model = allModelArray[i];
        if (i > 0 && [model.insertTime isEqualToString:allModelArray[i - 1].insertTime]) {

        }else{
            SZMoneySectionModel *sectionModel = [[SZMoneySectionModel alloc]init];
            sectionModel.insertTime = model.insertTime;
            sectionModel.weekDayC = model.weekDayC;
            [_dataArray addObject:sectionModel];
        }
        if (model.cost >= 0) {
            //收入
            _dataArray.lastObject.totalIn += model.cost;
        } else {
            _dataArray.lastObject.totalOut += model.cost;
        }
        [_dataArray.lastObject.modelArray addObject:model];
    }

    [self countHeader];
    [_tableView reloadData];
}

- (void)dateBtnAction:(UIButton *)button
{
    PGDatePickManager *datePickManager = [PGDatePickManager YEBStyle];
    datePickManager.datePicker.datePickerMode = PGDatePickerModeYearAndMonth;
    [datePickManager.datePicker setDate:_selectedDate];
    [self presentViewController:datePickManager animated:false completion:nil];

    datePickManager.datePicker.selectedDate = ^(NSDateComponents *dateComponents) {
        self.selectedDate = [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
        [button setTitle:[self.selectedDate stringWithFormat:SZDateFormtyM] forState:UIControlStateNormal];

        //过滤指定月份的数据
        [self filterAllModelArray];
    };
}

- (void)addAction
{
    MoneyAddViewController *vc = [[MoneyAddViewController alloc]init];
    vc.sendBlock = ^(SZMoneyModel *model) {
        NSArray<SZMoneySectionModel *> *resultArray = [self.dataArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"insertTime = %@",model.insertTime]];
        if (resultArray.count > 0) {
            [resultArray.firstObject.modelArray addObject:model];
        }else{
            //未有日期
            SZMoneySectionModel *sectionModel = [[SZMoneySectionModel alloc]init];
            sectionModel.insertTime = model.insertTime;
            sectionModel.weekDayC = model.weekDayC;
            [self.dataArray addObject:sectionModel];

            [self.dataArray.lastObject.modelArray addObject:model];
            if (model.cost >= 0) {
                //收入
                self.dataArray.lastObject.totalIn += model.cost;
            } else {
                self.dataArray.lastObject.totalOut += model.cost;
            }
        }

        [self.dataArray sortUsingComparator:^NSComparisonResult(SZMoneyModel *obj1, SZMoneyModel *obj2) {
            return [obj1.insertTime compare:obj2.insertTime] == NSOrderedAscending;
        }];

        [self.tableView reloadData];
        [self countHeader];

        [[SZMoneyManager defaultManager] add:model];
    };
    [self.navigationController pushViewController:vc animated:true];
}

- (void)countHeader
{
    CGFloat totalIn = 0;
    CGFloat totalOut = 0;
    for (SZMoneySectionModel *sectionModel in _dataArray) {
        totalIn += sectionModel.totalIn;
        totalOut += sectionModel.totalOut;
    }

    _headerView.inLabel.text = [NSString stringWithFormat:@"收入\n%.2f",totalIn];
    _headerView.outLabel.text = [NSString stringWithFormat:@"支出\n%.2f",-totalOut];
    _headerView.resutlLabel.text = [NSString stringWithFormat:@"结余\n%.2f",totalIn + totalOut];
}

#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray[section].modelArray.count;
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
    view.sectionModel = _dataArray[section];
    view.frame = CGRectMake(0, 0, SZ_SCREEN_WIDTH, 30);
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomePageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.model = _dataArray[indexPath.section].modelArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:false];
    MoneyDetailViewController *vc = [[MoneyDetailViewController alloc]init];
    vc.model = _dataArray[indexPath.section].modelArray[indexPath.row];
    vc.reload = ^{
        [self filterAllModelArray];
    };
    [self.navigationController pushViewController:vc animated:true];
}

- (void)setupUI {

    UIButton *dateBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [dateBtn addTarget:self action:@selector(dateBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [dateBtn setTitle:[[NSDate date] stringWithFormat:SZDateFormtyM] forState:UIControlStateNormal];
    [dateBtn sizeToFit];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:dateBtn];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStyleDone target:self action:@selector(addAction)];

    HomePageHeaderView *headerView = [[HomePageHeaderView alloc]init];
    headerView.frame = CGRectMake(0, 0, SZ_SCREEN_WIDTH, 100);
    self.headerView = headerView;

    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = DefaultBackgroundColor;
    tableView.tableHeaderView = headerView;
    [tableView registerClass:HomePageTableViewCell.class forCellReuseIdentifier:@"cell"];
    [tableView registerClass:HomePageSectionHeaderView.class forHeaderFooterViewReuseIdentifier:@"header"];
    [self.view addSubview:tableView];
    self.tableView = tableView;

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
