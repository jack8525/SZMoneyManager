//
//  SZAlertBaseView.h
//  SZMoneyManager
//
//  Created by 张杰华 on 2019/3/20.
//  Copyright © 2019 张杰华. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    SZAlertTypeFromBottom,//从底下推出来
    SZAlertTypeFromCenter,//从中间推出来
} SZAlertType;

@interface SZAlertBaseView : UIView

@property (nonatomic, assign) SZAlertType alertType;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *contentView;

- (void)showInWindow;

- (void)hide;

@end

NS_ASSUME_NONNULL_END
