//
//  DetailController.m
//  MyRealWeiBo
//
//  Created by 王芝宝 on 13-1-23.
//  Copyright (c) 2013年 王芝宝. All rights reserved.
//

#import "DetailController.h"
#import "NameCell.h"
#import "SinaWeibo.h"
#import "AppDelegate.h"
#import "Commont.h"
#import "CommentCell.h"
#import "UserViewController.h"
#import "HuatiViewController.h"
@interface DetailController ()

@end

@implementation DetailController
@synthesize sta;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)dealloc{
    [super dealloc];
    [_weiboPinglun release];
    [_weiboZhuanFa release];
    [_mySina release];
    
}

- (void)viewDidLoad
{
    
    //下拉刷新
    self.refresh = [[ODRefreshControl alloc]initInScrollView:self.tableView];
    [self.refresh addTarget:self action:nil forControlEvents:UIControlEventValueChanged];
    self.title=@"博文详情";
    [super viewDidLoad];
    UIApplication *app = [UIApplication sharedApplication];
    AppDelegate *delegate = app.delegate;
    self.mySina = delegate.myWeibo;
    _weiboPinglun=[[NSMutableArray alloc]init];
    _weiboZhuanFa=[[NSMutableArray alloc]init];
    self.refresh = [[ODRefreshControl alloc]initInScrollView:self.tableView];
    [self.refresh addTarget:self action:@selector(refreshActon) forControlEvents:UIControlEventValueChanged];

    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithCapacity:1];
    NSString *instr=sta.idstr;
    [dic setValue:instr forKey:@"id"];
    SinaWeiboRequest* request = [self.mySina requestWithURL:@"comments/show.json" params:dic httpMethod:@"GET" delegate:nil];
    
    [request setResultBlock:^(SinaWeiboRequest *request, id obj)//获得l微博数据，提取出数据，给cell赋值
     {
        
         
         if([obj isKindOfClass:[NSDictionary class]])
         {
              //NSLog(@"ddqdqdqdqdqdqdqdqdqdqdqdq%@",obj);
             NSArray* comments = [obj valueForKey:@"comments"];
             for(NSDictionary* comment in comments)
             {
                 Commont *comm=[[Commont alloc]init];
                 comm.created_at=[comment valueForKey:@"created_at"];

                 comm.ID=[comment valueForKey:@"id"];
                 comm.mid=[comment valueForKey:@"mid"];
                 comm.source=[comment valueForKey:@"source"];
                 comm.text=[comment valueForKey:@"text"];
                 comm.idstr=[comment valueForKey:@"idstr"];
                 comm.user=[comment valueForKey:@"user"];
                 [_weiboPinglun addObject:comm];
             }

         }
         [self.tableView reloadData];
         [self.refresh endRefreshing];
     }];
    
    [request setFailBlock:^(SinaWeiboRequest *request, id obj) {
    }];
    [request connect];

}
-(void)refreshActon{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    int i= 3+_weiboPinglun.count;

    
          return i;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    int i=indexPath.row;
    if (i==0) {
        return 60;
    }else if(i==1){
        
        return [self.sta getTotalHeight];
    }else if(i==2){
        return 30;
    }
    else {
        Commont *com=[_weiboPinglun objectAtIndex:i-3];
        return [com getTotalHeight];
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row==0) {
        static NSString *CellIdentifier = @"Cell";
        NameCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        if (cell==nil) {
            cell=[[NameCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
            [cell setCellFormat:self.sta];
             return cell;
        
    }else if(indexPath.row==1){
        Status *aStatus=self.sta;
        int type = aStatus.type;
        
        WeiboCell* cell = nil;
        switch (type)
        {
            case StatuseTypeText:
            {
                static NSString *ID1 = @"TextCell";
                cell = [tableView dequeueReusableCellWithIdentifier:ID1];
                if(cell == nil)
                {
                    cell = [[[TextCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID1] autorelease];
                }
                [cell.backgroundView setFrame:CGRectMake(0, 0, 320, 66)];
                cell.backgroundColor=[UIColor clearColor];
                cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bac.png"]];
                cell.delegate = self;

                [cell setCellFormat:aStatus];
                break;
            }
            case StatuseTypeTextImage:
            {
                static NSString* ID2 = @"ImgCell";
                cell = [tableView dequeueReusableCellWithIdentifier:ID2];
                if(cell == nil)
                {
                    cell = [[[ImageCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID2] autorelease];
                }
                [cell.backgroundView setFrame:CGRectMake(0, 0, 320, 66)];
                cell.backgroundColor=[UIColor clearColor];
                cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bac.png"]];
                cell.delegate = self;

                [cell setCellFormat:aStatus];
                break;
            }
                
            case StatuseTypeReText:
            {
                static NSString* ID3 = @"ReTextCell";
                cell = [tableView dequeueReusableCellWithIdentifier:ID3];
                if(cell == nil)
                {
                    cell = [[[ReTextCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID3] autorelease];
                }
                [cell.backgroundView setFrame:CGRectMake(0, 0, 320, 66)];
                cell.backgroundColor=[UIColor clearColor];
                cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bac.png"]];
                cell.delegate = self;

                [cell setCellFormat:aStatus];
                break;
            }
            case StatuseTypeReImage:
            {
                static NSString* ID4 = @"ReImgCell";
                cell = [tableView dequeueReusableCellWithIdentifier:ID4];
                if(cell == nil)
                {
                    cell = [[[ReImageCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID4] autorelease];
                }
                [cell.backgroundView setFrame:CGRectMake(0, 0, 320, 66)];
                cell.backgroundColor=[UIColor clearColor];
                cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bac.png"]];
                cell.delegate = self;

                [cell setCellFormat:aStatus];
                break;
            }
        }
        return cell;

    }else if(indexPath.row==2){
        static NSString *cellIdentifier=@"thridcell";
        UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame=CGRectMake(10, 5, 60, 25);
        [button setTitle:@"评论:" forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont fontWithName:@"ArialMT" size:9];
        UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(70, 5, 3, 25)];
        lable.text=@"|";
         UIButton *button1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        button1.frame=CGRectMake(73, 5, 60, 25);
        [button1 setTitle:@"转发:" forState:UIControlStateNormal];
        button1.titleLabel.font=[UIFont fontWithName:@"ArialMT" size:9];
        [cell.contentView addSubview:button1];
        [cell.contentView addSubview:lable];
        [cell.contentView addSubview:button];
        return cell;
   }
    else{
        static NSString *CellIdentifier=@"forcell";
        CommentCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell==nil) {
            cell=[[CommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
        }
        [cell setCellFormat:[_weiboPinglun objectAtIndex:indexPath.row-3]];
        return cell;

    }
   
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
    if (indexPath.row==0) {
        UserViewController *user=[[UserViewController alloc]initWithNibName:@"UserViewController" bundle:nil];
        user.screenName=sta.screenName;
        [self.navigationController pushViewController:user animated:YES];
    }
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
