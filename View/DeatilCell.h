//
//  DeatilCell.h
//  MyRealWeiBo
//
//  Created by 王芝宝 on 13-1-23.
//  Copyright (c) 2013年 王芝宝. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import<SDWebImage/UIImageView+WebCache.h>
#import "TextCell.h"
#import "ReImageCell.h"
#import "ReTextCell.h"
#import "ImageCell.h"
@interface DeatilCell : UITableViewCell
-(void)setCellFormat:(Status*) aStatus;
@property(nonatomic,retain)Status *sta;
@end
