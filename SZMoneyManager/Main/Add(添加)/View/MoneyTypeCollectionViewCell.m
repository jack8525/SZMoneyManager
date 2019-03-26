
//
//  MoneyTypeCollectionViewCell.m
//  SZMoneyManager
//
//  Created by 张杰华 on 2019/3/19.
//  Copyright © 2019 张杰华. All rights reserved.
//

#import "MoneyTypeCollectionViewCell.h"

@implementation MoneyTypeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIImageView *icon = [[UIImageView alloc]init];
        icon.backgroundColor = DefaultBackgroundColor;
        [self.contentView addSubview:icon];
        self.icon = icon;

        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.textColor = Default75Color;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(self.contentView.mas_height).multipliedBy(0.5).offset(-5);
            make.bottom.equalTo(self.contentView.mas_centerY);
            make.centerX.equalTo(self.contentView);
        }];

        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@30);
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(icon.mas_bottom);
        }];
    }
    return self;
}

- (void)setIsAdd:(BOOL)isAdd
{
    _isAdd = isAdd;
    if (isAdd) {
        _icon.image = [UIImage imageNamed:@"add_normal"];
        _titleLabel.text = @"";
    } else {
        _icon.image = nil;
    }
}
@end
