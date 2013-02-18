//
//  SendWeiboViewController.h
//  Weibo
//  
//  Created by Aaron on 13-1-22.
//  Copyright (c) 2013年 徐赢. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmotionScrollView.h"
#import "ContactsTableViewController.h"
@interface SendWeiboViewController : UIViewController<UITextViewDelegate,EmotionScrollViewDelegate,ContactsTableViewControllerDelegate>
{
    UIWindow *statusbarWindow;
    BOOL isNotEmotion;
    CGRect keyboardFrame;

    
}


@property(nonatomic,retain)UITextView *textView;
@property(nonatomic,retain)UIView *locationView;
@property(nonatomic,retain)UIImageView *locationImageView;
@property(nonatomic,retain)UILabel *locationLabel;
@property(nonatomic,retain)UILabel *showRemianCount;
@property(nonatomic,retain)UIButton *clearTextButton;

@property(nonatomic,retain)UIView *footerView;
@property(nonatomic,retain)UIButton *button1;
@property(nonatomic,retain)UIButton *button2;
@property(nonatomic,retain)UIButton *button3;
@property(nonatomic,retain)UIButton *button4;
@property(nonatomic,retain)UIButton *button5;

@property(nonatomic,retain)EmotionScrollView *emotionScrollView;


@end
