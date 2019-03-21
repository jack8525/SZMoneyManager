//
//  PGDatePickManager+Category.m
//  SZMoneyManager
//
//  Created by 张杰华 on 2019/3/20.
//  Copyright © 2019 张杰华. All rights reserved.
//

#import "PGDatePickManager+Category.h"

@implementation PGDatePickManager (Category)

+ (instancetype)YEBStyle
{
    PGDatePickManager *datePickManager = [[PGDatePickManager alloc]init];
    datePickManager.isShadeBackgroud = true;
    datePickManager.headerViewBackgroundColor = DefaultWhiteColor;
    datePickManager.cancelButtonTextColor = DefaultRedColor;
    datePickManager.confirmButtonTextColor = DefaultThemeColor;
    PGDatePicker *datePicker = datePickManager.datePicker;
    datePicker.isHiddenMiddleText = false;
    datePicker.showUnit = PGShowUnitTypeCenter;
    datePicker.lineBackgroundColor = DefaultE5Color;
    datePicker.textColorOfSelectedRow = [UIColor blackColor];
    datePicker.middleTextColor = [UIColor blackColor];
    datePicker.textColorOfOtherRow = SZ_HEXCOLOR(0xd0d0d0);
    return datePickManager;
}

@end
