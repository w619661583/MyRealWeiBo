//
//  ReImageCell.m
//  Hello_lemongrass
//
//  Created by Ibokan on 13-1-19.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "ReImageCell.h"
#import "HomeViewController.h"
@implementation ReImageCell
@synthesize text_Label;
@synthesize retweeted_status_Label;
@synthesize reImage_View;
@synthesize retweeted_View;
//@synthesize delegate = _delegate;

-(void)dealloc
{
    self.text_Label = nil;
    self.retweeted_status_Label = nil;
    self.reImage_View = nil;
    self.retweeted_View = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.text_Label = [[[OHAttributedLabel alloc] initWithFrame:CGRectMake(0,0,0,0)] autorelease];
        self.text_Label.delegate=self;

        [self.contentView addSubview:self.text_Label];
        self.text_Label.lineBreakMode = NSLineBreakByWordWrapping;
        self.text_Label.backgroundColor = [UIColor clearColor];
        
        self.retweeted_status_Label = [[[OHAttributedLabel alloc] initWithFrame:CGRectMake(0,0,0,0)] autorelease];
        self.retweeted_status_Label.delegate=self;

        self.retweeted_status_Label.lineBreakMode = NSLineBreakByWordWrapping;
        self.retweeted_status_Label.backgroundColor = [UIColor clearColor];
        
        self.reImage_View = [[[UIImageView alloc] initWithFrame:CGRectMake(0,0,0,0)] autorelease];//转载微博的图片
        [self.contentView addSubview:self.reImage_View];
        self.reImage_View.userInteractionEnabled=YES;
        self.reImage_View.layer.masksToBounds = YES;
        self.reImage_View.layer.cornerRadius = 3;
        UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chufa:)];
        singleTap.numberOfTapsRequired=1;
        [self.reImage_View addGestureRecognizer:singleTap];
        self.retweeted_View = [[[UIView alloc] init] autorelease];//用来显示转发的内容
        [self.contentView addSubview:self.retweeted_View];
        self.retweeted_View.backgroundColor = [UIColor colorWithRed:186.0f/255.0f green:210.0f/255.0f blue:225.0f/255.0f alpha:1.0f];
        self.retweeted_View.layer.masksToBounds = YES;
        self.retweeted_View.layer.cornerRadius = 4;
        [self.retweeted_View addSubview:self.retweeted_status_Label];
        [self.retweeted_View addSubview:self.reImage_View];
        
    }
    return self;
}

-(void)chufa:(UIGestureRecognizer *)singe{
    
//    HomeViewController *home=[[HomeViewController alloc ]init];
//    self.delegate=home;
//    [self.delegate DoSomethingEveryFrame:self.path];
    
    if ([self.delegate respondsToSelector:@selector(imageTappedAction:)])
    {
        [self.delegate imageTappedAction:self];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setCellFormat:(Status*) aStatus
{
    [super setCellFormat:aStatus];
    self.path=aStatus.rethumbnail_pic;
    self.text_Label.frame = CGRectMake(50 + offset_x*2,
                                       aStatus.screenNameHeight+offset_y*2,
                                       text_Width,
                                       aStatus.textHeight);
    self.text_Label.font = aStatus.textFont;
        [self creatAttributedLabel:aStatus Label:self.text_Label];        
    //
    self.retweeted_status_Label.frame = CGRectMake(offset_x,
                                                   offset_y,
                                                   text_Width,
                                                   aStatus.reTextHeight);
    self.retweeted_status_Label.font = aStatus.reTextFont;
    [self creatReAttributedLabel:aStatus Label:self.retweeted_status_Label];

    //[self.retweeted_status_Label setAttString:aStatus.attReString withImages:aStatus.imgs2];
    
    
    [self.reImage_View setImageWithURL:[NSURL URLWithString:aStatus.rethumbnail_pic] success:^(UIImage *image, BOOL cached) {
        self.reImage_View.frame = CGRectMake(offset_x,
                                             aStatus.reTextHeight+offset_y*2,
                                             self.reImage_View.image.size.width,
                                             img_Height);
    } failure:^(NSError *error) {
    }];
    
    
    
    self.retweeted_View.frame = CGRectMake(50+offset_x*2,
                                           aStatus.screenNameHeight + aStatus.textHeight +offset_y*3,
                                           text_Width+offset_x*2,
                                           aStatus.reTextHeight + img_Height + offset_y*3);
    
    
    self.cellHeight = [aStatus getTotalHeight];
    
    
    CGRect rc = self.date_View.frame;
    rc.origin.y = self.cellHeight - create_date_Height;
    self.date_View.frame = rc;
}



@end
