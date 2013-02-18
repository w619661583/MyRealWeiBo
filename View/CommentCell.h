//
//  CommentCell.h
//  MyRealWeiBo
//
//  Created by 王芝宝 on 13-1-23.
//  Copyright (c) 2013年 王芝宝. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OHAttributedLabel.h"
#import "Commont.h"
@interface CommentCell : UITableViewCell
@property (nonatomic, retain) UIImageView *profile_image;
@property (nonatomic, retain) OHAttributedLabel *screen_name_Label;
@property (nonatomic, retain) UILabel* date_Label;
@property (nonatomic, retain) UILabel* from_Label;
@property (nonatomic, retain) OHAttributedLabel *text_Label;
@property (nonatomic, retain) UIView* date_View;
@property (nonatomic, assign) int cellHeight;
-(void)setCellFormat:(Commont*) aStatus;
@end
