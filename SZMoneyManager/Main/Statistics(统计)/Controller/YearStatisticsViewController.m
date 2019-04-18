//
//  YearStatisticsViewController.m
//  SZMoneyManager
//
//  Created by 张杰华 on 2019/3/22.
//  Copyright © 2019 张杰华. All rights reserved.
//

#import "YearStatisticsViewController.h"
#import "SZMoneyManager-Bridging-Header.h"
#import <YYKit.h>
#import "PGDatePickManager+Category.h"

@interface YearStatisticsViewController ()<ChartViewDelegate,IChartAxisValueFormatter>

@property (nonatomic, strong) BarChartView *chartView;
@property (nonatomic, strong) UILabel *inTextLabel;
@property (nonatomic, strong) UILabel *outTextLabel;
@property (nonatomic, strong) UILabel *resultTextLabel;

@property (nonatomic, strong) NSDate *selectedDate;
@property (nonatomic, strong) NSArray<SZMoneySectionModel *> *monthArray;

@end

@implementation YearStatisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _selectedDate = [NSDate date];
    [self setupUI];
}

- (void)dateBtnAction:(UIButton *)button
{
    PGDatePickManager *datePickManager = [PGDatePickManager YEBStyle];
    datePickManager.datePicker.datePickerMode = PGDatePickerModeYear;
    [datePickManager.datePicker setDate:_selectedDate];
    [self presentViewController:datePickManager animated:false completion:nil];

    datePickManager.datePicker.selectedDate = ^(NSDateComponents *dateComponents) {
        self.selectedDate = [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
        [button setTitle:[NSString stringWithFormat:@"%ld",self.selectedDate.year] forState:UIControlStateNormal];

        //过滤指定月份的数据
        [self filterAllModelArray];
    };
}

- (void)setupUI {

    UIButton *dateBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [dateBtn setTitle:[NSString stringWithFormat:@"%ld",_selectedDate.year] forState:UIControlStateNormal];
    [dateBtn addTarget:self action:@selector(dateBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [dateBtn sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:dateBtn];

    BarChartView *chartView = [[BarChartView alloc]init];
    [self.view addSubview:chartView];
    self.chartView = chartView;

    [chartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-100);
    }];

    chartView.scaleYEnabled = false;
    chartView.doubleTapToZoomEnabled = false;
    //是否可以滑动
    chartView.dragEnabled = true;
    //是否启动缩放
    [chartView setScaleEnabled:true];

    chartView.delegate = self;

//    chartView.extraTopOffset = -0;
//    chartView.extraBottomOffset = 0;
//    chartView.extraLeftOffset = 0;
//    chartView.extraRightOffset = 0;

    //是否绘制阴影
    chartView.drawBarShadowEnabled = false;
    //如果设置为true，则所有值都会在其条形图上方绘制，而不是在其顶部之下
    chartView.drawValueAboveBarEnabled = true;
    //不明
    chartView.chartDescription.enabled = true;
    //标志，指示是否启用了缩放缩放。 如果为真，则x轴和y轴可以用2个手指同时缩放，如果为假，则可以分别缩放x和y轴
    chartView.pinchZoomEnabled = false;
    //标志，指示是否应绘制网格背景
    chartView.drawGridBackgroundEnabled = false;

    //x轴
    ChartXAxis *xAxis = chartView.xAxis;
    //x轴在底部
    xAxis.labelPosition = XAxisLabelPositionBottom;
    //x轴字体
    xAxis.labelFont = [UIFont systemFontOfSize:13.f];
    //是否绘制x轴垂直线
    xAxis.drawGridLinesEnabled = false;
    //是否绘制x轴水平线
    xAxis.drawAxisLineEnabled = false;
    //字颜色
    xAxis.labelTextColor = [UIColor lightGrayColor];
    //
//    xAxis.labelCount = 5;
    //标签居中
    xAxis.centerAxisLabelsEnabled = false;
//    xAxis.granularity = 1.0;
    xAxis.valueFormatter = self;

    ChartYAxis *leftAxis = _chartView.leftAxis;
    leftAxis.drawLabelsEnabled = true;
    leftAxis.spaceTop = 0.25;
    leftAxis.spaceBottom = 0.25;
    leftAxis.drawAxisLineEnabled = false;
    leftAxis.drawGridLinesEnabled = false;
    leftAxis.drawZeroLineEnabled = true;
    leftAxis.zeroLineColor = UIColor.grayColor;
    leftAxis.zeroLineWidth = 0.7f;

    chartView.rightAxis.enabled = false;
    chartView.legend.enabled = false;

    [chartView.viewPortHandler setMinimumScaleX:1.5];

    UILabel *inLabel = [[UILabel alloc]init];
    inLabel.text = @"收入: ";
    inLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:inLabel];

    UILabel *inTextLabel = [[UILabel alloc]init];
    [self.view addSubview:inTextLabel];
    self.inTextLabel = inTextLabel;

    UILabel *outLabel = [[UILabel alloc]init];
    outLabel.text = @"支出: ";
    outLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:outLabel];

    UILabel *outTextLabel = [[UILabel alloc]init];
    [self.view addSubview:outTextLabel];
    self.outTextLabel = outTextLabel;

    UILabel *resultLabel = [[UILabel alloc]init];
    resultLabel.text = @"结余: ";
    resultLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:resultLabel];

    UILabel *resultTextLabel = [[UILabel alloc]init];
    [self.view addSubview:resultTextLabel];
    self.resultTextLabel = resultTextLabel;

    CGFloat titleWidth = SZ_SCREEN_WIDTH / 12 + 10;
    CGFloat width = SZ_SCREEN_WIDTH / 4 - 10;

    [inLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(@0);
        make.top.equalTo(chartView.mas_bottom);
        make.width.equalTo(@(titleWidth));
    }];

    [inTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(inLabel);
        make.left.equalTo(inLabel.mas_right);
        make.width.equalTo(@(width));
    }];

    [outLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(inTextLabel);
        make.left.equalTo(inTextLabel.mas_right);
        make.width.equalTo(@(titleWidth));
    }];

    [outTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(outLabel);
        make.left.equalTo(outLabel.mas_right);
        make.width.equalTo(@(width));
    }];

    [resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(outTextLabel);
        make.left.equalTo(outTextLabel.mas_right);
        make.width.equalTo(@(titleWidth));
    }];

    [resultTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(resultLabel);
        make.left.equalTo(resultLabel.mas_right);
        make.width.equalTo(@(width));
    }];

    [self filterAllModelArray];
}

- (void)filterAllModelArray
{
    self.title = [NSString stringWithFormat:@"%ld年结余",_selectedDate.year];

    NSArray *monthTitleArray = @[@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"十一月",@"十二月"];

    NSMutableArray *allModelArray = [SZMoneyManager defaultManager].allModelArray.mutableCopy;
    //过滤出指定年份的数组
    [allModelArray filterUsingPredicate:[NSPredicate predicateWithFormat:@"year = %@",[NSString stringWithFormat:@"%ld",_selectedDate.year]]];
    [allModelArray sortUsingComparator:^NSComparisonResult(SZMoneyModel *obj1, SZMoneyModel *obj2) {
        return [obj1.month compare:obj2.month] == NSOrderedAscending;
    }];
    CGFloat inCost = 0;
    CGFloat outCost = 0;
    //计算出每月结余
    NSMutableArray<SZMoneySectionModel *> *monthArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 12; i++) {
        SZMoneySectionModel *model = [[SZMoneySectionModel alloc]init];
        model.insertTime = monthTitleArray[i];
        [monthArray addObject:model];
    }
    for (SZMoneyModel *model in allModelArray) {
        NSInteger index = model.month.integerValue - 1;
        if (index < monthArray.count && index >= 0) {
            monthArray[index].totalCost += model.cost;
            if (model.cost > 0) {
                inCost += model.cost;
            } else {
                outCost += model.cost;
            }
        }
    }
    self.monthArray = monthArray;
    _inTextLabel.text = [NSString stringWithFormat:@"%.2f",inCost];
    _outTextLabel.text = [NSString stringWithFormat:@"%.2f",outCost];
    _resultTextLabel.text = [NSString stringWithFormat:@"%.2f",inCost + outCost];

    NSMutableArray<BarChartDataEntry *> *values = [[NSMutableArray alloc] init];
    NSMutableArray<UIColor *> *colors = [[NSMutableArray alloc] init];

    UIColor *green = [UIColor colorWithRed:110/255.f green:190/255.f blue:102/255.f alpha:1.f];
    UIColor *red = [UIColor colorWithRed:211/255.f green:74/255.f blue:88/255.f alpha:1.f];

    for (int i = 0; i < monthArray.count; i++)
    {
        SZMoneySectionModel *d = monthArray[i];
        BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithX:i y:d.totalCost];
        [values addObject:entry];

        // specific colors
        if (d.totalCost >= 0.f)
        {
            [colors addObject:green];
        }
        else
        {
            [colors addObject:red];
        }
    }

    BarChartDataSet *set = [[BarChartDataSet alloc]initWithValues:values label:@"Values"];
    set.colors = colors;
    set.valueColors = colors;

    BarChartData *data = [[BarChartData alloc] initWithDataSet:set];
    [data setValueFont:[UIFont systemFontOfSize:13.f]];

    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.maximumFractionDigits = 1;
    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:formatter]];

    data.barWidth = 0.8;

    _chartView.data = data;
}

- (NSString *)stringForValue:(double)value
                        axis:(ChartAxisBase *)axis
{
    NSInteger index = (NSInteger)value;
    if (index < _monthArray.count) {
        return _monthArray[index].insertTime;
    } else {
        return @"";
    }
}

@end
