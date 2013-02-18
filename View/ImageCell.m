//
//  ImageCell.m
//  Hello_lemongrass
//
//  Created by Ibokan on 13-1-19.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "ImageCell.h"
@implementation ImageCell
@synthesize text_Label;
@synthesize image_View;

-(void)dealloc
{
    self.text_Label = nil;
    self.image_View = nil;
    
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.text_Label = [[[OHAttributedLabel alloc] initWithFrame:CGRectMake(0,0,0,0)] autorelease];
        [self.contentView addSubview:self.text_Label];
        self.text_Label.lineBreakMode = NSLineBreakByWordWrapping;
        self.text_Label.backgroundColor = [UIColor clearColor];
        self.text_Label.delegate=self;
        
        self.image_View = [[[UIImageView alloc] initWithFrame:CGRectMake(0,0,0,0)] autorelease];//微博图片
       [self.contentView addSubview:self.image_View];
        self.image_View.userInteractionEnabled=YES;
        
        UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chufa:)];
        singleTap.numberOfTapsRequired=1;
        [self.image_View addGestureRecognizer:singleTap];
        self.image_View.layer.masksToBounds = YES;
        self.image_View.layer.cornerRadius = 3;
    }
    return self;
}
-(void)chufa:(UIGestureRecognizer *)singe{
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
   
        
    self.text_Label.frame = CGRectMake(50 + offset_x*2,
                                       aStatus.screenNameHeight+offset_y*2,
                                       text_Width,
                                       aStatus.textHeight);
    self.text_Label.font = aStatus.textFont;
    [self creatAttributedLabel:aStatus Label:self.text_Label];    
    
    
    NSURL *url=[NSURL URLWithString:aStatus.thumbnail_pic];
    self.path=aStatus.thumbnail_pic;
    [self.image_View setImageWithURL:url success:^(UIImage *image, BOOL cached) {
        self.image_View.frame = CGRectMake(50+offset_x*3,
                                           aStatus.screenNameHeight+aStatus.textHeight+offset_y*3,
                                           self.image_View.image.size.width,
                                           img_Height);
    } failure:^(NSError *error) {
    }];

    
    self.cellHeight = [aStatus getTotalHeight];
    
    CGRect rc = self.date_View.frame;
    rc.origin.y = self.cellHeight - create_date_Height;
    self.date_View.frame = rc;
    
}

@end
