//
//  MonthStatisticsTableViewCell.m
//  SZMoneyManager
//
//  Created by 张杰华 on 2019/3/22.
//  Copyright © 2019 张杰华. All rights reserved.
//

#import "MonthStatisticsTableViewCell.h"

@interface MonthStatisticsTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *percentLabel;
@property (nonatomic, strong) UILabel *costLabel;

@end

@implementation MonthStatisticsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = DefaultBackgroundColor;

        UIView *bgView = [[UIView alloc]init];
        bgView.backgroundColor = DefaultWhiteColor;
        [self.contentView addSubview:bgView];

        UILabel *titleLabel = [[UILabel alloc]init];
        [bgView addSubview:titleLabel];
        self.titleLabel = titleLabel;

        UILabel *percentLabel = [[UILabel alloc]init];
        percentLabel.textColor = Default75Color;
        [bgView addSubview:percentLabel];
        self.percentLabel = percentLabel;

        UILabel *costLabel = [[UILabel alloc]init];
        costLabel.textAlignment = NSTextAlignmentRight;
        [bgView addSubview:costLabel];
        self.costLabel = costLabel;
        
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.centerX.equalTo(self.contentView);
            make.width.equalTo(self.contentView).offset(-20);
        }];

        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(bgView);
            make.bottom.equalTo(bgView.mas_centerY);
            make.left.equalTo(bgView).offset(10);
        }];

        [percentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(titleLabel);
            make.top.equalTo(titleLabel.mas_bottom);
            make.bottom.equalTo(bgView);
        }];

        [costLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(bgView).offset(-10);
            make.top.bottom.left.equalTo(bgView);
        }];
    }
    return self;
}

- (void)setModel:(SZMoneySectionModel *)model
{
    _model = model;
    _titleLabel.text = model.title;
    _percentLabel.text = model.percent;
    _costLabel.text = model.costString;
}
@end
