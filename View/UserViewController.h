//
//  UserViewController.h
//  MyRealWeiBo
//
//  Created by 王芝宝 on 13-1-28.
//  Copyright (c) 2013年 王芝宝. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
#import "User.h"
#import "ReTextCell.h"
#import "ReImageCell.h"
#import "Status.h"
#import "User.h"
#import "ImageCell.h"
#import "TextCell.h"
#import<SDWebImage/UIImageView+WebCache.h>
@interface UserViewController : UITableViewController<SinaWeiboRequestDelegate,ReImageCellDelegate>{
    User *userInfo;
    NSMutableArray* _weiboData;
    UIViewController *imagecontroller;
    UIImageView *showimage;
     UIScrollView *scro;
}

@property(nonatomic,retain)SinaWeibo *mySina;
@property(nonatomic,retain) NSString *screenName;
@property (retain, nonatomic)   IBOutlet UITableView    *table;
@property (retain, nonatomic) IBOutlet UIView *headerView;
@property (retain, nonatomic) IBOutlet UIImageView *headerVImageV;
@property (retain, nonatomic) IBOutlet UILabel *headerVNameLB;
@property (retain, nonatomic) IBOutlet UILabel *weiboCount;
@property (retain, nonatomic) IBOutlet UILabel *followerCount;
@property (retain, nonatomic) IBOutlet UILabel *followingCount;
- (IBAction)gotoFollowedVC:(id)sender;

- (IBAction)gotoFollowingVC:(id)sender;
@end
