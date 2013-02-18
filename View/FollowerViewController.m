//
//  FollowerViewController.m
//  MyRealWeiBo
//
//  Created by 王芝宝 on 13-1-30.
//  Copyright (c) 2013年 王芝宝. All rights reserved.
//

#import "FollowerViewController.h"
#import "AppDelegate.h"
#import "User.h"
#import "UserViewController.h"
@interface FollowerViewController ()

@end

@implementation FollowerViewController
@synthesize name=_name;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.title=@"粉丝列表";
    [super viewDidLoad];
    _weiboData=[[NSMutableArray alloc]init];
    UIApplication *app = [UIApplication sharedApplication];
    AppDelegate *delegate = app.delegate;
    self.mySina = delegate.myWeibo;
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setValue:self.name forKey:@"screen_name"];
    SinaWeiboRequest* request = [self.mySina requestWithURL:@"friendships/friends.json" params:dic httpMethod:@"GET" delegate:nil];
    
    [request setResultBlock:^(SinaWeiboRequest *request, id obj)//获得l微博数据，提取出数据，给cell赋值
     {
         //NSLog(@"1111111111111111111   %@",obj);
         NSMutableArray *dic=[[NSMutableArray alloc]init];
          dic=[obj valueForKey:@"users"];
         for (NSDictionary *d in dic) {
             NSLog(@"ddddddddddd   %@",d);
             User* userInfo=[[User alloc]init];
             userInfo.screen_name=[d valueForKey:@"screen_name"];
             NSLog(@"screenname===%@",userInfo.screen_name);
             userInfo.profile_image_url=[d valueForKey:@"profile_image_url"];
             NSLog(@"pro===%@",userInfo.profile_image_url);
             userInfo.description=[d valueForKey:@"description"];
             [_weiboData addObject:userInfo];
         }
        
         [self.tableView reloadData];
     }];
    [request setFailBlock:^(SinaWeiboRequest *request, id obj) {
        
        
    }];
    [request connect];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return _weiboData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    User *user=[_weiboData objectAtIndex:indexPath.row];
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    UIImageView *iag=[[UIImageView alloc]initWithFrame:CGRectMake(6, 6, 30, 30)];
    [iag setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"4.jpg"]];
    //NSLog(@"image===%@",user.profile_image_url);
    [cell.contentView addSubview:iag];
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(42, 10, 140, 30)];
    lable.text=user.screen_name;
    //NSLog(@"lable.text===%@",lable.text);

    [cell.contentView addSubview:lable];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    User *user=[_weiboData objectAtIndex:indexPath.row];
    
    UserViewController *user1=[[UserViewController alloc]initWithStyle:UITableViewStylePlain];
    user1.screenName=user.screen_name;
    user1.title=user.screen_name;
    [self.navigationController pushViewController:user1 animated:YES];
    
     }

@end
