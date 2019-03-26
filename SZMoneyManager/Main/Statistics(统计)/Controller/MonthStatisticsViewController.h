//
//  MonthStatisticsViewController.h
//  SZMoneyManager
//
//  Created by 张杰华 on 2019/3/21.
//  Copyright © 2019 张杰华. All rights reserved.
//

#import "SZBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MonthStatisticsViewController : SZBaseViewController

@property (nonatomic, strong) NSArray<SZMoneyModel *> *monthModelArray;

@end

NS_ASSUME_NONNULL_END
