//
//  CommentCell.m
//  MyRealWeiBo
//
//  Created by 王芝宝 on 13-1-23.
//  Copyright (c) 2013年 王芝宝. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell
@synthesize date_View;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.text_Label = [[[OHAttributedLabel alloc] initWithFrame:CGRectMake(0,0,0,0)] autorelease];
        [self.contentView addSubview:self.text_Label];
        self.text_Label.lineBreakMode = NSLineBreakByWordWrapping;
        self.text_Label.backgroundColor = [UIColor clearColor];
        self.profile_image = [[[UIImageView alloc] initWithFrame:CGRectMake(offset_x,offset_y,profile_Size,profile_Size)] autorelease];
        self.profile_image.layer.cornerRadius=10;
        [self.contentView addSubview:self.profile_image];
        self.profile_image.layer.masksToBounds=YES;
        self.profile_image.layer.cornerRadius = 8;
        
        
        self.screen_name_Label = [[[OHAttributedLabel alloc] initWithFrame:CGRectMake(offset_x*2 + profile_Size,offset_y,170,20)] autorelease];
        [self.contentView addSubview:self.screen_name_Label];
        self.screen_name_Label.lineBreakMode = NSLineBreakByWordWrapping;
        self.screen_name_Label.backgroundColor = [UIColor clearColor];
        self.date_Label = [[UILabel alloc] initWithFrame:CGRectMake(offset_x*2 + profile_Size, 0, 70, create_date_Height)];
        self.date_Label.textColor = [UIColor blueColor];
        //self.date_Label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.date_Label];
        
        
        self.from_Label = [[UILabel alloc] initWithFrame:CGRectMake(offset_x*2 + profile_Size+70, 0, 120, create_date_Height)];
        //self.from_Label.textAlignment = NSTextAlignmentCenter;
        self.from_Label.textColor  = [UIColor orangeColor];
        [self.contentView addSubview:self.from_Label];
        
    }
    return self;
}
-(void)setCellFormat:(Commont*) aStatus
{
    
    self.text_Label.frame = CGRectMake(50 + offset_x*2,
                                       aStatus.screenNameHeight+offset_y*2,
                                       text_Width,
                                       aStatus.textHeight);
    self.text_Label.font = aStatus.textFont;
    [self.text_Label setAttString:aStatus.attString withImages:aStatus.imgs];
    self.screen_name_Label.frame = CGRectMake(50+2*offset_x,
                                              offset_y,
                                              170,
                                              aStatus.screenNameHeight);
    self.screen_name_Label.text = aStatus.screenName;
    self.screen_name_Label.font = aStatus.screenNameFont;
    [self.profile_image setImageWithURL:[NSURL URLWithString:aStatus.profile_image_url] placeholderImage:[UIImage imageNamed:@"4.jpg"]];
    self.date_Label.frame=CGRectMake(offset_x*2 + profile_Size, aStatus.screenNameHeight+offset_y*3+aStatus.textHeight, 70, 20);
    self.date_Label.text = [NSString stringWithFormat:@"%@",aStatus.date];
    self.date_Label.font = aStatus.accessFont;
    
    self.from_Label.text = [NSString stringWithFormat:@"来源:%@",aStatus.from];
    self.from_Label.frame=CGRectMake(offset_x*2 + profile_Size+70, aStatus.screenNameHeight+offset_y*3+aStatus.textHeight, 120, 20);
    if (self.from_Label.text.length>=8) {
        self.from_Label.font=[UIFont fontWithName:@"ArialMT" size:9];
    }else{
        self.from_Label.font = aStatus.accessFont;
    }

     
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
