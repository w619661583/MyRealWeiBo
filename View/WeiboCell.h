//
//  WeiboCell.h
//  MyRealWeiBo
//
//  Created by 王芝宝 on 13-1-22.
//  Copyright (c) 2013年 王芝宝. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OHAttributedLabel.h"
#import "Status.h"
#import <QuartzCore/QuartzCore.h>
#import<SDWebImage/UIImageView+WebCache.h>
@protocol ReImageCellDelegate <NSObject>

- (void)imageTappedAction: (id)cell;
-(void)peopeleDetailInfo:(id)cell;
-(void)pushuserName:(NSString *)name;
-(void)pushuserHuati:(NSString *)huati;

@end

@interface WeiboCell : UITableViewCell
@property (nonatomic, retain)  id<ReImageCellDelegate> delegate;

@property (nonatomic, retain) UIImageView *profile_image;
@property (nonatomic, retain) OHAttributedLabel *screen_name_Label;

@property (nonatomic, retain) UIImageView* reposts_countView;
@property (nonatomic, retain) UIImageView* comments_countView;
@property (nonatomic, retain) UILabel *create_at_source_Label;
@property (nonatomic, retain) UILabel *reposts_count_Label;
@property (nonatomic, retain) UILabel *comments_count_Label;
@property (nonatomic,retain)   UILabel *attitudes_count;
@property (nonatomic, retain) UIView* date_View;
@property (nonatomic, retain) UILabel* date_Label;
@property (nonatomic, retain) UILabel* from_Label;

@property (nonatomic, assign) int cellHeight;

-(void)setCellFormat:(Status*) aStatus;
-(void)creatReAttributedLabel:(Status *)astatus Label:(OHAttributedLabel *)label;
-(void)creatAttributedLabel:(Status *)astatus Label:(OHAttributedLabel *)label;
@end
