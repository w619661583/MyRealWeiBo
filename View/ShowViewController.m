//
//  ShowViewController.m
//  MyRealWeiBo
//
//  Created by 王芝宝 on 13-1-24.
//  Copyright (c) 2013年 王芝宝. All rights reserved.
//

#import "ShowViewController.h"

@interface ShowViewController ()

@end

@implementation ShowViewController
@synthesize imageShow;

- (void)viewDidLoad
{
    self.view.frame=CGRectMake(0, 0, 320, 480);
    self.view.backgroundColor=[UIColor blackColor];
    self.view.layer.opacity=1;
    self.imageShow.userInteractionEnabled=YES;
    self.imageShow=[[UIImageView alloc]initWithFrame:CGRectMake(60,40, 200, 400)];
    [self.view addSubview:self.imageShow];
    UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chufa:)];
    singleTap.numberOfTapsRequired=1;
    [self.imageShow addGestureRecognizer:singleTap];


    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
-(void)chufa:(UITapGestureRecognizer *)tap{
    [self dismissViewControllerAnimated:YES completion:^{}];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
