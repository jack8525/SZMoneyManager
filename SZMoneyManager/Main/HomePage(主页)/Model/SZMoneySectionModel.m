//
//  SZMoneySectionModel.m
//  SZMoneyManager
//
//  Created by 张杰华 on 2019/3/20.
//  Copyright © 2019 张杰华. All rights reserved.
//

#import "SZMoneySectionModel.h"

@implementation SZMoneySectionModel

- (NSMutableArray<SZMoneyModel *> *)modelArray
{
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

@end
