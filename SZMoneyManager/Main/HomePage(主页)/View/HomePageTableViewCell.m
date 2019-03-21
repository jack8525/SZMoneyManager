//
//  HomePageTableViewCell.m
//  SZMoneyManager
//
//  Created by 张杰华 on 2019/3/19.
//  Copyright © 2019 张杰华. All rights reserved.
//

#import "HomePageTableViewCell.h"

@interface HomePageTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *costLabel;

@end

@implementation HomePageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = DefaultBackgroundColor;

        UIView *bgView = [[UIView alloc]init];
        bgView.backgroundColor = DefaultWhiteColor;
        [self.contentView addSubview:bgView];

        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.top.bottom.equalTo(self.contentView);
        }];

        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.textColor = Default75Color;
        [bgView addSubview:titleLabel];
        self.titleLabel = titleLabel;

        UILabel *costLabel = [[UILabel alloc]init];
        costLabel.textColor = Default75Color;
        costLabel.textAlignment = NSTextAlignmentRight;
        [bgView addSubview:costLabel];
        self.costLabel = costLabel;

        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bgView).offset(10);
            make.top.right.bottom.equalTo(bgView);
        }];

        [costLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(bgView);
            make.right.equalTo(bgView).offset(-10);
        }];
    }
    return self;
}

- (void)setModel:(SZMoneyModel *)model
{
    _model = model;
    _titleLabel.text = model.title;
    _costLabel.text = [NSString stringWithFormat:@"%.2f",model.cost];
}

@end
