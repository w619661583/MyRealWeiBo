//
//  WeiboCell.m
//  MyRealWeiBo
//
//  Created by 王芝宝 on 13-1-22.
//  Copyright (c) 2013年 王芝宝. All rights reserved.
//

#import "WeiboCell.h"

@implementation WeiboCell

@synthesize profile_image;
@synthesize screen_name_Label;
@synthesize create_at_source_Label;

@synthesize reposts_countView;
@synthesize comments_countView;
@synthesize reposts_count_Label;
@synthesize comments_count_Label;

@synthesize date_View;
@synthesize from_Label;
@synthesize date_Label;

@synthesize delegate;
-(void)dealloc
{
    self.reposts_countView = nil;
    self.comments_countView = nil;
    self.profile_image = nil;
    self.screen_name_Label = nil;
    self.create_at_source_Label = nil;
    self.reposts_count_Label = nil;
    self.comments_count_Label = nil;
    self.date_Label = nil;
    self.date_View  = nil;
    self.from_Label = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.profile_image = [[[UIImageView alloc] initWithFrame:CGRectMake(offset_x,offset_y,profile_Size,profile_Size)] autorelease];
        self.profile_image.userInteractionEnabled=YES;
        UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zhuanhuan:)];
        singleTap.numberOfTapsRequired=1;
        [self.profile_image addGestureRecognizer:singleTap];

        self.profile_image.layer.cornerRadius=10;
        [self.contentView addSubview:self.profile_image];
        self.profile_image.layer.masksToBounds=YES;
        self.profile_image.layer.cornerRadius = 8;
        
        
        self.screen_name_Label = [[[OHAttributedLabel alloc] initWithFrame:CGRectMake(offset_x*2 + profile_Size,offset_y,170,20)] autorelease];
        [self.contentView addSubview:self.screen_name_Label];
        self.screen_name_Label.lineBreakMode = NSLineBreakByWordWrapping;
        self.screen_name_Label.backgroundColor = [UIColor clearColor];
        
        //--------------
        self.reposts_countView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_retweet_count_icon.png"]] autorelease];
        self.reposts_countView.frame = CGRectMake(240, offset_y, self.reposts_countView.frame.size.width, self.reposts_countView.frame.size.height);
        [self.contentView addSubview:self.reposts_countView];
        
        self.reposts_count_Label = [[[UILabel alloc] initWithFrame:CGRectMake(255, offset_y, 20, 12)] autorelease];
        [self.contentView addSubview:self.reposts_count_Label];
        self.reposts_count_Label.font = [UIFont fontWithName:@"ArialMT" size:8];
        self.reposts_count_Label.textColor = [UIColor blueColor];
        self.reposts_count_Label.backgroundColor = [UIColor clearColor];
        
        self.comments_countView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_comment_count_icon.png"]] autorelease];
        self.comments_countView.frame = CGRectMake(280, offset_y, self.comments_countView.frame.size.width, self.comments_countView.frame.size.height);
        [self.contentView addSubview:self.comments_countView];
        
        self.comments_count_Label = [[[UILabel alloc] initWithFrame:CGRectMake(295, offset_y, 20, 12)] autorelease];
        [self.contentView addSubview:self.comments_count_Label];
        self.comments_count_Label.font = [UIFont fontWithName:@"Arial" size:8];
        self.comments_count_Label.textColor = [UIColor blueColor];
        self.comments_count_Label.backgroundColor = [UIColor clearColor];
        //////-----------------
        
        self.date_View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, create_date_Height)];
        [self.contentView addSubview:self.date_View];
        
        self.date_Label = [[UILabel alloc] initWithFrame:CGRectMake(offset_x*2 + profile_Size, 0, 70, create_date_Height)];
        self.date_Label.textColor = [UIColor blueColor];
        //self.date_Label.textAlignment = NSTextAlignmentCenter;
        [self.date_View addSubview:self.date_Label];
        
        
        self.from_Label = [[UILabel alloc] initWithFrame:CGRectMake(offset_x*2 + profile_Size+70, 0, 120, create_date_Height)];
        //self.from_Label.textAlignment = NSTextAlignmentCenter;
        self.from_Label.textColor  = [UIColor orangeColor];
        [self.date_View addSubview:self.from_Label];
        UIImage *imag=[UIImage imageNamed:@"xin.png"];
        UIImageView *imageV=[[[UIImageView alloc]initWithImage:imag]autorelease];
        imageV.frame=CGRectMake(offset_x*2 + profile_Size+70+120, 1, 20, create_date_Height-2);
        self.attitudes_count=[[UILabel alloc]initWithFrame:CGRectMake(offset_x*2 + profile_Size+70+150, 1, 20, create_date_Height-2)];
        [self.date_View addSubview:imageV];
        [self.date_View addSubview:self.attitudes_count];
        
        
    }
    return self;
}
-(void)chufa:(UIGestureRecognizer *)singe{
    if ([self.delegate respondsToSelector:@selector(imageTappedAction:)])
    {
        NSLog(@"delegate=======%@",self.delegate);
        [self.delegate imageTappedAction:self];
    }
}
-(void)zhuanhuan:(UIGestureRecognizer *)singe{
    if ([self.delegate respondsToSelector:@selector(peopeleDetailInfo:)])
    {
                NSLog(@"delegate=======%@",self.delegate);
        [self.delegate peopeleDetailInfo:self];
    }
}




-(void)setCellFormat:(Status*) aStatus
{
    //在父类中加载用户名和用户头像，转发数目，评论数目
    
    self.reposts_count_Label.text = [NSString stringWithFormat:@"%d", aStatus.reposts_count ];
    self.comments_count_Label.text = [NSString stringWithFormat:@"%d",aStatus.comments_count];
    
    //可以在这里设置label的字体，用aStatus.screenFont设置
    self.screen_name_Label.frame = CGRectMake(50+2*offset_x,
                                              offset_y,
                                              170,
                                              aStatus.screenNameHeight);
    self.screen_name_Label.text = aStatus.screenName;
    self.screen_name_Label.font = aStatus.screenNameFont;
    [self.profile_image setImageWithURL:[NSURL URLWithString:aStatus.profile_image_url] placeholderImage:[UIImage imageNamed:@"4.jpg"]];
    
   
    
    self.date_Label.text = [NSString stringWithFormat:@"%@",aStatus.date];

    self.attitudes_count.text = [NSString stringWithFormat:@"%d",aStatus.attitudes_count];
    self.date_Label.font = aStatus.accessFont;
    self.from_Label.text = [NSString stringWithFormat:@"来源:%@",aStatus.from];
    if (self.from_Label.text.length>=8) {
        self.from_Label.font=[UIFont fontWithName:@"ArialMT" size:9];
    }else{
        self.from_Label.font = aStatus.accessFont;
    }
    
}
-(void)creatAttributedLabel:(Status *)astatus Label:(OHAttributedLabel *)label
{
    //将配置好的AttributedString添加到label中
    [label setAttString:astatus.attString withImages:astatus.imgs];
    
    [astatus.user_arr enumerateObjectsUsingBlock:^(NSString *user, NSUInteger idx, BOOL *stop) {
        [label addCustomLink:[NSURL URLWithString:user] inRange:[astatus.attString.string rangeOfString:user]];
    }];
    
    [astatus.topic_arr enumerateObjectsUsingBlock:^(NSString *topic, NSUInteger idx, BOOL *stop) {
        [label addCustomLink:[NSURL URLWithString:topic] inRange:[astatus.attString.string rangeOfString:topic]];
    }];
}

-(void)creatReAttributedLabel:(Status *)astatus Label:(OHAttributedLabel *)label
{
    //将配置好的AttributedString添加到label中
    [label setAttString:astatus.attReString withImages:astatus.imgs2];
    //图文混排结束
    
    [astatus.reUser_arr enumerateObjectsUsingBlock:^(NSString *user, NSUInteger idx, BOOL *stop) {
        [label addCustomLink:[NSURL URLWithString:user] inRange:[astatus.attReString.string rangeOfString:user]];
    }];
    
    [astatus.reTopic_arr enumerateObjectsUsingBlock:^(NSString *topic, NSUInteger idx, BOOL *stop) {
        [label addCustomLink:[NSURL URLWithString:topic] inRange:[astatus.attReString.string rangeOfString:topic]];
    }];
}

-(BOOL)attributedLabel:(OHAttributedLabel *)attributedLabel shouldFollowLink:(NSTextCheckingResult *)linkInfo
{
    //点击的链接的位置
    NSRange range = linkInfo.range;
    //获取整个字符串的信息
    NSString * text = attributedLabel.attributedText.string;
    //用位置信息，找到点击的 文字信息
    NSString * regexString = [text substringWithRange:range];
    
    //根据不同的前缀进行不同的操作
    if ([regexString hasPrefix:@"@"])
    {
        //剔除前面的@
        NSString * user = [regexString substringFromIndex:1];
        NSLog(@"推出用户界面  %@",user);
        if([self.delegate respondsToSelector:@selector(pushuserName:)]){
            [self.delegate pushuserName:user];
        }
    
    }
    if ([regexString hasPrefix:@"#"])
    {
        //剔除前后的#号
        NSString * topic = [regexString substringToIndex:[regexString length]-1];
        topic = [topic substringFromIndex:1];
        NSLog(@"推出话题界面  %@",topic);
        if([self.delegate respondsToSelector:@selector(pushuserHuati:)]){
            [self.delegate pushuserHuati:topic];
        }

    }
    if ([regexString hasPrefix:@"http"])
    {
        NSLog(@"推出内置浏览器界面  %@",regexString);
    }
    
    //如果返回yes 打开系统的浏览器
    return NO;
}



@end
