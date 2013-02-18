//
//  User.h
//  Sina_Blok
//
//  Created by Ibokan on 13-1-15.
//  Copyright (c) 2013年 zhy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Status;

@interface User : NSObject

@property (nonatomic, retain) NSString *idstr;
@property (nonatomic, retain) NSString *screen_name;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, assign) NSString* province;
@property (nonatomic, assign) NSString* city;
@property (nonatomic, retain) NSString *location;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSString *profile_image_url;
@property (nonatomic, retain) NSString *profile_url;
@property (nonatomic, retain) NSString *domain;
@property (nonatomic, retain) NSString *weihao;
@property (nonatomic, retain) NSString *gender;
@property (nonatomic, retain) NSString* followers_count;
@property (nonatomic, retain) NSString* friends_count;
@property (nonatomic, retain) NSString* statuses_count;
@property (nonatomic, retain) NSString* favourites_count;
@property (nonatomic, retain) NSString *created_at;
@property (nonatomic, assign) BOOL following;
@property (nonatomic, assign) BOOL allow_all_act_msg;
@property (nonatomic, assign) BOOL geo_enabled;
@property (nonatomic, assign) BOOL verified;
@property (nonatomic, retain) NSString* verified_type;
@property (nonatomic, retain) NSString *remark;
@property (nonatomic, retain) Status *status;
@property (nonatomic, assign) BOOL allow_all_comment;
@property (nonatomic, retain) NSString *avatar_large;
@property (nonatomic, retain) NSString *verified_reason;
@property (nonatomic, assign) BOOL follow_me;
@property (nonatomic, retain) NSString* online_status;
@property (nonatomic, retain) NSNumber* bi_followers_count;
@property (nonatomic, retain) NSString *lang;

@property(nonatomic,retain)UIImage* userImg;

@end
