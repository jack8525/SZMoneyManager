//
//  SZAlertBaseView.m
//  SZMoneyManager
//
//  Created by 张杰华 on 2019/3/20.
//  Copyright © 2019 张杰华. All rights reserved.
//

#import "SZAlertBaseView.h"

@interface SZAlertBaseView ()<UIGestureRecognizerDelegate>

@end

@implementation SZAlertBaseView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //各种属性初始化
        self.alpha = 0;
    }
    return self;
}

- (void)showInWindow
{
    [self.frontWindow addSubview:self];
    self.backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];

    CGRect frame = self.contentView.frame;
    switch (_alertType) {
        case SZAlertTypeFromBottom:
            frame.origin.y -= frame.size.height;
            break;
        default:
            break;
    }

    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
        self.contentView.frame = frame;
    }];
}

- (void)hide
{
    CGRect frame = self.contentView.frame;
    switch (_alertType) {
        case SZAlertTypeFromBottom:
            frame.origin.y = self.frame.size.height;
            break;
        default:
            break;
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
        self.contentView.frame = frame;
    } completion:^(BOOL finished) {
        [self.backgroundView removeFromSuperview];
        [self.contentView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

#pragma mark - 懒加载
- (UIView *)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc]init];

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
        tap.delegate = self;
        [_backgroundView addGestureRecognizer:tap];
    }
    //插入到底
    if (!_backgroundView.superview) {
        [self insertSubview:_backgroundView belowSubview:self.contentView];
    }
    //更新frame
    if (_backgroundView) {
        _backgroundView.frame = self.bounds;
    }
    return _backgroundView;
}

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = DefaultWhiteColor;
    }
    if (!_contentView.superview) {
        [self addSubview:_contentView];
    }
    return _contentView;
}

#pragma mark -
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isKindOfClass:NSClassFromString(@"UITableViewCellContentView")]) {
        return false;
    }
    return true;
}

@end
