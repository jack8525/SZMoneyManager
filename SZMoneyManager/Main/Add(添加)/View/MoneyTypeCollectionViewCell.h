//
//  MoneyTypeCollectionViewCell.h
//  SZMoneyManager
//
//  Created by 张杰华 on 2019/3/19.
//  Copyright © 2019 张杰华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoneyTypeCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, assign) BOOL isAdd;
@end
