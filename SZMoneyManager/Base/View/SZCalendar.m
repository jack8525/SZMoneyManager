//
//  SZCalendar.m
//  SZMoneyManager
//
//  Created by 张杰华 on 2019/3/20.
//  Copyright © 2019 张杰华. All rights reserved.
//

#import "SZCalendar.h"
#import <FSCalendar.h>
//#import <EventKit/EventKit.h>
//#import "FSCalendar+Category.h"

@interface SZCalendar ()<FSCalendarDataSource,FSCalendarDelegate>

@property (nonatomic, strong) FSCalendar *calendar;
//@property (nonatomic, strong) NSCalendar *lunarCalendar;
//@property (nonatomic, strong) NSArray<NSString *> *lunarChars;
//@property (nonatomic, strong) NSArray<EKEvent *> *events;

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
//- (NSString *)calendar:(FSCalendar *)calendar subtitleForDate:(NSDate *)date
//{
//    EKEvent *event = [self eventsForDate:date].firstObject;
//    if (event) {
//        return event.title; // 春分、秋分、儿童节、植树节、国庆节、圣诞节...
//    }
//    NSInteger day = [_lunarCalendar component:NSCalendarUnitDay fromDate:date];
//    return _lunarChars[day-1]; // 初一、初二、初三...
//}

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

// 某个日期的所有事件
//- (NSArray<EKEvent *> *)eventsForDate:(NSDate *)date
//{
//    NSArray<EKEvent *> *filteredEvents = [self.events filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(EKEvent * _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
//        return [evaluatedObject.occurrenceDate isEqualToDate:date];
//    }]];
//    return filteredEvents;
//}

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

//        _lunarCalendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
//        _lunarChars = @[@"初一",@"初二",@"初三",@"初四",@"初五",@"初六",@"初七",@"初八",@"初九",@"初十",@"十一",@"十二",@"十三",@"十四",@"十五",@"十六",@"十七",@"十八",@"十九",@"二十",@"二一",@"二二",@"二三",@"二四",@"二五",@"二六",@"二七",@"二八",@"二九",@"三十"];

//        NSDate *minimumDate = [NSDate dateWithTimeIntervalSinceNow:-60*60*24*365];
//        NSDate *maximumDate = [NSDate dateWithTimeIntervalSinceNow:60*60*24*365];

//        __weak typeof(self) weakSelf = self;
//        EKEventStore *store = [[EKEventStore alloc] init];
//        [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
//            if(granted) {
//                NSDate *startDate = minimumDate; // 开始日期
//                NSDate *endDate = maximumDate; // 截止日期
//                NSPredicate *fetchCalendarEvents = [store predicateForEventsWithStartDate:startDate endDate:endDate calendars:nil];
//                NSArray<EKEvent *> *eventList = [store eventsMatchingPredicate:fetchCalendarEvents];
//                NSArray<EKEvent *> *events = [eventList filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(EKEvent * _Nullable event, NSDictionary<NSString *,id> * _Nullable bindings) {
//                    return event.calendar.subscribed;
//                }]];
//                weakSelf.events = events;
//            }
//        }];

        self.contentView.layer.cornerRadius = 10;
        self.contentView.layer.masksToBounds = true;
    }
    if (!_calendar.superview) {
        [self.contentView addSubview:_calendar];
    }
    return _calendar;
}

@end
