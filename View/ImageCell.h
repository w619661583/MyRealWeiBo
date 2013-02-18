//
//  ImageCell.h
//  Hello_lemongrass
//
//  Created by Ibokan on 13-1-19.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OHAttributedLabel.h"
#import "Status.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface ImageCell : WeiboCell<OHAttributedLabelDelegate>
@property (nonatomic,retain)NSString *path;
@property (nonatomic, retain) OHAttributedLabel *text_Label;
@property (nonatomic, retain) UIImageView* image_View;


-(void)setCellFormat:(Status*) aStatus;
@end
