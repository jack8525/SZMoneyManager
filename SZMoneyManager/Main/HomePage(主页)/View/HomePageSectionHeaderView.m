//
//  HomePageSectionHeaderView.m
//  SZMoneyManager
//
//  Created by 张杰华 on 2019/3/19.
//  Copyright © 2019 张杰华. All rights reserved.
//

#import "HomePageSectionHeaderView.h"
#import <YYKit.h>

@interface HomePageSectionHeaderView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

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
        self.titleLabel = titleLabel;

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

    }
    return self;
}

- (void)setSectionModel:(SZMoneySectionModel *)sectionModel
{
    _sectionModel = sectionModel;
    NSDate *date = [SZCurrentUserDefaults().yMdDateFormatter dateFromString:sectionModel.insertTime];
    _titleLabel.text = [NSString stringWithFormat:@"%ld/%ld %@",date.month,date.day,sectionModel.weekDayC];

}

@end
