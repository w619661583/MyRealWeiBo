//
//  HomeViewController.m
//  MyRealWeiBo
//
//  Created by 王芝宝 on 13-1-21.
//  Copyright (c) 2013年 王芝宝. All rights reserved.
//

#import "HomeViewController.h"
#import "UserViewController.h"
#import "WriteViewController.h"
#import "HuatiViewController.h"
@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize mySina = _mySina;
@synthesize refresh;

-(void)DoSomethingEveryFrame:(NSString *)pa{
   

}
- (void)dealloc
{
    [showimage release];
    self.mySina = nil;
    [_weiboData release];
    _weiboData = nil;
    self.refresh = nil;
    [imagecontroller release];
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //TextPic *pic=[TextPic getINstance];

    //pic.deleagate=self;
	// Do any additional setup after loading the view.
    //获取myweibo
    UIApplication *app = [UIApplication sharedApplication];
    AppDelegate *delegate = app.delegate;
    self.mySina = delegate.myWeibo;
    //导航栏标题
    footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(100, 5, 120, 30);
    [button setTitle:@"点击更多" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(getMore) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:button];
    self.title = @"主页";
    weiboCount=10;
    //初始化tableView
    _weiboView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-49-44) style:UITableViewStylePlain];
    _weiboView.delegate = self;//设置代理
    _weiboView.dataSource = self;
    [self.view addSubview:_weiboView];
    [_weiboView setTableFooterView:footView];
    [_weiboView release];
    
    //下拉刷新
    self.refresh = [[ODRefreshControl alloc]initInScrollView:_weiboView];
    [self.refresh addTarget:self action:@selector(refreshActon:) forControlEvents:UIControlEventValueChanged];
    //初始化数据源
    _weiboData = [[NSMutableArray alloc]init];
    //设置导航栏按钮
    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCompose
                                                                             target:self
                                                                             action:@selector(writeWeibo:)];

    self.navigationItem.leftBarButtonItem=leftButton;
    [leftButton release];
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                              target:self
                                                                              action:@selector(refreshActon:)];
    self.navigationItem.rightBarButtonItem=rightButton; 
    [rightButton release];
    //刷新
    [self refreshActon:nil count:@"10"];
    
}
-(void)writeWeibo:(id)sender{
    
    WriteViewController *data=[[WriteViewController alloc]init];
    data.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:data animated:YES];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
-(void)refreshActon:(id)sender 
{
    //收微博
    [_weiboData removeAllObjects];
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setValue:@"10" forKey:@"count"];
    SinaWeiboRequest* request = [self.mySina requestWithURL:@"statuses/home_timeline.json" params:dic httpMethod:@"GET" delegate:nil];
    
    [request setResultBlock:^(SinaWeiboRequest *request, id obj)//获得l微博数据，提取出数据，给cell赋值
     {
         
         
         if([obj isKindOfClass:[NSDictionary class]])
         {
             NSArray* statuses = [obj valueForKey:@"statuses"];
             for(NSDictionary* sta in statuses)
             {
                 Status* statuse = [[Status alloc] init];
                 statuse.text = [sta valueForKey:@"text"];
                 statuse.idstr = [sta valueForKey:@"idstr"];
                 statuse.created_at = [sta valueForKey:@"created_at"];
                 
                 statuse.source = [sta valueForKey:@"source"];
                 statuse.in_reply_to_status_id = [sta valueForKey:@"in_reply_to_status_id"];
                 statuse.in_reply_to_screen_name = [sta valueForKey:@"in_reply_to_screen_name"];
                 statuse.in_reply_to_user_id = [sta valueForKey:@"in_reply_to_user_id"];
                 statuse.user = [sta valueForKey:@"user"];
                 statuse.reposts_count = [[sta valueForKey:@"reposts_count"] intValue];
                 statuse.comments_count = [[sta valueForKey:@"comments_count"] intValue];
                 statuse.attitudes_count = [[sta valueForKey:@"attitudes_count"] intValue];
                 
                 statuse.thumbnail_pic = [sta valueForKey:@"thumbnail_pic"];
                 statuse.bmiddle_pic = [sta valueForKey:@"bmiddle_pic"];
                 statuse.original_pic = [sta valueForKey:@"original_pic"];
                 statuse.retweeted_status = [sta valueForKey:@"retweeted_status"];
                 
                 statuse.favorited = [[statuse valueForKey:@"favorited"] boolValue];
                 //[arr addObject:statuse];
                 [_weiboData addObject:statuse];//往数组中添加数据
                 [weiboSong addObject:statuse];
                 [statuse release];
                 
             }
             
             
         }
         [_weiboView reloadData];
         [self.refresh endRefreshing];
     }];
    
    [request setFailBlock:^(SinaWeiboRequest *request, id obj) {
        
        
    }];
    [request connect];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)getMore{
    weiboCount+=10;
    NSString *name=[[NSString alloc]initWithFormat:@"%d",weiboCount];
    [self refreshActon:nil count:name];
}

-(void)refreshActon:(id)sender count:(NSString *)count
{
    //收微博
    [_weiboData removeAllObjects];
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setValue:count forKey:@"count"];
    SinaWeiboRequest* request = [self.mySina requestWithURL:@"statuses/home_timeline.json" params:dic httpMethod:@"GET" delegate:nil];
    
    [request setResultBlock:^(SinaWeiboRequest *request, id obj)//获得l微博数据，提取出数据，给cell赋值
     {

         
         if([obj isKindOfClass:[NSDictionary class]])
         {
             NSArray* statuses = [obj valueForKey:@"statuses"];
             for(NSDictionary* sta in statuses)
             {
                 Status* statuse = [[Status alloc] init];
                 statuse.text = [sta valueForKey:@"text"];
                 statuse.idstr = [sta valueForKey:@"idstr"];
                 statuse.created_at = [sta valueForKey:@"created_at"];
                 
                 statuse.source = [sta valueForKey:@"source"];
                 statuse.in_reply_to_status_id = [sta valueForKey:@"in_reply_to_status_id"];
                 statuse.in_reply_to_screen_name = [sta valueForKey:@"in_reply_to_screen_name"];
                 statuse.in_reply_to_user_id = [sta valueForKey:@"in_reply_to_user_id"];
                 statuse.user = [sta valueForKey:@"user"];
                 statuse.reposts_count = [[sta valueForKey:@"reposts_count"] intValue];
                 statuse.comments_count = [[sta valueForKey:@"comments_count"] intValue];
                 statuse.attitudes_count = [[sta valueForKey:@"attitudes_count"] intValue];
                 
                 statuse.thumbnail_pic = [sta valueForKey:@"thumbnail_pic"];
                 statuse.bmiddle_pic = [sta valueForKey:@"bmiddle_pic"];
                 statuse.original_pic = [sta valueForKey:@"original_pic"];
                 statuse.retweeted_status = [sta valueForKey:@"retweeted_status"];
                 
                 statuse.favorited = [[statuse valueForKey:@"favorited"] boolValue];
                 //[arr addObject:statuse];
                 [_weiboData addObject:statuse];//往数组中添加数据
                 [weiboSong addObject:statuse];
                 [statuse release];

             }
             

     }
         [_weiboView reloadData];
         [self.refresh endRefreshing];
     }];
    
    [request setFailBlock:^(SinaWeiboRequest *request, id obj) {

        
    }];
    [request connect];
}
#pragma mark- tableView datasource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Status *dic = [_weiboData objectAtIndex:indexPath.row];
    return [dic getTotalHeight];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _weiboData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Status* aStatus= [_weiboData objectAtIndex:indexPath.row];

    int type = aStatus.type;
    
    WeiboCell* cell = nil;
    switch (type)
    {
        case StatuseTypeText:
        {
            static NSString *name = @"TextCell";
            cell = [tableView dequeueReusableCellWithIdentifier:name];
            if(cell == nil)
            {
                cell = [[[TextCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:name] autorelease];
            }
            [cell.backgroundView setFrame:CGRectMake(0, 0, 320, 66)];
            cell.backgroundColor=[UIColor clearColor];
            cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bac.png"]];
            [cell setCellFormat:aStatus];
            cell.delegate=self;
            break;
        }
        case StatuseTypeTextImage:
        {
            static NSString* name2 = @"ImgCell";
            cell = [tableView dequeueReusableCellWithIdentifier:name2];
            if(cell == nil)
            {
                

                cell = [[[ImageCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:name2] autorelease];
            }
            [cell.backgroundView setFrame:CGRectMake(0, 0, 320, 66)];
            cell.backgroundColor=[UIColor clearColor];
            cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bac.png"]];
            [cell setCellFormat:aStatus];
            cell.delegate = self;
            break;
        }
            
        case StatuseTypeReText:
        {
            static NSString* name3 = @"ReTextCell";
            cell = [tableView dequeueReusableCellWithIdentifier:name3];
            if(cell == nil)
            {
                cell = [[[ReTextCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:name3] autorelease];
            }
            [cell setCellFormat:aStatus];
            cell.delegate=self;
            [cell.backgroundView setFrame:CGRectMake(0, 0, 320, 66)];
            cell.backgroundColor=[UIColor clearColor];
            cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bac.png"]];
            break;
        }
        case StatuseTypeReImage:
        {
            static NSString* name4 = @"ReImgCell";
            cell = [tableView dequeueReusableCellWithIdentifier:name4];
            if(cell == nil)
            {
                cell = [[[ReImageCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:name4] autorelease];
            }
            [cell.backgroundView setFrame:CGRectMake(0, 0, 320, 66)];
            cell.backgroundColor=[UIColor clearColor];
            cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bac.png"]];
            [cell setCellFormat:aStatus];
            cell.delegate = self;
            break;
        }
    }
    return cell;
}

#pragma mark-tableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailController *detail = [DetailController new];
    detail.sta = [_weiboData objectAtIndex:indexPath.row];
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
    [detail release];
}

- (void)imageTappedAction:(id)cell
{
    NSString *ns=nil;
    NSIndexPath *ind= [_weiboView indexPathForCell:cell];
    Status *st=[_weiboData objectAtIndex:ind.row];

    if (st.rethumbnail_pic==nil) {
        ns=st.bmiddle_pic;
    }else{
        ns=st.rebmiddle_pic ;
    }
        
    imagecontroller=[[UIViewController alloc]init];
    imagecontroller.view.frame=CGRectMake(0, 0, 320, 480);
    imagecontroller.view.backgroundColor=[UIColor blackColor];
    imagecontroller.view.layer.opacity=1;
    showimage=[[UIImageView alloc]initWithFrame:CGRectMake(60,40, 200, 400)];
    showimage.userInteractionEnabled=YES;
    UIScrollView *sc=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    [sc addSubview:showimage];
    [imagecontroller.view addSubview:sc];
    sc.directionalLockEnabled=NO;
    sc.pagingEnabled=YES;
    sc.showsVerticalScrollIndicator=YES;
    sc.showsHorizontalScrollIndicator=YES;

    UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chufa:)];
    singleTap.numberOfTouchesRequired=1;
    singleTap.numberOfTapsRequired=1;
    [showimage addGestureRecognizer:singleTap];
    UIPinchGestureRecognizer *pin=nil;
    pin=[[UIPinchGestureRecognizer alloc]initWithTarget:self
                                                 action:@selector(pinp:)];
    [showimage addGestureRecognizer:pin];
    [pin release];
    UITapGestureRecognizer *singleTap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fangda:)];
    singleTap1.numberOfTapsRequired=2;
    singleTap1.numberOfTouchesRequired=1;
    [showimage addGestureRecognizer:singleTap1];
    
    showimage.contentMode=UIViewContentModeScaleAspectFit;
    [singleTap requireGestureRecognizerToFail:singleTap1];
        NSURL *url=[NSURL URLWithString:ns];
    [showimage setImageWithURL:url placeholderImage:[UIImage imageNamed:@"4.png"]];
    [self presentViewController:imagecontroller animated:YES completion:^{}];
}
-(void)pinp:(UIPinchGestureRecognizer *)agre{
    showimage.transform=CGAffineTransformMakeScale(agre.scale, agre.scale);
}
-(void)peopeleDetailInfo:(id)cell{
    NSString *ns=nil;
    NSIndexPath *ind= [_weiboView indexPathForCell:cell];
    Status *st=[_weiboData objectAtIndex:ind.row];
    ns=st.screenName;
    UserViewController *user=[[UserViewController alloc]initWithNibName:@"UserViewController" bundle:nil];
    user.screenName=ns;
    [self.navigationController pushViewController:user animated:YES];
}
-(void)chufa:(UITapGestureRecognizer *)tap  {
    [self dismissViewControllerAnimated:YES completion:^{}];

}
-(void)fangda:(UITapGestureRecognizer *)tap{
     [CATransaction begin];
    [CATransaction setValue:[NSNumber numberWithFloat:1.0f]
                     forKey:kCATransactionAnimationDuration];
    CABasicAnimation *shrinkAnimation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    shrinkAnimation.delegate=self;
    shrinkAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    shrinkAnimation.toValue=[NSNumber numberWithFloat:2.0f];
    CGRect cg=showimage.frame;
    CGFloat w1;
    CGFloat h1;
    if (cg.size.width>400) {
        w1=cg.size.width/1.8;
        h1=cg.size.height/1.8;
    }else {
        w1=cg.size.width*1.8;
        h1=cg.size.height*1.8;
    }
   
    showimage.frame=CGRectMake(0, 0, w1, h1);
    showimage.center=imagecontroller.view.center;
    [[showimage layer]addAnimation:shrinkAnimation forKey:@"shrinkAnimation"];
    [CATransaction commit];

}
-(void)pushuserName:(NSString *)name{
    UserViewController *de=[[UserViewController alloc]initWithNibName:@"UserViewController" bundle:nil];
    de.screenName=name;
    de.title=name;
    [self.navigationController pushViewController:de animated:YES];
}
-(void)pushuserHuati:(NSString *)huati{
    HuatiViewController *de=[[HuatiViewController alloc]initWithStyle:UITableViewStylePlain];
    de.huati=huati;
    de.title=huati;
    [self.navigationController pushViewController:de animated:YES];
}
@end
