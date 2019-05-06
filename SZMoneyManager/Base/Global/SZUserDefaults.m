//
//  SZUserDefaults.m
//  SZMoneyManager
//
//  Created by 张杰华 on 2019/3/19.
//  Copyright © 2019 张杰华. All rights reserved.
//

#import "SZUserDefaults.h"

static NSString * const InTypeArrayKey = @"inTypeArrayKey";
static NSString * const OutTypeArrayKey = @"outTypeArrayKey";

@implementation SZUserDefaults

SZUserDefaults *SZCurrentUserDefaults(void)
{
    return [SZUserDefaults standardUserDefaults];
}

static SZUserDefaults *standard;
static dispatch_once_t onceToken;
+ (instancetype)standardUserDefaults
{
    dispatch_once(&onceToken, ^{
        standard = [[SZUserDefaults alloc]init];
    });
    return standard;
}

- (NSDateFormatter *)yMdDateFormatter
{
    if (!_yMdDateFormatter) {
        _yMdDateFormatter = [NSDateFormatter sz_dateFormatterWithFormat:SZDateFormtyMd];
    }
    return _yMdDateFormatter;
}

- (NSArray *)weekDayArray
{
    if (!_weekDayArray) {
        _weekDayArray = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    }
    return _weekDayArray;
}

#pragma mark - 常用颜色
-  (UIColor *)YEB44Color
{
    if (!_YEB44Color) {
        _YEB44Color = SZ_HEXCOLOR(0x444444);
    }
    return _YEB44Color;
}

- (UIColor *)YEB75Color
{
    if (!_YEB75Color) {
        _YEB75Color = SZ_HEXCOLOR(0x757575);
    }
    return _YEB75Color;
}

- (UIColor *)YEB99Color
{
    if (!_YEB99Color) {
        _YEB99Color = SZ_HEXCOLOR(0x999999);
    }
    return _YEB99Color;
}

- (UIColor *)YEBE5Color
{
    if (!_YEBE5Color) {
        _YEBE5Color = SZ_HEXCOLOR(0xe5e5e5);
    }
    return _YEBE5Color;
}

- (UIColor *)YEBF8Color
{
    if (!_YEBF8Color) {
        _YEBF8Color = SZ_HEXCOLOR(0xf8f8f8);
    }
    return _YEBF8Color;
}

- (UIColor *)YEBYellowColor
{
    if (!_YEBYellowColor) {
        _YEBYellowColor = SZ_HEXCOLOR(0xffc15c);
    }
    return _YEBYellowColor;
}

- (UIColor *)YEBRedColor
{
    if (!_YEBRedColor) {
        _YEBRedColor = SZ_HEXCOLOR(0xff5c5c);
    }
    return _YEBRedColor;
}

- (NSMutableArray<NSString *> *)inTypeArray
{
    if (!_inTypeArray) {
        _inTypeArray = [[NSUserDefaults standardUserDefaults] objectForKey:InTypeArrayKey];
        _inTypeArray = _inTypeArray.mutableCopy;
    }
    if (!_inTypeArray) {
        _inTypeArray = @[@"工资",@"奖金"].mutableCopy;
        [[NSUserDefaults standardUserDefaults] setObject:_inTypeArray forKey:InTypeArrayKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return _inTypeArray;
}

- (NSMutableArray<NSString *> *)outTypeArray
{
    if (!_outTypeArray) {
        _outTypeArray = [[NSUserDefaults standardUserDefaults] objectForKey:OutTypeArrayKey];
        _outTypeArray = _outTypeArray.mutableCopy;
    }
    if (!_outTypeArray) {
        _outTypeArray = @[@"餐饮",@"购物",@"住房",@"电影",@"运动"].mutableCopy;
        [[NSUserDefaults standardUserDefaults] setObject:_outTypeArray forKey:OutTypeArrayKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return _outTypeArray;
}

- (void)updateTypeArray:(NSString *)type costType:(SZCostType)costType
{
    NSMutableArray *tmpArray;
    NSString *key;
    if (costType == SZCostTypeIn) {
        tmpArray = _inTypeArray;
        key = InTypeArrayKey;
    } else {
        tmpArray = _outTypeArray;
        key = OutTypeArrayKey;
    }
    [tmpArray addObject:type];
    [[NSUserDefaults standardUserDefaults] setObject:tmpArray forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
