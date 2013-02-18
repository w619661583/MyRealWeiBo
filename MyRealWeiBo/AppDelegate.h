//
//  AppDelegate.h
//  MyRealWeiBo
//
//  Created by 王芝宝 on 13-1-20.
//  Copyright (c) 2013年 王芝宝. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    SinaWeibo * _myWeibo;
}

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,retain)SinaWeibo *myWeibo;
@end
