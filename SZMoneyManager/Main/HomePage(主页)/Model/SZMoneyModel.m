//
//  SZMoneyModel.m
//  SZMoneyManager
//
//  Created by 张杰华 on 2019/3/19.
//  Copyright © 2019 张杰华. All rights reserved.
//

#import "SZMoneyModel.h"
#import <YYKit.h>

@implementation SZMoneyModel

- (void)setInsertTime:(NSString *)insertTime
{
    NSDate *date = [SZCurrentUserDefaults().dateFormatter dateFromString:insertTime];
    _insertTime = [SZCurrentUserDefaults().dateFormatter stringFromDate:date];
    self.year = [NSString stringWithFormat:@"%ld",date.year];
    self.month = [NSString stringWithFormat:@"%ld",date.month];
    self.day = [NSString stringWithFormat:@"%ld",date.day];
    self.weekDay = [NSString stringWithFormat:@"%ld",date.weekday];
}

- (void)setMonth:(NSString *)month
{
//    if (month.integerValue < 10) {
//        month = [@"0" stringByAppendingString:month];
//    }
    _month = month;
}

- (void)setDay:(NSString *)day
{
//    if (day.integerValue < 10) {
//        day = [@"0" stringByAppendingString:day];
//    }
    _day = day;
}

- (NSString *)weekDayC
{
    if (!_weekDayC) {
        NSInteger w = _weekDay.integerValue - 1;
        _weekDayC = SZCurrentUserDefaults().weekDayArray[w];
    }
    return _weekDayC;
}

- (NSString *)inOutC
{
    _inOutC = _cost > 0 ? @"收入" : @"支出";
    return _inOutC;
}

- (NSString *)costString
{
    _costString = [NSString stringWithFormat:@"%.2f",_cost];
    return _costString;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.insertTime forKey:@"insertTime"];
    [aCoder encodeFloat:self.cost forKey:@"cost"];
    [aCoder encodeObject:self.remark forKey:@"remark"];

//    [aCoder encodeObject:self.year forKey:@"year"];
//    [aCoder encodeObject:self.month forKey:@"month"];
//    [aCoder encodeObject:self.day forKey:@"day"];
//    [aCoder encodeObject:self.weekDay forKey:@"weekDay"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self.title = [aDecoder decodeObjectForKey:@"title"];
    self.insertTime = [aDecoder decodeObjectForKey:@"insertTime"];
    self.cost = [aDecoder decodeFloatForKey:@"cost"];
    self.remark = [aDecoder decodeObjectForKey:@"remark"];

//    self.year = [aDecoder decodeObjectForKey:@"year"];
//    self.month = [aDecoder decodeObjectForKey:@"month"];
//    self.day = [aDecoder decodeObjectForKey:@"day"];
//    self.weekDay = [aDecoder decodeObjectForKey:@"weekDay"];
    return self;
}

@end
