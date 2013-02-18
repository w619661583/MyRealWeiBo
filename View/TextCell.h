//
//  TextCell.h
//  Hello_lemongrass
//
//  Created by Ibokan on 13-1-16.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OHAttributedLabel.h"
#import "Status.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface TextCell : WeiboCell<OHAttributedLabelDelegate>
@property (nonatomic, retain) OHAttributedLabel *text_Label;

-(void)setCellFormat:(Status*) aStatus;
@end
