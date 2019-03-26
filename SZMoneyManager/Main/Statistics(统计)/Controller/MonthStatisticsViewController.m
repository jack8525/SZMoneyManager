//
//  MonthStatisticsViewController.m
//  SZMoneyManager
//
//  Created by 张杰华 on 2019/3/21.
//  Copyright © 2019 张杰华. All rights reserved.
//

#import "MonthStatisticsViewController.h"
#import "MonthStatisticsTableViewCell.h"
#import "SZMoneyManager-Bridging-Header.h"

@interface MonthStatisticsViewController ()<ChartViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *parties;
@property (nonatomic, strong) PieChartView *chartView;

@property (nonatomic, strong) NSMutableArray<SZMoneySectionModel *> *dataArray;
@end

@implementation MonthStatisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DefaultBackgroundColor;
    _dataArray = [NSMutableArray array];
    [self handleData];
    [self setupCharts];
}

- (void)handleData {
    //按日期由大到小
    NSMutableArray<SZMoneyModel *> *monthModelArray = _monthModelArray.mutableCopy;
    [monthModelArray sortUsingComparator:^NSComparisonResult(SZMoneyModel *obj1, SZMoneyModel *obj2) {
        return [obj1.type compare:obj2.type] == NSOrderedAscending;
    }];
    //算总价
    CGFloat totalCost = 0;
    NSArray *costArray = [monthModelArray valueForKey:@"cost"];
    for (NSNumber *cost in costArray) {
        totalCost += cost.floatValue;
    }
    //组成数据源
    [_dataArray removeAllObjects];
    for (NSInteger i = 0; i < monthModelArray.count; i++) {
        SZMoneyModel *model = monthModelArray[i];
        if (i > 0 && [model.type isEqualToString:monthModelArray[i - 1].type]) {

        }else{
            SZMoneySectionModel *sectionModel = [[SZMoneySectionModel alloc]init];
            sectionModel.title = model.type;
            sectionModel.totalCost = totalCost;
//            sectionModel.insertTime = model.insertTime;
//            sectionModel.weekDayC = model.weekDayC;
            [_dataArray addObject:sectionModel];
        }

        _dataArray.lastObject.cost += model.cost;
        [_dataArray.lastObject.modelArray addObject:model];
    }

    [_dataArray sortUsingComparator:^NSComparisonResult(SZMoneySectionModel *obj1, SZMoneySectionModel * obj2) {
        return obj1.cost < obj2.cost ? NSOrderedAscending : NSOrderedDescending;
    }];
}

- (void)setupCharts {
    PieChartView *chartView = [[PieChartView alloc]init];
    [self.view addSubview:chartView];
    self.chartView = chartView;

    [chartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.equalTo(@150);
    }];

    //是否显示扇形区域的文字
    chartView.drawEntryLabelsEnabled = false;
    //true时以百分比显示
    chartView.usePercentValuesEnabled = true;
    //true时中间的孔透明
    chartView.drawSlicesUnderHoleEnabled = true;
    //中间圆所占的百分比
    chartView.holeRadiusPercent = 0.58;
    //中间圆外围的透明圆所占的百分比
    chartView.transparentCircleRadiusPercent = 0.61;
    //是否开启描述
    chartView.chartDescription.enabled = true;
    //中间的文字
    chartView.drawCenterTextEnabled = true;

    NSMutableParagraphStyle *style = [NSParagraphStyle defaultParagraphStyle].mutableCopy;
    style.lineBreakMode = NSLineBreakByTruncatingTail;
    style.alignment = NSTextAlignmentCenter;

//    NSMutableAttributedString *centerText = [[NSMutableAttributedString alloc]initWithString:@"Charts\nby Daniel Cohen Gindi"];
//    [centerText setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSParagraphStyleAttributeName:style} range:NSMakeRange(0, centerText.length)];
//    [centerText setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11],NSForegroundColorAttributeName:UIColor.grayColor} range:NSMakeRange(10, centerText.length - 10)];
//    [centerText setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11],NSForegroundColorAttributeName:SZ_RGB(51, 181, 229)} range:NSMakeRange(centerText.length - 19, 19)];
    //中间的文本
//    chartView.centerAttributedText = centerText;
    if (_dataArray.count > 0) {
        chartView.centerText = [NSString stringWithFormat:@"%.2f",_dataArray.firstObject.totalCost];
    }else{
        chartView.centerText = @"0.00";
    }
    //是否绘制中间的空心圆
    chartView.drawHoleEnabled = true;
    chartView.rotationAngle = 0;
    //是否可旋转
    chartView.rotationEnabled = false;
    //是否点击高亮
    chartView.highlightPerTapEnabled = true;

    //图像的详细信息
    ChartLegend *l = chartView.legend;
    l.horizontalAlignment = ChartLegendHorizontalAlignmentRight;
    l.verticalAlignment = ChartLegendVerticalAlignmentCenter;
    l.orientation = ChartLegendOrientationVertical;
    //false时画在外面
    l.drawInside = NO;
    l.xEntrySpace = 70.0;
    l.yEntrySpace = 5.0;
    l.yOffset = 0.0;
    l.xOffset = 40;
    l.font = [UIFont systemFontOfSize:16];
//    l.maxSizePercent = 0.99;

    chartView.delegate = self;

    //图像的详细信息
    chartView.legend.enabled = true;
    //饼状图距离边缘的间隙
    [chartView setExtraOffsetsWithLeft:20 top:0 right:20 bottom:0];

    [chartView animateWithXAxisDuration:1.4 easingOption:ChartEasingOptionEaseOutExpo];

    [self updateData];

//    for (id<IChartDataSet> set in chartView.data.dataSets) {
        //是否显示扇形区域百分比文字
//        set.drawValuesEnabled = false;
//        set.drawIconsEnabled = false;
//    }

    UITableView *tableView = [[UITableView alloc]init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 64;
    tableView.tableFooterView = [[UIView alloc]init];
    tableView.backgroundColor = DefaultBackgroundColor;
    tableView.layoutMargins = UIEdgeInsetsMake(0, 10, 0, 10);
    tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    [self.view addSubview:tableView];

    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(chartView.mas_bottom);
    }];
}

- (void)updateData
{
    NSMutableArray *entries = [[NSMutableArray alloc] init];

    NSArray<SZMoneySectionModel *> *dataArray = _dataArray;
    if (dataArray.count > 4) {
        dataArray = [_dataArray subarrayWithRange:NSMakeRange(0, 4)];
    }
    for (int i = 0; i < dataArray.count; i++)
    {
        [entries addObject:[[PieChartDataEntry alloc] initWithValue:dataArray[i].percent.floatValue label:dataArray[i].title]];
    }

    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithValues:entries label:@""];
    //拼图间的空间
    dataSet.sliceSpace = 2.0;

    // add a lot of colors

    NSMutableArray *colors = [[NSMutableArray alloc] init];
    [colors addObjectsFromArray:ChartColorTemplates.vordiplom];
    [colors addObjectsFromArray:ChartColorTemplates.joyful];
    [colors addObjectsFromArray:ChartColorTemplates.colorful];
    [colors addObjectsFromArray:ChartColorTemplates.liberty];
    [colors addObjectsFromArray:ChartColorTemplates.pastel];
    [colors addObject:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];

    dataSet.colors = colors;

    dataSet.valueLinePart1OffsetPercentage = 0.8;
    dataSet.valueLinePart1Length = 0.2;
    dataSet.valueLinePart2Length = 0.4;
    //dataSet.xValuePosition = PieChartValuePositionOutsideSlice;
    dataSet.yValuePosition = PieChartValuePositionOutsideSlice;

    PieChartData *data = [[PieChartData alloc] initWithDataSet:dataSet];

    NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
    pFormatter.numberStyle = NSNumberFormatterPercentStyle;
    pFormatter.maximumFractionDigits = 1;
    pFormatter.multiplier = @1.f;
    pFormatter.percentSymbol = @" %";
    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:pFormatter]];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:11.f]];
    [data setValueTextColor:UIColor.blackColor];

    _chartView.data = data;
    [_chartView highlightValues:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MonthStatisticsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier];
    if (!cell) {
        cell = [[MonthStatisticsTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellReuseIdentifier];
    }
    cell.model = _dataArray[indexPath.row];
    return cell;
}
@end
