//
//  SZMoneySectionModel.h
//  SZMoneyManager
//
//  Created by 张杰华 on 2019/3/20.
//  Copyright © 2019 张杰华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SZMoneySectionModel : NSObject

@property (nonatomic, copy) NSString *insertTime;
@property (nonatomic, copy) NSString *weekDayC;
@property (nonatomic, assign) CGFloat totalIn;
@property (nonatomic, assign) CGFloat totalOut;

@property (nonatomic, strong) NSMutableArray<SZMoneyModel *> *modelArray;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) CGFloat totalCost;
@property (nonatomic, assign) CGFloat cost;
@property (nonatomic, copy) NSString *costString;
@property (nonatomic, copy) NSString *percent;
@end
