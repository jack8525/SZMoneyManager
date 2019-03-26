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

- (NSString *)percent
{
    _percent = [NSString stringWithFormat:@"%.2f%%", _cost / _totalCost * 100];
    return _percent;
}

- (NSString *)costString
{
    _costString = [NSString stringWithFormat:@"%.2f",_cost];
    return _costString;
}
@end
