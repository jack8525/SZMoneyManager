//
//  SZMoneyManager.m
//  SZMoneyManager
//
//  Created by 张杰华 on 2019/3/20.
//  Copyright © 2019 张杰华. All rights reserved.
//

#import "SZMoneyManager.h"
#import <YYKit.h>

static NSString *cacheKey = @"cacheKey";

@interface SZMoneyManager ()

@property (nonatomic, strong) YYCache *cache;

@end

@implementation SZMoneyManager

+ (instancetype)defaultManager
{
    static SZMoneyManager *shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[SZMoneyManager alloc]init];
    });
    return shared;
}

- (instancetype)init
{
    if (self = [super init]) {
        _cache = [YYCache cacheWithName:@"Money"];
        if ([_cache containsObjectForKey:cacheKey]) {
            NSArray *modelArray = [_cache objectForKey:cacheKey];
            _allModelArray = modelArray.mutableCopy;
            NSLog(@"有 %ld 条记录",_allModelArray.count);
        }
        if (_allModelArray == nil) {
            _allModelArray = [NSMutableArray array];
        }
    }
    return self;
}

- (void)add:(SZMoneyModel *)model
{
    [_allModelArray addObject:model];
    [_cache setObject:_allModelArray forKey:cacheKey withBlock:nil];
}

- (void)update:(SZMoneyModel *)model
{
    [_cache setObject:_allModelArray forKey:cacheKey withBlock:nil];
}

- (void)delete:(SZMoneyModel *)model
{
    if ([_allModelArray containsObject:model]) {
        [_allModelArray removeObject:model];
        [_cache setObject:_allModelArray forKey:cacheKey withBlock:nil];
    }
}
@end
