//
//  NameCell.h
//  MyRealWeiBo
//
//  Created by 王芝宝 on 13-1-23.
//  Copyright (c) 2013年 王芝宝. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Status.h"
@interface NameCell : UITableViewCell
@property (nonatomic, retain) UIImageView *profile_image;
@property (nonatomic, retain) OHAttributedLabel *screen_name_Label;
-(void)setCellFormat:(Status*) aStatus;
@end
