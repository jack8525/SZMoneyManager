//
//  MoneyDetailViewController.h
//  SZMoneyManager
//
//  Created by 张杰华 on 2019/3/20.
//  Copyright © 2019 张杰华. All rights reserved.
//

#import "SZBaseViewController.h"
#import "SZMoneyModel.h"

@interface MoneyDetailViewController : SZBaseViewController

@property (nonatomic, strong) SZMoneyModel *model;

@property (nonatomic, copy) void(^reload)(void);
@end

