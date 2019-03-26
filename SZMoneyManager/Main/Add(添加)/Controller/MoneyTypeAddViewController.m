//
//  MoneyTypeAddViewController.m
//  SZMoneyManager
//
//  Created by 张杰华 on 2019/3/25.
//  Copyright © 2019 张杰华. All rights reserved.
//

#import "MoneyTypeAddViewController.h"

@interface MoneyTypeAddViewController ()

@property (nonatomic, strong) UITextField *textFiled;

@end

@implementation MoneyTypeAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"新增类型";

    UITextField *textField = [[UITextField alloc]init];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:textField];
    self.textFiled = textField;

    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.equalTo(@44);
    }];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(confirmAction)];
}

- (void)confirmAction
{
    if (_textFiled.text.length > 0) {
        _reloadBlock(_textFiled.text);
    }
    [self.navigationController popViewControllerAnimated:true];
}

@end
