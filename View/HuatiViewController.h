//
//  HuatiViewController.h
//  MyRealWeiBo
//
//  Created by 王芝宝 on 13-1-31.
//  Copyright (c) 2013年 王芝宝. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
@interface HuatiViewController : UITableViewController
{
    NSMutableArray *_huatiArray;
}
@property(nonatomic,retain)NSString *huati;
@property(nonatomic,retain)SinaWeibo *mySina;
@end
