//
//  Commont.h
//  MyRealWeiBo
//
//  Created by 王芝宝 on 13-1-23.
//  Copyright (c) 2013年 王芝宝. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@interface Commont : NSObject{
   }
@property (nonatomic, copy) UIFont* accessFont;//小字儿的字体
@property (nonatomic,copy) UIFont* screenNameFont;
@property (nonatomic,copy) UIFont* textFont;
@property (nonatomic,copy) UIFont* reTextFont;
@property (nonatomic, retain) NSString *created_at;
@property (nonatomic, retain) NSString *screenName;
@property (nonatomic, retain) NSString *ID;
@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) NSString *source;
@property (nonatomic, retain) NSDictionary *user;
@property (nonatomic, retain) NSString *mid;
@property (nonatomic, retain) NSString *idstr;
@property (nonatomic, assign) int screenNameHeight;
@property (nonatomic, retain) NSString *profile_image_url;
@property (nonatomic, retain) NSDictionary *status;
@property (nonatomic, retain) NSDictionary *reply_comment;
@property (nonatomic, assign) int textHeight;
//图文混排的信息
@property (nonatomic,retain)NSMutableAttributedString* attString;//存储富文本
@property (nonatomic,retain)NSMutableAttributedString* attReString;
@property (nonatomic,retain)NSMutableArray* imgs;//存储图片
@property (nonatomic,retain)NSMutableArray* imgs2;
@property (nonatomic,retain)NSMutableArray* user_arr;//@的用户数组
@property (nonatomic,retain)NSMutableArray* reUser_arr;
@property (nonatomic,retain)NSMutableArray* topic_arr;//话题数组
@property (nonatomic,retain)NSMutableArray* reTopic_arr;
//得到创建日期和来源
@property (nonatomic,copy)NSString* date;
@property (nonatomic,copy)NSString* from;
-(int)getTotalHeight;
@end
