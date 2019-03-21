//
//  SZCalendar.h
//  SZMoneyManager
//
//  Created by 张杰华 on 2019/3/20.
//  Copyright © 2019 张杰华. All rights reserved.
//

#import "SZAlertBaseView.h"

@interface SZCalendar : SZAlertBaseView

@property (nonatomic, assign) CGFloat contentWidth;//背景宽度
@property (nonatomic, assign) CGFloat contentHeight;//背景宽度

SZCalendar *YEBCalendar(void);

/** 默认选中的日期 */
@property (nonatomic, copy, readonly) SZCalendar *(^selectDate)(NSDate *date);
/** 点击后回调 */
@property (nonatomic, copy, readonly) SZCalendar *(^didFinishSelect)(void(^didFinishSelect)(NSDate *date));
/** 显示 */
@property (nonatomic, copy, readonly) SZCalendar *(^show)(void);

@end
