//
//  MonthStatisticsViewController.h
//  SZMoneyManager
//
//  Created by 张杰华 on 2019/3/21.
//  Copyright © 2019 张杰华. All rights reserved.
//

#import "SZBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

//每个月的统计饼状图
@interface MonthStatisticsViewController : SZBaseViewController

//来自收入:false
//来自支出:true
@property (nonatomic, assign) SZCostType costType;

//有值:月统计
//空值:年统计
@property (nonatomic, strong) NSArray<SZMoneyModel *> *monthModelArray;

@end

NS_ASSUME_NONNULL_END
