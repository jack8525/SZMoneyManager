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

        UIButton *inBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [inBtn setTitleColor:DefaultTitleColor forState:UIControlStateNormal];
        inBtn.titleLabel.fontSize = 20;
        inBtn.titleLabel.numberOfLines = 2;
        [inBtn addTarget:self action:@selector(inBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:inBtn];
        self.inBtn = inBtn;

        UIButton *outBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [outBtn setTitleColor:DefaultTitleColor forState:UIControlStateNormal];
        outBtn.titleLabel.fontSize = 20;
        outBtn.titleLabel.numberOfLines = 2;
        [outBtn addTarget:self action:@selector(outBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:outBtn];
        self.outBtn = outBtn;

        UIButton *resultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [resultBtn setTitleColor:DefaultTitleColor forState:UIControlStateNormal];
        resultBtn.titleLabel.fontSize = 20;
        resultBtn.titleLabel.numberOfLines = 2;
        [resultBtn addTarget:self action:@selector(resultBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:resultBtn];
        self.resultBtn = resultBtn;

        [inBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self);
            make.width.equalTo(self).multipliedBy(1.0/3.0);
        }];

        [outBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.width.equalTo(inBtn);
            make.left.equalTo(inBtn.mas_right);
        }];

        [resultBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.width.equalTo(outBtn);
            make.left.equalTo(outBtn.mas_right);
        }];

    }
    return self;
}

- (void)outBtnAction
{
    if (_outBtnBlock) {
        _outBtnBlock();
    }
}

- (void)inBtnAction
{
    if (_inBtnBlock) {
        _inBtnBlock();
    }
}

- (void)resultBtnAction
{
    if (_resultBlock) {
        _resultBlock();
    }
}
@end
