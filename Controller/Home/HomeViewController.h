//
//  HomeViewController.h
//  MyRealWeiBo
//
//  Created by 王芝宝 on 13-1-21.
//  Copyright (c) 2013年 王芝宝. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
#import "ODRefreshControl.h"
#import "DetailController.h"
#import "Status.h"
#import "AppDelegate.h"
#import "TextCell.h"
#import "ImageCell.h"
#import "ReTextCell.h"
#import "ReImageCell.h"
#import "Status.h"
#import "User.h"
#import "WeiboCell.h"
@class User;
@class Status;
@interface HomeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,SinaWeiboRequestDelegate, ReImageCellDelegate,UIGestureRecognizerDelegate>
{
    int weiboCount;
    SinaWeibo *_mySina;
    UITableView *_weiboView;
    //NSMutableArray *_weiboList;
    NSMutableArray* _weiboData;
    UIViewController *imagecontroller;
    UIImageView *showimage;
    UIView *footView;
    NSMutableArray *weiboSong;
}
@property(nonatomic,retain)SinaWeibo *mySina;
@property(nonatomic, retain)ODRefreshControl * refresh;

@end
