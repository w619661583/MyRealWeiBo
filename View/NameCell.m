//
//  NameCell.m
//  MyRealWeiBo
//
//  Created by 王芝宝 on 13-1-23.
//  Copyright (c) 2013年 王芝宝. All rights reserved.
//

#import "NameCell.h"

@implementation NameCell

-(void)dealloc{
    [super dealloc];
    [self.profile_image release];
    [self.screen_name_Label release];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.profile_image = [[[UIImageView alloc] initWithFrame:CGRectMake(offset_x,offset_y,profile_Size,profile_Size)] autorelease];
        [self.contentView addSubview:self.profile_image];
        self.profile_image.layer.masksToBounds=YES;
        self.profile_image.layer.cornerRadius = 8;
        
        
        self.screen_name_Label = [[[OHAttributedLabel alloc] initWithFrame:CGRectMake(offset_x*2 + profile_Size,offset_y,170,20)] autorelease];
        [self.contentView addSubview:self.screen_name_Label];
        self.screen_name_Label.lineBreakMode = NSLineBreakByWordWrapping;
        self.screen_name_Label.backgroundColor = [UIColor clearColor];

        self.accessoryType =UITableViewCellSelectionStyleBlue;
    }
    return self;
}

-(void)setCellFormat:(Status *)aStatus{
    self.screen_name_Label.frame = CGRectMake(50+2*offset_x,
                                              offset_y+16,
                                              170,
                                              aStatus.screenNameHeight);
    self.screen_name_Label.text = aStatus.screenName;
    self.screen_name_Label.font=[UIFont fontWithName:@"ArialMT" size:14];
    self.screen_name_Label.font = aStatus.screenNameFont;
    [self.profile_image setImageWithURL:[NSURL URLWithString:aStatus.profile_image_url] placeholderImage:[UIImage imageNamed:@"4.jpg"]];
    

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
