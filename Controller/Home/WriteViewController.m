//
//  WriteViewController.m
//  Hello_lemongrass2.0
//
//  Created by Ibokan on 13-1-27.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "WriteViewController.h"
#import "AppDelegate.h"
//#import "DataManager.h"
@implementation WriteViewController
- (void)dealloc
{
    self.myWeibo = nil;
    self.textView = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.imageView release];
    self.numberButton = nil;
    [super dealloc];
}
- (void)viewDidLoad
{
    self.title=@"发微博";
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    UIApplication *app = [UIApplication sharedApplication];
    AppDelegate *delegate = app.delegate;
    self.myWeibo = delegate.myWeibo;
    
    //注册键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardChange:)
                                                 name:UIKeyboardDidChangeFrameNotification object:nil];
    //注册textView的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewDidChange:) name:UITextViewTextDidChangeNotification object:nil];
    //发送按钮
    UIBarButtonItem *sendButton = [[[UIBarButtonItem alloc ]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendAction:)]autorelease];
    self.navigationItem.rightBarButtonItem = sendButton;
    //输入框
    self.textView = [[[UITextView alloc]initWithFrame:CGRectMake(0, 0, 320, 460-44-44)] autorelease];
    [self.textView becomeFirstResponder];
    self.textView.font=[UIFont fontWithName:@"ArialMT" size:15];
    self.textView.contentSize = CGSizeMake(320, 460-44-44);
    self.textView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
    [self.view addSubview:self.textView];
    //计数按钮
    self.numberButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.numberButton.layer.cornerRadius=10;
    self.numberButton.frame = CGRectMake(240, self.textView.frame.size.height-30, 60, 20);
    [self.numberButton addTarget:self action:@selector(clearAction) forControlEvents:UIControlEventTouchUpInside];
    [self.numberButton setTitle:[NSString stringWithFormat:@"%d X",140-self.textView.text.length] forState:0];
    [self.view addSubview:self.numberButton];
    
    //imageView
    self.imageView = [[[UIImageView alloc]initWithFrame:CGRectMake(5, self.textView.frame.size.height-45, 40, 40)]autorelease];
    [self.view  addSubview:self.imageView];
    
    
    //工具条
    toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 460-44-300+44, 320, 44)];
    UIBarButtonItem *location = [[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"compose_locatebutton_background.png"] style:UIButtonTypeCustom target:self action:@selector(locationAction)]autorelease];

    UIBarButtonItem *camera = [[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"compose_camerabutton_background_highlighted.png"] style:UIButtonTypeCustom target:self action:@selector(cameraAction)]autorelease];
    UIBarButtonItem *topic = [[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"compose_trendbutton_background.png"] style:UIButtonTypeCustom target:self action:@selector(topicAction)]autorelease];
    UIBarButtonItem *mention = [[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigationbar_mentions.png"] style:UIButtonTypeCustom target:self action:@selector(mentionAction)]autorelease];
    UIBarButtonItem *emotion = [[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"compose_emoticonbutton_background.png"] style:UIButtonTypeCustom target:self action:@selector(emotionAction)]autorelease];
    UIBarButtonItem *keyboard = [[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"compose_keyboardbutton_background.png"] style:UIButtonTypeCustom target:self action:@selector(keyboardAction)]autorelease];
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    toolBar.items = [NSArray arrayWithObjects:location,flexible,camera,flexible,topic,flexible,mention,flexible,emotion,flexible,keyboard, nil];
    [self.view addSubview:toolBar];
    
}
-(void)sendAction:(UIBarButtonItem *)sender{
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setValue:self.textView.text forKey:@"status"];
    SinaWeiboRequest* request = [self.myWeibo requestWithURL:@"statuses/update.json" params:dic httpMethod:@"POST" delegate:nil];
    [request setResultBlock:^(SinaWeiboRequest *request,id obj){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"发送成功"
                                                     message:self.textView.text
                                                    delegate:self
                                           cancelButtonTitle:@"确定"
                                           otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }];
    [request setFailBlock:^(SinaWeiboRequest *request, id obj) {
        NSLog(@"%@",obj);
    }];
    [request connect];

}
#pragma mark-keyboard notification
-(void)keyboardChange:(NSNotification *)notification
{
    NSLog(@"%@",notification);
    NSDictionary* info = [notification userInfo];
    NSValue *beginRect = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    NSValue *endRect = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    float dy = [endRect CGRectValue].origin.y - [beginRect CGRectValue].origin.y;
   
    CGRect imageFrame = self.imageView.frame;
    imageFrame.origin.y += dy;
    self.imageView.frame = imageFrame;
    
    CGRect numberFrame = self.numberButton.frame;
    numberFrame.origin.y+=dy;
    self.numberButton.frame = numberFrame;
    
    CGRect toolFrame = toolBar.frame;
    toolFrame.origin.y += dy;
    toolBar.frame = toolFrame;

}
#pragma mark-textview delegate
-(void)textViewDidChange:(NSNotification *)aNotification
{
    NSLog(@"%s",__func__);
    [self.numberButton setTitle:[NSString stringWithFormat:@"%d X",140-self.textView.text.length] forState:0];
}

#pragma mark-button action
-(void)clearAction
{
    self.textView.text = nil;
}

-(void)locationAction
{
    
}
-(void)cameraAction
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"设置" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"手机相册",@"相机拍摄", nil];
    [alert show];
    [alert release];
}
-(void)topicAction
{
    
}
-(void)mentionAction
{
    
}
-(void)emotionAction
{
    
}
-(void)keyboardAction
{
    [self.textView endEditing:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%d",buttonIndex);
    if (buttonIndex == 1) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion:^{
            ;
        }];
        [imagePicker release];
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"%@",info);
    self.imageView.image = [info valueForKey:UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:^{
        ;
    }];
}
@end
