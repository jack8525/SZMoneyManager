//
//  HomePageSectionHeaderView.h
//  SZMoneyManager
//
//  Created by 张杰华 on 2019/3/19.
//  Copyright © 2019 张杰华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZMoneySectionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomePageSectionHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) SZMoneySectionModel *sectionModel;

@end

NS_ASSUME_NONNULL_END
