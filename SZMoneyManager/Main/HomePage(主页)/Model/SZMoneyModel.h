//
//  SZMoneyModel.h
//  SZMoneyManager
//
//  Created by 张杰华 on 2019/3/19.
//  Copyright © 2019 张杰华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SZMoneyModel : NSObject<NSCoding>

@property (nonatomic, copy) NSString *title;//早餐
@property (nonatomic, copy) NSString *insertTime;//yyyy-MM-dd
@property (nonatomic, assign) CGFloat cost;//正:收入,负:支出
@property (nonatomic, copy) NSString *remark;//备注

@property (nonatomic, copy) NSString *year;//2019
@property (nonatomic, copy) NSString *month;//03
@property (nonatomic, copy) NSString *day;//19
@property (nonatomic, copy) NSString *weekDay;//1-7
@property (nonatomic, copy) NSString *weekDayC;//周日-周六
@property (nonatomic, copy) NSString *inOutC;
@property (nonatomic, copy) NSString *costString;

@end
