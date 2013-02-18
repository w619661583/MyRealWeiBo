//
//  WriteViewController.h
//  Hello_lemongrass2.0
//
//  Created by Ibokan on 13-1-27.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
@interface WriteViewController : UIViewController<UITextViewDelegate,UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIToolbar *toolBar;
}
@property(nonatomic,retain)SinaWeibo *myWeibo;

@property(nonatomic,retain)UITextView *textView;
@property(nonatomic,retain)UIImageView *imageView;
@property(nonatomic,retain)UIButton *numberButton;

@end
