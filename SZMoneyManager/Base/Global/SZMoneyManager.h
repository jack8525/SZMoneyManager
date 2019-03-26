//
//  SZMoneyManager.h
//  SZMoneyManager
//
//  Created by 张杰华 on 2019/3/20.
//  Copyright © 2019 张杰华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SZMoneyManager : NSObject

+ (instancetype)defaultManager;

@property (nonatomic, strong) NSMutableArray<SZMoneyModel *> *allModelArray;

@property (nonatomic, strong) NSArray<SZMoneySectionModel *> *sectionModelArray;

- (void)add:(SZMoneyModel *)model;

- (void)update:(SZMoneyModel *)model;

- (void)delete:(SZMoneyModel *)model;
@end
