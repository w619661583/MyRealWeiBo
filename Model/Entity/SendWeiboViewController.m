//
//  SendWeiboViewController.m
//  Weibo
//
//  Created by Aaron on 13-1-22.
//  Copyright (c) 2013年 徐赢. All rights reserved.
//

#import "SendWeiboViewController.h"
#import "CustomSendNavigationBar.h"
#import "ContactsTableViewController.h"
@interface SendWeiboViewController ()

@end

@implementation SendWeiboViewController

-(void)dealloc
{
    
    [_textView release];
    [_locationView release];
    [_locationLabel release];
    [_clearTextButton release];
    [_footerView release];
    [_button1 release];
    [_button2 release];
    [_button3 release];
    [_button4 release];
    [_button5 release];

    [self.emotionScrollView removeFromSuperview];
    self.emotionScrollView =nil;
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        isNotEmotion=NO;
      
    }
    return self;
}

-(void)setRefreshWindow{
    CGRect frame = CGRectMake(0.0, 0.0, 320.0, 20.0);
     statusbarWindow = [[UIWindow alloc] initWithFrame:frame];
    [statusbarWindow setBackgroundColor:[UIColor clearColor]];
    [statusbarWindow setWindowLevel:UIWindowLevelStatusBar+1.0f];
    
    // 添加自定义子视图
    UIImageView *customView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 0, 120, 20)];
//    customView.image=[UIImage imageNamed:@"数据刷新栏.png"];
    customView.backgroundColor=[UIColor redColor];
    //    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(100, 0, 100, 20)];
    //    //    label.backgroundColor=[UIColor clearColor];
    //    label.text=@"数据正在刷新";
    //    [customView addSubview:label];
    [statusbarWindow addSubview:customView];
    [statusbarWindow makeKeyAndVisible];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self setRefreshWindow];
	// Do any additional setup after loading the view.
    self.navigationItem.title=@"发表新微博";
    self.textView=[[[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, 300)] autorelease];
    self.textView.font=[UIFont systemFontOfSize:20.0f];
    self.textView.delegate=self;
    [self.textView becomeFirstResponder];

    
    [self.view addSubview:self.textView];
    
    //自定义navigationbar
    CustomSendNavigationBar *customBar=[[CustomSendNavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [customBar.cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationController.navigationBar addSubview:customBar];
    [customBar release];
    
    //footerView
    self.footerView=[[[UIView alloc] initWithFrame:CGRectMake(0, 568-44, 320, 44)] autorelease];
    self.footerView.backgroundColor=[UIColor whiteColor];
    self.button1=[UIButton buttonWithType:UIButtonTypeCustom];
    self.button1.frame=CGRectMake(0, 0, 64, 44);
    [self.button1 setImage:[UIImage imageNamed:@"compose_locatebutton_background"] forState:UIControlStateNormal];
    [self.button1 setImage:[UIImage imageNamed:@"compose_locatebutton_background_highlighted"] forState:UIControlStateHighlighted];
    [self.footerView addSubview:self.button1];

    self.button2=[UIButton buttonWithType:UIButtonTypeCustom];
    self.button2.frame=CGRectMake(64, 0, 64, 44);
    [self.button2 setImage:[UIImage imageNamed:@"compose_camerabutton_background"] forState:UIControlStateNormal];
    [self.button2 setImage:[UIImage imageNamed:@"compose_camerabutton_background_highlighted"] forState:UIControlStateHighlighted];
    [self.footerView addSubview:self.button2];
    
    self.button3=[UIButton buttonWithType:UIButtonTypeCustom];
    self.button3.frame=CGRectMake(64*2, 0, 64, 44);
    [self.button3 setImage:[UIImage imageNamed:@"compose_trendbutton_background"] forState:UIControlStateNormal];
    [self.button3 setImage:[UIImage imageNamed:@"compose_trendbutton_background_highlighted"] forState:UIControlStateHighlighted];
    [self.footerView addSubview:self.button3];
    
    self.button4=[UIButton buttonWithType:UIButtonTypeCustom];
    self.button4.frame=CGRectMake(64*3, 0, 64, 44);
    [self.button4 setImage:[UIImage imageNamed:@"compose_mentionbutton_background"] forState:UIControlStateNormal];
    [self.button4 setImage:[UIImage imageNamed:@"compose_mentionbutton_background_highlighted"] forState:UIControlStateHighlighted];
    [self.button4 addTarget:self action:@selector(button4Action:) forControlEvents:UIControlEventTouchUpInside];
    [self.footerView addSubview:self.button4];
    
    self.button5=[UIButton buttonWithType:UIButtonTypeCustom];
    self.button5.frame=CGRectMake(64*4, 0, 64, 44);
    [self.button5 setImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
    [self.button5 setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateHighlighted];
    [self.button5 addTarget:self action:@selector(button5Action:) forControlEvents:UIControlEventTouchUpInside];
    [self.footerView addSubview:self.button5];
    
    
    //locationView
    self.locationView=[[[UIView alloc] initWithFrame:CGRectMake(0, 568-44-23, 320, 23)] autorelease];
    self.locationView.backgroundColor=[UIColor whiteColor];

    
    self.locationImageView=[[[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 48, 23)] autorelease];
    UIImage *placeImage=[UIImage imageNamed:@"compose_placebutton_background"];
    placeImage= [placeImage resizableImageWithCapInsets:UIEdgeInsetsMake(10, 23, 10, 23) resizingMode:UIImageResizingModeStretch];
    self.locationImageView.image=placeImage;
    [self.locationView addSubview:self.locationImageView];
    
    
    self.showRemianCount=[[[UILabel alloc] initWithFrame:CGRectMake(320-50, 0, 30, 23)] autorelease];

    self.showRemianCount.text=@"140";
    [self.locationView addSubview:self.showRemianCount];
    
    self.clearTextButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.clearTextButton.frame=CGRectMake(320-20, 5.5, 12, 12);

    [self.clearTextButton setBackgroundImage:[UIImage imageNamed:@"clearbutton_background"] forState:UIControlStateNormal];
    [self.clearTextButton addTarget:self action:@selector(clearTextButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.locationView addSubview:self.clearTextButton];
    

    
}

-(void)viewWillAppear:(BOOL)animated
{
    //注册键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification {

    NSDictionary *userInfo = [notification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [self moveInputBarWithKeyboardHeight:keyboardRect.size.height withDuration:animationDuration];
}
-(void)moveInputBarWithKeyboardHeight:(float)keyboardHeight withDuration:(NSTimeInterval)duration
{
    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    
    [tempWindow addSubview:self.footerView];    // 注意这里直接加到window上
    [tempWindow addSubview:self.locationView];
    

  
    [UIView beginAnimations:nil context:nil];
    //设定动画持续时间
    [UIView setAnimationDuration:duration];
    //动画的内容
    CGRect rectfooter=self.footerView.frame;
//    rect.origin.y=568-20-44- keyboardHeight-44;
    rectfooter.origin.y=568- keyboardHeight-44;
    [self.footerView setFrame:rectfooter];
    
    CGRect rectlocation=self.locationView.frame;
    rectlocation.origin.y=568-keyboardHeight-44-23;
    [self.locationView setFrame:rectlocation];
    //动画结束
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    NSDictionary* userInfo = [notification userInfo];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    [self moveInputBarWithKeyboardHeight:-67.0f withDuration:animationDuration];
}

-(void)cancelButtonAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
   
}

- (void)textViewDidChange:(UITextView *)textView
{
    int en_count=0;
    for (int i=0; i<textView.text.length; i++) {
        NSRange ran={i,1};
        
        if (([textView.text substringWithRange:ran].UTF8String[0]>=0)&&
            [textView.text substringWithRange:ran].UTF8String[0]<=255) {
            en_count++;
        }
    }
    self.showRemianCount.text=[NSString stringWithFormat:@"%d",140-(textView.text.length-en_count+en_count/2)];
}
-(void)clearTextButtonAction:(id)sender
{
    self.textView.text=@"";
    self.showRemianCount.text=@"140";
}

//表情
-(void)button5Action:(id)sender
{
    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    UIView *tempview= (UIView *)[tempWindow.subviews objectAtIndex:0];

    
    if (isNotEmotion==NO) {
        isNotEmotion=YES;
        [self.button5 setImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
        [self.button5 setImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted];
        keyboardFrame=tempview.frame;
    
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.7f];
        CGRect rect=tempview.frame;
        rect.origin.y=[UIScreen mainScreen].bounds.size.height;
        [tempview setFrame:rect];
        [UIView commitAnimations];
        
        if (self.emotionScrollView==nil) {
            self.emotionScrollView=[[[EmotionScrollView alloc] initWithFrame:CGRectMake(0, 568-216-20-44, 320, tempview.bounds.size.height)] autorelease];
        }
        self.emotionScrollView.emotionDelegate=self;
        self.emotionScrollView.backgroundColor=[UIColor clearColor];
        [self.view addSubview:self.emotionScrollView];

        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.7f];
        CGRect rect1=self.footerView.frame;
        rect1.origin.y=568- self.emotionScrollView.frame.size.height-44;
        [self.footerView setFrame:rect1];
        [UIView commitAnimations];

        
        
    }
    else
    {
        isNotEmotion=NO;
        [self.button5 setImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
        [self.button5 setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateHighlighted];
        
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.7f];
        [tempview setFrame:keyboardFrame];
        [UIView commitAnimations];
        
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.7f];
        CGRect rect1=self.footerView.frame;
        rect1.origin.y=568- tempview.frame.size.height-44;
        [self.footerView setFrame:rect1];
        [UIView commitAnimations];
        
    }
}
-(void)emotionScrollView:(EmotionScrollView *)emtionScrollView WithEmotionName:(NSString *)emotionName
{
    self.textView.text=[NSString stringWithFormat:@"%@%@",self.textView.text,emotionName];
    [self textViewDidChange:self.textView];
}

//@人
-(void)button4Action:(id)sender
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.footerView removeFromSuperview];
    [self.locationView removeFromSuperview];
    
    ContactsTableViewController *contactsTableViewContrller=[[ContactsTableViewController alloc] initWithStyle:UITableViewStylePlain];
    contactsTableViewContrller.contactsDelegate=self;
    UINavigationController *navigationController=[[[UINavigationController alloc] initWithRootViewController:contactsTableViewContrller] autorelease];
    
    [self presentViewController:navigationController animated:YES completion:^{
        
    }];
    [contactsTableViewContrller release];
}
-(void)ContactsTableViewController:(ContactsTableViewController *)contacts WithFriendName:(NSString *)name
{
    self.textView.text=[NSString stringWithFormat:@"%@@%@",self.textView.text, name];
    [self textViewDidChange:self.textView];
}

@end
