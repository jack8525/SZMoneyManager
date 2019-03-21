//
//  MoneyAddViewController.m
//  SZMoneyManager
//
//  Created by 张杰华 on 2019/3/19.
//  Copyright © 2019 张杰华. All rights reserved.
//

#import "MoneyAddViewController.h"
#import "MoneyTypeCollectionViewCell.h"
#import "SZInputView.h"
#import <IQKeyboardManager.h>

@interface MoneyAddViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) SZInputView *inputView;

@end

@implementation MoneyAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _titleArray = @[@"餐饮",@"购物",@"住房",@"电影",@"运动"];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = false;
    if (_model) {
        [_inputView show:_model.title];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = true;
    [_inputView removeObserver];
}

- (void)typeBtnAction:(UIButton *)button
{
    button.selected = !button.selected;
    _inputView.inputBarView.inOut = button.selected;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _titleArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MoneyTypeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.titleLabel.text = _titleArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [_inputView show:_titleArray[indexPath.row]];
}

- (void)setupUI {
    UIButton *typeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [typeBtn setTitle:@"支出" forState:UIControlStateNormal];
    [typeBtn setTitle:@"收入" forState:UIControlStateSelected];
    [typeBtn addTarget:self action:@selector(typeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [typeBtn sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:typeBtn];

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = CGSizeMake(SZ_SCREEN_WIDTH/4, SZ_SCREEN_WIDTH/4);

    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    collectionView.backgroundColor = DefaultWhiteColor;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:MoneyTypeCollectionViewCell.class forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:collectionView];

    SZInputView *inputView = [[SZInputView alloc]initWithFrame:CGRectMake(0, SZ_SCREEN_HEIGHT -      self.navigationController.navigationBar.frame.size.height - [[UIApplication sharedApplication] statusBarFrame].size.height, SZ_SCREEN_WIDTH, SZInputBgViewHegiht)];
    inputView.inputBarView.model = _model;
    [self.view addSubview:inputView];
    self.inputView = inputView;

    inputView.sendBlock = ^(SZMoneyModel *model) {
        self.sendBlock(model);
        [self.navigationController popViewControllerAnimated:true];
    };

    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(inputView.mas_top);
    }];

//    collectionView.frame = CGRectMake(0, 0, SZ_SCREEN_WIDTH, inputView.frame.origin.y);
}

@end
