//
//  HomePageHeaderView.m
//  SZMoneyManager
//
//  Created by 张杰华 on 2019/3/20.
//  Copyright © 2019 张杰华. All rights reserved.
//

#import "HomePageHeaderView.h"

@implementation HomePageHeaderView

- (instancetype)init
{
    if (self = [super init]) {
        UILabel *inLabel = [[UILabel alloc]init];
        inLabel.numberOfLines = 0;
        inLabel.textAlignment = NSTextAlignmentCenter;
        inLabel.fontSize = 20;
        [self addSubview:inLabel];
        self.inLabel = inLabel;

        UILabel *outLabel = [[UILabel alloc]init];
        outLabel.numberOfLines = 0;
        outLabel.textAlignment = NSTextAlignmentCenter;
        outLabel.fontSize = 20;
        [self addSubview:outLabel];
        self.outLabel = outLabel;

        UILabel *resultLabel = [[UILabel alloc]init];
        resultLabel.numberOfLines = 0;
        resultLabel.textAlignment = NSTextAlignmentCenter;
        resultLabel.fontSize = 20;
        [self addSubview:resultLabel];
        self.resutlLabel = resultLabel;

        [inLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self);
            make.width.equalTo(self).multipliedBy(1.0/3.0);
        }];

        [outLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.width.equalTo(inLabel);
            make.left.equalTo(inLabel.mas_right);
        }];

        [resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.width.equalTo(outLabel);
            make.left.equalTo(outLabel.mas_right);
        }];

    }
    return self;
}

@end
