//
//  AppDelegate.m
//  MyRealWeiBo
//
//  Created by 王芝宝 on 13-1-20.
//  Copyright (c) 2013年 王芝宝. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "MeViewController.h"
#import "SquareViewController.h"
#import "MoreViewController.h"

@implementation AppDelegate
#ifndef kWBSDKDemoAppKey
#define kWBSDKDemoAppKey @"259481061"
#endif

#ifndef kWBSDKDemoAppSecret
#define  kWBSDKDemoAppSecret @"cf5057008747f1d4ccb5337aac0bd0e7"
#endif
@synthesize myWeibo = _myWeibo;
- (void)dealloc
{
    self.myWeibo = nil;
    [_window release];
    [super dealloc];
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.myWeibo = [[SinaWeibo alloc]initWithAppKey:kWBSDKDemoAppKey appSecret:kWBSDKDemoAppSecret appRedirectURI:@"http://www.baidu.com" andDelegate:nil];
    
    [self.myWeibo setDidLogInBlock:^(SinaWeibo *sinaweibo) {
        NSLog(@"登录成功！");
        NSMutableArray *authData = [NSMutableDictionary dictionary];
        [authData setValue:sinaweibo.accessToken forKey:@"AccessTokenKey"];
        [authData setValue:sinaweibo.expirationDate forKey:@"ExpirationDateKey"];
        [authData setValue:sinaweibo.userID forKey:@"UserIDKey"];
        [authData setValue:sinaweibo.refreshToken forKey:@"refresh_token"];
        [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }];
    
    
    [self.myWeibo setlogInDidFailBlock:^(SinaWeibo *sinaweibo, NSError *error) {
        NSLog(@"登录失败！");
        NSLog(@"error:%@",error.description);
    }];
    
    
    NSDictionary *authData = [[NSUserDefaults standardUserDefaults] valueForKey:@"SinaWeiboAuthData"];
    self.myWeibo.accessToken = [authData objectForKey:@"AccessTokenKey"];
    self.myWeibo.expirationDate = [authData objectForKey:@"ExpirationDateKey"];
    self.myWeibo.userID = [authData objectForKey:@"UserIDKey"];
    
    
    HomeViewController *home = [[HomeViewController alloc]init];
    UINavigationController *homeNavi = [[UINavigationController alloc]initWithRootViewController:home];
    homeNavi.tabBarItem = [[[UITabBarItem alloc]initWithTitle:@"主页" image:[UIImage imageNamed:@"tabbar_home_highlighted.png"] tag:2001] autorelease];
    [home release];
    MessageViewController *message = [[MessageViewController alloc]init];
    UINavigationController *messageNavi = [[UINavigationController alloc]initWithRootViewController:message];
    messageNavi.tabBarItem = [[[UITabBarItem alloc]initWithTitle:@"信息" image:[UIImage imageNamed:@"contacts_message.png"] tag:2002] autorelease];
    [message release];
    
    MeViewController *me = [[MeViewController alloc]init];
    UINavigationController *meNavi = [[UINavigationController alloc]initWithRootViewController:me];
    meNavi.tabBarItem = [[[UITabBarItem alloc]initWithTitle:@"我的资料" image:[UIImage imageNamed:@"微博 3.2.2_Payload_Weibo.app_tabbar_profile_selected.png"] tag:2003] autorelease];
    [me release];
    
    SquareViewController *square = [[SquareViewController alloc]init];
    UINavigationController *squareNavi = [[UINavigationController alloc]initWithRootViewController:square];
    squareNavi.tabBarItem = [[[UITabBarItem alloc]initWithTitle:@"广场" image:[UIImage imageNamed:@"tabbar_discover_highlighted.png"] tag:2004] autorelease];
    [square release];
    MoreViewController *more = [[MoreViewController alloc]init];
    UINavigationController *moreNavi = [[UINavigationController alloc]initWithRootViewController:more];
    moreNavi.tabBarItem = [[[UITabBarItem alloc]initWithTitle:@"更多" image:[UIImage imageNamed:@"微博 3.2.2_Payload_Weibo.app_tabbar_more.png"] tag:2005] autorelease];
    [more release];
    
    UITabBarController *tab = [[UITabBarController alloc]init];
    tab.viewControllers = [NSArray arrayWithObjects:homeNavi,messageNavi,meNavi,squareNavi,moreNavi, nil];
    [moreNavi release];
    [squareNavi release];
    [meNavi release];
    [messageNavi release];
    [homeNavi release];
    
    
    self.window.rootViewController = tab;
    [tab release];
    
    if ([self.myWeibo isAuthValid] == NO)
    {
        [self.myWeibo logIn];
    }

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
