//
//  MoneyAddViewController.m
//  SZMoneyManager
//
//  Created by 张杰华 on 2019/3/19.
//  Copyright © 2019 张杰华. All rights reserved.
//

#import "MoneyAddViewController.h"
#import "MoneyTypeAddViewController.h"
#import "MoneyTypeCollectionViewCell.h"
#import "SZInputView.h"
#import <IQKeyboardManager.h>

@interface MoneyAddViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) SZInputView *inputView;
@property (nonatomic, strong) UIButton *typeBtn;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *typeArray;
@end

@implementation MoneyAddViewController

- (NSArray *)typeArray
{
    if (_typeBtn.selected == false) {
        _typeArray = SZCurrentUserDefaults().outTypeArray;
    } else {
        _typeArray = SZCurrentUserDefaults().inTypeArray;
    }
    return _typeArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = false;
    if (_model) {
        [_inputView show:_model.type];
        _typeBtn.selected = _model.cost > 0;
        [_collectionView reloadData];
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
    _inputView.inputBarView.inOut = !button.selected;
    [_collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.typeArray.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MoneyTypeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellReuseIdentifier forIndexPath:indexPath];
    if (indexPath.row == self.typeArray.count) {
        cell.isAdd = true;
    }else{
        cell.isAdd = false;
        cell.titleLabel.text = self.typeArray[indexPath.row];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.typeArray.count) {
        MoneyTypeAddViewController *vc = [[MoneyTypeAddViewController alloc]init];
        vc.reloadBlock = ^(NSString *type) {
            [SZCurrentUserDefaults() updateTypeArray:type inOut:!self.typeBtn.selected];
            [self.collectionView reloadData];
        };
        [self.navigationController pushViewController:vc animated:true];
    } else {
        if (_typeBtn.selected == false) {
            [_inputView show:SZCurrentUserDefaults().outTypeArray[indexPath.row]];
        } else {
            [_inputView show:SZCurrentUserDefaults().inTypeArray[indexPath.row]];
        }
    }
}

- (void)setupUI {
    UIButton *typeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [typeBtn setTitle:@"支出" forState:UIControlStateNormal];
    [typeBtn setTitle:@"收入" forState:UIControlStateSelected];
    [typeBtn addTarget:self action:@selector(typeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [typeBtn sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:typeBtn];
    self.typeBtn = typeBtn;

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = CGSizeMake(SZ_SCREEN_WIDTH/4, SZ_SCREEN_WIDTH/4);

    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    collectionView.backgroundColor = DefaultWhiteColor;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:MoneyTypeCollectionViewCell.class forCellWithReuseIdentifier:CellReuseIdentifier];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
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
}

@end
