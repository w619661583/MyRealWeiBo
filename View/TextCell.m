//
//  TextCell.m
//  Hello_lemongrass
//
//  Created by Ibokan on 13-1-16.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "TextCell.h"

@implementation TextCell
@synthesize text_Label = _text_Label;

-(void)dealloc
{
    self.text_Label = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.text_Label = [[[OHAttributedLabel alloc] initWithFrame:CGRectMake(0,0,0,0)] autorelease];
        [self.contentView addSubview:self.text_Label];
        self.text_Label.delegate=self;
        self.text_Label.lineBreakMode = NSLineBreakByWordWrapping;
        self.text_Label.backgroundColor = [UIColor clearColor];
    }
    return self;
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
    self.cellHeight = [aStatus getTotalHeight];
    
    CGRect rc = self.date_View.frame;
    rc.origin.y = self.cellHeight - create_date_Height;
    self.date_View.frame = rc;
}


@end