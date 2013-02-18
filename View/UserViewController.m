//
//  UserViewController.m
//  MyRealWeiBo
//
//  Created by 王芝宝 on 13-1-28.
//  Copyright (c) 2013年 王芝宝. All rights reserved.
//

#import "UserViewController.h"
#import "AppDelegate.h"
#import "FollowerViewController.h"
@interface UserViewController ()

@end

@implementation UserViewController
@synthesize mySina;
@synthesize table;
@synthesize screenName;
@synthesize headerView;
@synthesize headerVImageV;
@synthesize headerVNameLB;
@synthesize weiboCount;
@synthesize followerCount;
@synthesize followingCount;
-(void)dealloc{
    [super dealloc];
    [userInfo release];
    self.table = nil;
    self.headerVImageV = nil;
    self.headerVNameLB = nil;
    self.weiboCount = nil;
    self.followerCount = nil;
    self.followingCount = nil;
    
    self.headerView = nil;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidLoad{
        [super viewDidLoad];
    self.title=self.screenName;
    scro.userInteractionEnabled=YES;
    scro.pagingEnabled=YES;
    scro=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 142, 320, 66)];
    scro.contentSize=CGSizeMake(9*70, 66);
    scro.alwaysBounceHorizontal=YES;
    scro.alwaysBounceVertical=NO;
    scro.indicatorStyle=UIScrollViewIndicatorStyleWhite;
    scro.showsHorizontalScrollIndicator=NO;
    scro.showsVerticalScrollIndicator=NO;
    [self.headerView addSubview:scro];
    [scro release];
    NSArray *info=[[NSArray alloc]init];
    info=[NSArray arrayWithObjects:@"详细资料",@"关注",@"粉丝",@"攒",@"话题",@"分组",@"相册",@"书包",@"游戏",nil];
    for (int i=0;i<9;i++) {
        UIButton *aview=[[UIButton alloc]initWithFrame:CGRectMake(i*70, 0, 60, 60)];
                UIColor *color =[UIColor colorWithRed:(arc4random()%256)/255.0f
                               
                                              green:(arc4random()%256)/255.0f
                               
                                               blue:(arc4random()%256)/255.0f
                               
                                              alpha:1.0f];
        if (i==2) {
            [aview addTarget:self action:@selector(gotoFollowedVC:) forControlEvents:UIControlEventTouchUpInside];
        }
        aview.backgroundColor=color;
        aview.layer.cornerRadius=15;
            UILabel *lable1=[[UILabel alloc]init];
            lable1.frame=CGRectMake(5, 15, 50, 30);
            lable1.text=[info objectAtIndex:i];
            lable1.font=[UIFont fontWithName:@"ArialMT" size:12];
            lable1.backgroundColor=color;
            lable1.textAlignment=NSTextAlignmentCenter;
            [aview addSubview:lable1];
            [scro addSubview:aview];
        [lable1 release];
            [aview release];
    }
    
    //设置滑动的长和宽
    
    //scro.contentSize=CGSizeMake(4*320,480);
    scro.delegate=self;
    _weiboData=[[NSMutableArray alloc]init];
    self.headerVNameLB.text=screenName;
    [table setTableHeaderView:self.headerView];
    UIApplication *app = [UIApplication sharedApplication];
    AppDelegate *delegate = app.delegate;
    self.mySina = delegate.myWeibo;

    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setValue:self.screenName forKey:@"screen_name"];
    SinaWeiboRequest* request = [self.mySina requestWithURL:@"users/show.json" params:dic httpMethod:@"GET" delegate:nil];
    
    [request setResultBlock:^(SinaWeiboRequest *request, id obj)//获得l微博数据，提取出数据，给cell赋值
     {
         userInfo=[[User alloc]init];
         userInfo.screen_name=[obj valueForKey:@"screen_name"];
         userInfo.profile_image_url=[obj valueForKey:@"profile_image_url"];
         NSURL *url=[NSURL URLWithString:userInfo.profile_image_url];
         [self.headerVImageV setImageWithURL:url placeholderImage:[UIImage imageNamed:@"4.jpg"]];
         self.weiboCount.text=[[obj valueForKey:@"statuses_count"] stringValue];
         
         self.followerCount.text=[[obj valueForKey:@"followers_count"] stringValue];
         self.followingCount.text=[[obj valueForKey:@"friends_count"] stringValue];
        // NSLog(@"qqqqq  %@",obj);
         [table reloadData];
     }];
    [request setFailBlock:^(SinaWeiboRequest *request, id obj) {

        
    }];
    [request connect];
    [self refreshActon:nil];
}
-(void)refreshActon:(id)sender
{
    //收微博
    [_weiboData removeAllObjects];
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setValue:self.screenName forKey:@"screen_name"];
    SinaWeiboRequest* request = [self.mySina requestWithURL:@"statuses/user_timeline.json" params:dic httpMethod:@"GET" delegate:nil];
    
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
                 [statuse release];
                 
             }
             
             
         }
         [table reloadData];
     }];
    
    [request setFailBlock:^(SinaWeiboRequest *request, id obj) {
        NSLog(@"%@",obj);
    }];
    [request connect];
}
- (void)imageTappedAction:(id)cell
{
    NSString *ns=nil;
    NSIndexPath *ind= [table indexPathForCell:cell];
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
    [imagecontroller.view addSubview:showimage];
    
    
    
    UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chufa:)];
    singleTap.numberOfTouchesRequired=1;
    singleTap.numberOfTapsRequired=1;
    [showimage addGestureRecognizer:singleTap];
    
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
-(void)peopeleDetailInfo:(id)cell{
    NSString *ns=nil;
    NSIndexPath *ind= [table indexPathForCell:cell];
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
    Status* aStatus = [_weiboData objectAtIndex:indexPath.row];
    
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
            [cell setCellFormat:aStatus];
            cell.delegate = self;
            break;
        }
    }
    return cell;
}
-(void)pushuserName:(NSString *)name{
    UserViewController *de=[[UserViewController alloc]initWithNibName:@"UserViewController" bundle:nil];
    de.screenName=name;
    de.title=name;
    [self.navigationController pushViewController:de animated:YES];
}


- (IBAction)gotoFollowedVC:(id)sender {
    FollowerViewController *follow=[[FollowerViewController alloc]init];
    follow.name=self.screenName;
    [self.navigationController pushViewController:follow animated:YES];
}

- (IBAction)gotoFollowingVC:(id)sender
{
    
    }



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
