//
//  Status.h
//  Sina_Blok
//
//  Created by Ibokan on 13-1-15.
//  Copyright (c) 2013年 zhy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSAttributedString+Attributes.h"
#import "RegexKitLite.h"
#import "MarkupParser.h"


@class User;

typedef enum StatuseType : NSInteger {
    StatuseTypeText = 0,
    StatuseTypeTextImage,
    StatuseTypeReText,
    StatuseTypeReImage
}StatuseType;



@interface Status : NSObject<OHAttributedLabelDelegate>
{
    BOOL _isHasImg;
    BOOL _isHasReImg;
    BOOL _isHasReText;
}

@property (nonatomic, copy) UIFont* accessFont;//小字儿的字体
@property (nonatomic,copy) UIFont* screenNameFont;
@property (nonatomic,copy) UIFont* textFont;
@property (nonatomic,copy) UIFont* reTextFont;

@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *idstr;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *in_reply_to_status_id;
@property (nonatomic, copy) NSString *in_reply_to_user_id;
@property (nonatomic, copy) NSString *in_reply_to_screen_name;
@property (nonatomic, copy) NSString *thumbnail_pic;
@property (nonatomic, copy) NSString *bmiddle_pic;
@property (nonatomic, copy) NSString *original_pic;
@property (nonatomic, copy) NSDictionary *geo;
@property (nonatomic, copy) NSDictionary *user;
@property (nonatomic, copy) NSDictionary *retweeted_status;

@property (nonatomic, assign) BOOL favorited;
@property (nonatomic, assign) BOOL truncated;
@property (nonatomic, assign) int reposts_count;
@property (nonatomic, assign) int comments_count;
@property (nonatomic, assign) int attitudes_count;

//计算出来的微博信息
@property (nonatomic, assign) int textHeight;
@property (nonatomic, assign) int reTextHeight;
@property (nonatomic,assign) int screenNameHeight;

@property (nonatomic, copy) NSString* screenName;
@property (nonatomic,copy) NSString* profile_image_url;

@property (nonatomic, assign) StatuseType type;
@property (nonatomic, copy) NSString* reText;
@property (nonatomic, copy) NSString *rethumbnail_pic;
@property (nonatomic, copy) NSString *rebmiddle_pic;
@property (nonatomic, copy) NSString *reoriginal_pic;

//图文混排的信息
@property (nonatomic,retain)NSMutableAttributedString* attString;//存储富文本
@property (nonatomic,retain)NSMutableAttributedString* attReString;
@property (nonatomic,retain)NSMutableArray* imgs;//存储图片
@property (nonatomic,retain)NSMutableArray* imgs2;
@property (nonatomic,retain)NSMutableArray* user_arr;//@的用户数组
@property (nonatomic,retain)NSMutableArray* reUser_arr;
@property (nonatomic,retain)NSMutableArray* topic_arr;//话题数组
@property (nonatomic,retain)NSMutableArray* reTopic_arr;

@property (nonatomic,copy)NSMutableDictionary* textDic;//存放微博里的数据：图文混排
@property (nonatomic,copy)NSMutableDictionary* reTextDic;//存放转发微博里的数据

//得到创建日期和来源
@property (nonatomic,copy)NSString* date;
@property (nonatomic,copy)NSString* from;



//获得高度

-(int)getTotalHeight;














@end
