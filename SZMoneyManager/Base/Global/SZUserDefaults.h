//
//  SZUserDefaults.h
//  SZMoneyManager
//
//  Created by 张杰华 on 2019/3/19.
//  Copyright © 2019 张杰华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SZUserDefaults : NSObject

//常用颜色
@property (nonatomic, strong) UIColor *YEB44Color;
@property (nonatomic, strong) UIColor *YEB75Color;
@property (nonatomic, strong) UIColor *YEB99Color;
@property (nonatomic, strong) UIColor *YEBE5Color;
@property (nonatomic, strong) UIColor *YEBF8Color;
@property (nonatomic, strong) UIColor *YEBYellowColor;
@property (nonatomic, strong) UIColor *YEBRedColor;

//日期格式器
@property (nonatomic, strong) NSDateFormatter *yMdDateFormatter;//yyyy-MM-dd
@property (nonatomic, strong) NSArray *weekDayArray;//日期汉字数组,周日,周一,.....

//支出类型
@property (nonatomic, strong) NSMutableArray<NSString *> *outTypeArray;
//收入类型
@property (nonatomic, strong) NSMutableArray<NSString *> *inTypeArray;

//更新消费类型
- (void)updateTypeArray:(NSString *)type costType:(SZCostType)costType;

SZUserDefaults *SZCurrentUserDefaults(void);
@end
