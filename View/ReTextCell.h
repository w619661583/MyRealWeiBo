//
//  ReTextCell.h
//  Hello_lemongrass
//
//  Created by Ibokan on 13-1-17.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OHAttributedLabel.h"
#import "Status.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface ReTextCell : WeiboCell<OHAttributedLabelDelegate>

@property (nonatomic, retain) OHAttributedLabel *text_Label;
@property (nonatomic, retain) OHAttributedLabel *retweeted_status_Label;
@property (nonatomic, retain) UIView* retweeted_View;


-(void)setCellFormat:(Status*) aStatus;

@end
