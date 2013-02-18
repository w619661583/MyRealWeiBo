//
//  HuatiViewController.m
//  MyRealWeiBo
//
//  Created by 王芝宝 on 13-1-31.
//  Copyright (c) 2013年 王芝宝. All rights reserved.
//

#import "HuatiViewController.h"
#import "AppDelegate.h"
@interface HuatiViewController ()

@end

@implementation HuatiViewController
@synthesize huati;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        _huatiArray=[[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIApplication *app = [UIApplication sharedApplication];
    AppDelegate *delegate = app.delegate;
    self.mySina = delegate.myWeibo;
    //收微博
    [_huatiArray removeAllObjects];
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
                 [_huatiArray addObject:statuse];//往数组中添加数据
                 [statuse release];
                 
             }
             
             
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
