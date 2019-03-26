//
//  SZInputView.h
//  SZMoneyManager
//
//  Created by 张杰华 on 2019/3/19.
//  Copyright © 2019 张杰华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZInputBarView.h"


static CGFloat const SZInputBgViewHegiht = 380;

@interface SZInputView : UIView

@property (nonatomic, strong) SZInputBarView *inputBarView;

@property (nonatomic, copy) void(^sendBlock)(SZMoneyModel *model);

/** 添加键盘监听 */
- (void)addObserver;
/** 移除键盘监听 */
- (void)removeObserver;

- (void)show:(NSString *)typeName;

@end
