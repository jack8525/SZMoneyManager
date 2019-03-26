//
//  HomePageHeaderView.h
//  SZMoneyManager
//
//  Created by 张杰华 on 2019/3/20.
//  Copyright © 2019 张杰华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageHeaderView : UIView

@property (nonatomic, strong) UIButton *inBtn;
@property (nonatomic, strong) UIButton *outBtn;
@property (nonatomic, strong) UIButton *resultBtn;

@property (nonatomic, copy) void(^outBtnBlock)(void);
@property (nonatomic, copy) void(^inBtnBlock)(void);
@property (nonatomic, copy) void(^resultBlock)(void);
@end
