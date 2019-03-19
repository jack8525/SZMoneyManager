//
//  HomePageSectionHeaderView.m
//  SZMoneyManager
//
//  Created by 张杰华 on 2019/3/19.
//  Copyright © 2019 张杰华. All rights reserved.
//

#import "HomePageSectionHeaderView.h"

@implementation HomePageSectionHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        UIView *bgView = [[UIView alloc]init];
        bgView.backgroundColor = DefaultWhiteColor;
        [self.contentView addSubview:bgView];

        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.textColor = Default75Color;
        [bgView addSubview:titleLabel];

        UIView *line = [[UIView alloc]init];
        line.backgroundColor = Default75Color;
        [bgView addSubview:line];

        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
        }];

        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(bgView);
            make.left.equalTo(bgView).offset(10);
        }];

        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(bgView);
            make.height.equalTo(@0.5);
        }];

        titleLabel.text = @"03/19 周二";
    }
    return self;
}

@end
