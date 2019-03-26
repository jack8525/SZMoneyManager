//
//  SZInputBarView.m
//  SZMoneyManager
//
//  Created by 张杰华 on 2019/3/19.
//  Copyright © 2019 张杰华. All rights reserved.
//

#import "SZInputBarView.h"
#import <YYKit.h>

@interface SZInputBarView ()<UITextFieldDelegate>

@property (nonatomic, assign) BOOL isChange;
@property (nonatomic, strong) NSDate *selectedDate;
@property (nonatomic, strong) UIButton *dateBtn;

@end

@implementation SZInputBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = DefaultBackgroundColor;
        self.selectedDate = [NSDate date];
        self.inOut = true;
        
        UILabel *typeLabel = [[UILabel alloc]init];
        typeLabel.textAlignment = NSTextAlignmentCenter;
        typeLabel.fontSize = 20;
        [self addSubview:typeLabel];
        self.typeLabel = typeLabel;
        
        UITextField *textField = [[UITextField alloc]init];
        textField.placeholder = @"备注";
        textField.fontSize = 20;
        textField.text = @"";
        textField.returnKeyType = UIReturnKeyDone;
        textField.delegate = self;
        [self addSubview:textField];
        self.remarkTextField = textField;

        UITextField *costTextField = [[UITextField alloc]init];
        costTextField.textAlignment = NSTextAlignmentRight;
        costTextField.enabled = false;
        costTextField.fontSize = 20;
        [self addSubview:costTextField];
        self.costTextField = costTextField;

        UIView *line = [[UIView alloc]init];
        line.backgroundColor = Default75Color;
        [self addSubview:line];

        [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self).offset(10);
            make.width.height.equalTo(@(SZInputBarViewHegiht));
        }];

        [costTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.equalTo(typeLabel);
            make.right.equalTo(self).offset(-10);
            make.width.equalTo(@80);
        }];

        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.equalTo(typeLabel);
            make.left.equalTo(typeLabel.mas_right).offset(10);
            make.right.equalTo(costTextField.mas_left);
        }];

        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(typeLabel.mas_bottom);
            make.height.equalTo(@0.5);
        }];

        NSArray *tmpArray = @[
                              @"7",@"8",@"9",[_selectedDate sz_stringWithFormat:@"MM/dd"],
                              @"4",@"5",@"6",@"+",
                              @"1",@"2",@"3",@"-",
                              @".",@"0",@"后退",@"确认",
                              ];
        UIButton *lastBtn;
        for (NSInteger i = 0; i < tmpArray.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.layer.borderColor = Default75Color.CGColor;
            button.layer.borderWidth = 0.3;
            button.titleLabel.fontSize = 25;
            button.tag = i;
            [button setTitleColor:DefaultTitleColor forState:UIControlStateNormal];
            [button setTitle:tmpArray[i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];

            if (i == 3) {
                _dateBtn = button;
            }

            if (lastBtn) {
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.height.equalTo(lastBtn);
                    if (lastBtn.tag % 4 == 3) {//3,7,11,15
                        make.left.equalTo(self);
                        make.top.equalTo(lastBtn.mas_bottom);
                    } else {
                        make.left.equalTo(lastBtn.mas_right);
                        make.top.equalTo(lastBtn);
                    }
                }];
            } else {
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.equalTo(self).multipliedBy(0.25);
                    make.height.equalTo(self).multipliedBy(0.25).offset(-SZInputBarViewHegiht/4);
                    make.left.equalTo(self);
                    make.top.equalTo(line.mas_bottom);
                }];
            }
            lastBtn = button;
        }
    }
    return self;
}

- (void)buttonAction:(UIButton *)button
{
    switch (button.tag) {
        case 3://日期
        {
            YEBCalendar()
            .selectDate(_selectedDate)
            .show()
            .didFinishSelect(^(NSDate *date) {
                self.selectedDate = date;
                [button setTitle:[date sz_stringWithFormat:@"MM/dd"] forState:UIControlStateNormal];
            });
        }
            break;
        case 7://+
            break;
        case 11://-
            break;
        case 14://后退
            [_costTextField deleteBackward];
            break;
        case 15://确认
        {
            if (_costTextField.text.length == 0) {
                [self sz_showErrorHUDHint:@"金额不能为0"];
                return;
            }
            SZMoneyModel *model;
            if (_model) {
                model = _model;
            } else {
                model = [[SZMoneyModel alloc]init];
            }
            model.type = _typeLabel.text;
            model.cost = (_inOut ? -1 : 1) * fabsf(_costTextField.text.floatValue);
            model.insertTime = [_selectedDate sz_stringWithFormat:SZDateFormtyMd];
            model.remark = _remarkTextField.text;
            [_delegate inputBarViewDidClickConfirm:self model:model];
        }
            break;
        default://数字
            if (_isChange == false) {
                _costTextField.text = @"";
                _isChange = true;
            }
            [_costTextField insertText:button.titleLabel.text];
            break;
    }
}

- (void)setModel:(SZMoneyModel *)model
{
    _model = model;
    if (model) {
        _typeLabel.text = model.type;
        _remarkTextField.text = model.remark;
        _costTextField.text = model.costString;
        _inOut = model.cost < 0;
        _selectedDate = [SZCurrentUserDefaults().yMdDateFormatter dateFromString:model.insertTime];
        [_dateBtn setTitle:[_selectedDate sz_stringWithFormat:@"MM/dd"] forState:UIControlStateNormal];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return false;
}

@end
