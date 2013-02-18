//
//  FollowerViewController.h
//  MyRealWeiBo
//
//  Created by 王芝宝 on 13-1-30.
//  Copyright (c) 2013年 王芝宝. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
#import<SDWebImage/UIImageView+WebCache.h>

@interface FollowerViewController : UITableViewController{
    NSMutableArray* _weiboData;
    NSString *_name;
}
@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain)SinaWeibo *mySina;
@end
