//
//  DetailController.h
//  MyRealWeiBo
//
//  Created by 王芝宝 on 13-1-23.
//  Copyright (c) 2013年 王芝宝. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Status.h"
#import "SinaWeibo.h"
#import "ODRefreshControl.h"
#import "TextCell.h"
#import "ImageCell.h"
#import "ReTextCell.h"
#import "ReImageCell.h"

@interface DetailController : UITableViewController<UITableViewDataSource,UITableViewDelegate,ReImageCellDelegate>
{
    SinaWeibo *_mySina;
    NSMutableArray *_weiboPinglun;
    NSMutableArray *_weiboZhuanFa;
}
@property(nonatomic,retain)Status *sta;
@property(nonatomic,retain)SinaWeibo *mySina;
@property(nonatomic, retain)ODRefreshControl * refresh;
@end

