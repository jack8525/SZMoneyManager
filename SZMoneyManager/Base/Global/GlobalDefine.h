//
//  GlobalDefine.h
//  SZMoneyManager
//
//  Created by 张杰华 on 2019/3/19.
//  Copyright © 2019 张杰华. All rights reserved.
//

#ifndef GlobalDefine_h
#define GlobalDefine_h

typedef enum : NSUInteger {
    SZCostTypeIn,
    SZCostTypeOut,
} SZCostType;

//公用的cell复用标识符
static NSString * const CellReuseIdentifier = @"cellReuseIdentifier";

//颜色定义
#define YEBThemeColor               SZ_HEXCOLOR(0x38b58a)
#define DefaultThemeColor           Default75Color
#define DefaultTitleColor           [UIColor blackColor]
#define Default44Color              SZCurrentUserDefaults().YEB44Color
#define Default75Color              SZCurrentUserDefaults().YEB75Color
#define Default99Color              SZCurrentUserDefaults().YEB99Color
#define DefaultE5Color              SZCurrentUserDefaults().YEBE5Color
#define DefaultBackgroundColor      SZCurrentUserDefaults().YEBF8Color
#define DefaultYellowColor          SZCurrentUserDefaults().YEBYellowColor
#define DefaultRedColor             SZCurrentUserDefaults().YEBRedColor
#define DefaultWhiteColor           [UIColor whiteColor]

#endif /* GlobalDefine_h */
