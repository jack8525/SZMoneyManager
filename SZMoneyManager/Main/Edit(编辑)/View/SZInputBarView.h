//
//  SZInputBarView.h
//  SZMoneyManager
//
//  Created by 张杰华 on 2019/3/19.
//  Copyright © 2019 张杰华. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SZInputBarView;

static CGFloat const SZInputBarViewHegiht = 60;

@protocol SZInputBarViewDelegate <NSObject>

- (void)inputBarViewDidClickConfirm:(SZInputBarView *)inputBarView model:(SZMoneyModel *)model;

@end

@interface SZInputBarView : UIView

@property (nonatomic, strong) SZMoneyModel *model;
/** 收入:false 支出:true 默认true */
@property (nonatomic, assign) BOOL inOut;

@property (nonatomic, weak) id<SZInputBarViewDelegate> delegate;

@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UITextField *costTextField;
@property (nonatomic, strong) UITextField *remarkTextField;

@end
