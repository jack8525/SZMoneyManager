//
//  SZInputView.m
//  SZMoneyManager
//
//  Created by 张杰华 on 2019/3/19.
//  Copyright © 2019 张杰华. All rights reserved.
//

#import "SZInputView.h"

typedef enum : NSUInteger {
    SZInputViewShowTypeClose,
    SZInputViewShowTypeKeyboard,
    SZInputViewShowTypeNumPad,
} SZInputViewShowType;

@interface SZInputView ()<SZInputBarViewDelegate>

@property (nonatomic, assign) NSTimeInterval keyboardAnimationDuration;
@property (nonatomic, assign) CGFloat keyboardHeight;
@property (nonatomic, assign) CGFloat origin_y;
@property (nonatomic, assign) SZInputViewShowType oldType;

@end

@implementation SZInputView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)show:(NSString *)typeName
{
    [self addObserver];
    _inputBarView.typeLabel.text = typeName;
//    _inputBarView.model = _model;
    [self updateSelfFrame:SZInputViewShowTypeNumPad];
}

- (void)hide {
    [self updateSelfFrame:SZInputViewShowTypeClose];
    [self removeObserver];
}

- (void)setupUI {
    self.backgroundColor = DefaultWhiteColor;
    _keyboardHeight = SZInputBgViewHegiht - SZInputBarViewHegiht;

    SZInputBarView *inputBarView = [[SZInputBarView alloc]initWithFrame:self.bounds];
    inputBarView.delegate = self;
    [self addSubview:inputBarView];
    self.inputBarView = inputBarView;

}

- (void)updateSelfFrame:(SZInputViewShowType)type
{
    if (_origin_y == 0) _origin_y = self.frame.origin.y;
    if (_keyboardAnimationDuration == 0) _keyboardAnimationDuration = 0.25;
    if (_keyboardHeight == 0) _keyboardHeight = SZInputBgViewHegiht - SZInputBarViewHegiht;

    CGRect bgFrame = self.frame;
    bgFrame.size.height = _keyboardHeight + SZInputBarViewHegiht;

    CGFloat new_origin_y = 0;
    switch (_oldType) {
        case SZInputViewShowTypeClose:
        {
            switch (type) {
                case SZInputViewShowTypeKeyboard:
                    //close -> keyboard
                    new_origin_y = _origin_y - _keyboardHeight - SZInputBarViewHegiht;
                    break;
                case SZInputViewShowTypeNumPad:
                    //close -> NumPad
                    new_origin_y = _origin_y - _keyboardHeight - SZInputBarViewHegiht;
                    break;
                case SZInputViewShowTypeClose:
                    new_origin_y = _origin_y;
                    return;
                    break;
                default:
                    break;
            }
        }
            break;
        case SZInputViewShowTypeKeyboard:
        {
            switch (type) {
                case SZInputViewShowTypeKeyboard:
                    //close -> keyboard
                    new_origin_y = _origin_y - _keyboardHeight - SZInputBarViewHegiht;
                    break;
                case SZInputViewShowTypeNumPad:
                    //close -> NumPad
                    [self endEditing:true];
                    new_origin_y = _origin_y - _keyboardHeight - SZInputBarViewHegiht;
                    break;
                case SZInputViewShowTypeClose:
                    new_origin_y = _origin_y;
                    break;
                default:
                    break;
            }
        }
            break;
        case SZInputViewShowTypeNumPad:
        {
            switch (type) {
                case SZInputViewShowTypeKeyboard:
                    //close -> keyboard
                    new_origin_y = _origin_y - _keyboardHeight - SZInputBarViewHegiht;
                    break;
                case SZInputViewShowTypeNumPad:
                    //close -> NumPad
                    new_origin_y = _origin_y - _keyboardHeight - SZInputBarViewHegiht;
                    break;
                case SZInputViewShowTypeClose:
                    new_origin_y = _origin_y;
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }

    _oldType = type;

    bgFrame.origin.y = new_origin_y;

    [UIView animateWithDuration:_keyboardAnimationDuration animations:^{
        self.frame = bgFrame;
    } completion:^(BOOL finished) {
//        if (self.YChangeBlock) {
//            self.YChangeBlock(new_origin_y);
//        }
    }];
}

- (void)dealloc
{
    NSLog(@"销毁聊天输入框通知");
    [self removeObserver];
}

#pragma mark -
- (void)inputBarViewDidClickConfirm:(SZInputBarView *)inputBarView model:(SZMoneyModel *)model
{
    _sendBlock(model);
}

#pragma mark - 键盘响应通知
- (void)keyboardWillShow:(NSNotification *)noti
{
    if (self.hidden == true) return;
    _keyboardAnimationDuration = [[noti.userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGFloat keyboardHeight = [[noti.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    if (_keyboardHeight != keyboardHeight) {
        _keyboardHeight = keyboardHeight;

        CGRect inputFrame = _inputBarView.frame;
        inputFrame.size.height = _keyboardHeight + SZInputBarViewHegiht;
        _inputBarView.frame = inputFrame;
    }
    [self updateSelfFrame:SZInputViewShowTypeKeyboard];
}

- (void)close
{
    [self updateSelfFrame:SZInputViewShowTypeClose];
}

#pragma mark - 注册通知
- (void)addObserver
{
    //键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //键盘消失的通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHiden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)removeObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
