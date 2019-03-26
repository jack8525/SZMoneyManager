//
//  MoneyAddViewController.h
//  SZMoneyManager
//
//  Created by 张杰华 on 2019/3/19.
//  Copyright © 2019 张杰华. All rights reserved.
//

#import "SZBaseViewController.h"


@interface MoneyAddViewController : SZBaseViewController

@property (nonatomic, copy) void(^sendBlock)(SZMoneyModel *model);

@property (nonatomic, strong) SZMoneyModel *model;

@end
