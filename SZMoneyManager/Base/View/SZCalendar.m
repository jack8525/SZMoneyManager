//
//  SZCalendar.m
//  SZMoneyManager
//
//  Created by 张杰华 on 2019/3/20.
//  Copyright © 2019 张杰华. All rights reserved.
//

#import "SZCalendar.h"
#import <FSCalendar.h>

@interface SZCalendar ()<FSCalendarDataSource,FSCalendarDelegate>

@property (nonatomic, strong) FSCalendar *calendar;

@property (nonatomic, strong) NSDate *selectedDate;
@property (nonatomic, copy) void(^didFinishSelectHandle)(NSDate *date);
@end

@implementation SZCalendar

SZCalendar *YEBCalendar(void)
{
    return [[SZCalendar alloc]initWithFrame:[UIView frontWindow].bounds];
}

- (SZCalendar *(^)(NSDate *))selectDate
{
    return ^SZCalendar *(NSDate *date) {
        self.selectedDate = date;
        return self;
    };
}

- (SZCalendar *(^)(void (^)(NSDate *)))didFinishSelect
{
    return ^SZCalendar *(void (^didFinishSelect)(NSDate *date)) {
        self.didFinishSelectHandle = didFinishSelect;
        return self;
    };
}

- (SZCalendar *(^)(void))show
{
    return ^SZCalendar *{
        [self showInWindow];
        return self;
    };
}

- (void)showInWindow
{
    self.contentView.frame = CGRectMake(0, 0, _contentWidth, _contentHeight);
    self.contentView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);

    self.calendar.frame = self.contentView.bounds;

    if (!_selectedDate) {
        _selectedDate = [NSDate date];
    }
    [_calendar selectDate:_selectedDate];
    [super showInWindow];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //各种属性初始化
        _contentWidth = 320;
        _contentHeight = 300;
        _selectedDate = [NSDate date];
        self.alertType = SZAlertTypeFromCenter;
    }
    return self;
}

#pragma mark - FSCalendarDelegate
- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    _selectedDate = date;
    if (_didFinishSelectHandle) _didFinishSelectHandle(_selectedDate);
    [self hide];
}

- (NSString *)calendar:(FSCalendar *)calendar titleForDate:(NSDate *)date
{

    if ([[NSCalendar currentCalendar] isDateInToday:date]) {
        return @"今";
    }
    return nil;
}

- (CGFloat)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance borderRadiusForDate:(nonnull NSDate *)date
{
    return 0.2;
}

- (FSCalendar *)calendar
{
    if (!_calendar) {
        _calendar = [[FSCalendar alloc]initWithFrame:CGRectZero];
        _calendar.backgroundColor = DefaultWhiteColor;
        _calendar.appearance.selectionColor = DefaultThemeColor;
        _calendar.appearance.titleDefaultColor = Default75Color;
        _calendar.firstWeekday = 2;
        _calendar.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
        _calendar.today = nil;
        [_calendar selectDate:[NSDate date]];
        _calendar.dataSource = self;
        _calendar.delegate = self;
        _calendar.appearance.headerTitleColor = DefaultThemeColor;
        _calendar.appearance.weekdayTextColor = DefaultThemeColor;


        self.contentView.layer.cornerRadius = 10;
        self.contentView.layer.masksToBounds = true;
    }
    if (!_calendar.superview) {
        [self.contentView addSubview:_calendar];
    }
    return _calendar;
}

@end
