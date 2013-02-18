//
//  ReImageCell.h
//  Hello_lemongrass
//
//  Created by Ibokan on 13-1-19.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OHAttributedLabel.h"
#import "Status.h"
#import <SDWebImage/UIImageView+WebCache.h>
@class HomeViewController;
@interface ReImageCell : WeiboCell<OHAttributedLabelDelegate>{

}
@property (nonatomic,retain)NSString *path;
@property (nonatomic, retain) OHAttributedLabel *text_Label;
@property (nonatomic, retain) OHAttributedLabel *retweeted_status_Label;
@property (nonatomic, retain) UIImageView* reImage_View;
@property (nonatomic, retain) UIView* retweeted_View;
//@property(nonatomic,retain)id<EveryFrameDelegate> delegate;
-(void)setCellFormat:(Status*) aStatus;

@end
