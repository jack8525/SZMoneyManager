//
//  MoneyTypeAddViewController.h
//  SZMoneyManager
//
//  Created by 张杰华 on 2019/3/25.
//  Copyright © 2019 张杰华. All rights reserved.
//

#import "SZBaseViewController.h"

@interface MoneyTypeAddViewController : SZBaseViewController

@property (nonatomic, copy) void(^reloadBlock)(NSString *type);

@end
