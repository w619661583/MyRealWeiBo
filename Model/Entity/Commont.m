//
//  Commont.m
//  MyRealWeiBo
//
//  Created by 王芝宝 on 13-1-23.
//  Copyright (c) 2013年 王芝宝. All rights reserved.
//

#import "Commont.h"

@implementation Commont
@synthesize created_at=_created_at;
@synthesize ID=_ID;
@synthesize text=_text;
@synthesize source=_source;
@synthesize user=_user;
@synthesize mid=_mid;
@synthesize idstr=_idstr;
@synthesize status=_status;
@synthesize reply_comment=_reply_comment;
@synthesize screenName;
@synthesize screenNameHeight;
@synthesize profile_image_url;

-(void)dealloc{
    
    [super dealloc];
    [self.created_at release];
    [self.ID release];
    [self.text release];
    [self.source release];
    [self.user release];
    [self.mid release];
    [self.idstr release];
    [self.status release];
    [self.reply_comment release];
    [self.screenName release];
}
-(id)init{
    self=[super init];
    if (self) {
        
        self.accessFont = [UIFont fontWithName:@"ArialMT" size:10];
        self.screenNameFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
        self.textFont = [UIFont fontWithName:@"ArialMT" size:14];
        self.reTextFont = [UIFont fontWithName:@"ArialUnicodeMS" size:13];
        self.imgs = [[NSMutableArray alloc] init];
        self.imgs2 = [[NSMutableArray alloc] init];
        self.attString = [[NSMutableAttributedString alloc] init];
        self.attReString = [[NSMutableAttributedString alloc] init];
        self.user_arr = [[NSMutableArray alloc] init];

    }
    return self;
}
-(void)setText:(NSString *)text1
{
    _text = text1;
    
    //处理图文混排，并得到结果
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    [self creatAttributeString:_text Font:self.textFont Dic:dic];//获得dic
    
    self.textHeight = [[dic objectForKey:TEXTHEIGHT] intValue];
    [self.attString setAttributedString:[dic objectForKey:ATTSTR]];
    [self.imgs addObjectsFromArray:[dic objectForKey:IMGARR]];
    [self.user_arr addObjectsFromArray:[dic objectForKey:USERS]];
    [self.topic_arr addObjectsFromArray:[dic objectForKey:TOPICS]];
    
    [self.attString setFont:self.textFont];
}


-(void)setUser:(NSDictionary *)user1
{
    _user = user1;
    self.screenName = [_user valueForKey:@"screen_name"];
    self.screenNameHeight = 20;
    self.profile_image_url = [_user valueForKey:@"profile_image_url"];
}






-(int)getTotalHeight//计算获得cell的总高度
{
    //返回行的总高度
    int total = 0;
   
            total = self.screenNameHeight + self.textHeight + create_date_Height + offset_y*3;

           
    return total;
}

//----－------------－处理图文混排--------------------------

-(void)creatAttributeString:(NSString*)theText Font:(UIFont*)aFont Dic:(NSMutableDictionary*)theDic//处理图文混排
{
    //进行表情的html转化
    NSString *text1 = [self transformString:theText];
    
    //设置字体的html格式颜色
    //text = [NSString stringWithFormat:@"<font color='green'>%@",text];
    
    //进行html样式转化为AttributedString
    MarkupParser* p = [[MarkupParser alloc] init];
    
    NSMutableAttributedString* temp = [p attrStringFromMarkup:text1];
    //深复制，防止之前的内容变动影响后面的字符串
    
    temp = [NSMutableAttributedString attributedStringWithAttributedString:temp];
    [self.imgs addObjectsFromArray:p.images];
    
    //设置字体字号
    [temp setFont:aFont];
    //用正则表达式找出匹配的字符串
    
    NSString *string = temp.string;
    NSArray * users = [self regexUsers:string];
    NSArray * topics = [self regexTopics:string];
    
    //计算自适应高度
    OHAttributedLabel* label = [[OHAttributedLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [label setAttString:temp withImages:p.images];
    CGSize size = [label sizeThatFits:CGSizeMake(text_Width, CGFLOAT_MAX)];
    int h = size.height;
    NSNumber* height = [NSNumber numberWithInt:h];
    
    [theDic setObject:temp forKey:ATTSTR];//富文本
    [theDic setObject:p.images forKey:IMGARR];//图片
    [theDic setObject:users forKey:USERS];
    [theDic setObject:topics forKey:TOPICS];
    [theDic setObject:height forKey:TEXTHEIGHT];
}



- (NSString *)transformString:(NSString *)originalStr
{
    //正则匹配 [**] 表情
    NSString *text1 = originalStr;
    NSString *regex_emoji = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    NSArray *array_emoji = [text1 componentsMatchedByRegex:regex_emoji];
    
    //找到表情文字和face文件名之间的转化
    NSString *filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"emotionImage.plist"];
    NSDictionary *m_EmojiDic = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    
    
    //进行替换
    if ([array_emoji count])
    {
        for (NSString *str in array_emoji)
        {
            NSRange range = [text1 rangeOfString:str];
            NSString *i_transCharacter = [m_EmojiDic objectForKey:str];
            if (i_transCharacter)
            {
                //可调表情大小
                NSString *imageHtml = [NSString stringWithFormat:@"<img src='%@' width='16' height='16'>",i_transCharacter];
                text1 = [text1 stringByReplacingCharactersInRange:NSMakeRange(range.location, [str length]) withString:imageHtml];
            }
        }
    }
    
    return text1;
}

-(NSArray *)regexUsers:(NSString *)o_text
{
    //@"@[^\\.^\\,^:^;^!^\\?^\\s^#^@^。^，^：^；^！^？]+"
    //正则匹配 @人名
    NSString *text1 = o_text;
    NSString *regex_user = @"@[^\\.^\\,^:^;^!^\\?^\\s^#^@^。^，^：^；^！^？]+";
    NSArray *array_user = [text1 componentsMatchedByRegex:regex_user];
    return array_user;
}

-(NSArray *)regexTopics:(NSString *)o_text
{
    //@"#([^\#|.]+)\#"
    //正则匹配话题 ##
    NSString *text1 = o_text;
    NSString *regex_topic = @"#([^\\#|.]+)\\#";
    NSArray *array_topic = [text1 componentsMatchedByRegex:regex_topic];
    return array_topic;
    
}


//设置链接字体的颜色
-(UIColor *)colorForLink:(NSTextCheckingResult *)linkInfo underlineStyle:(int32_t *)underlineStyle
{
    return [UIColor blueColor];
}
//----------------------------------------------------------


//-----------------处理日期和来源------------------------------

-(void)setCreated_at:(NSString *)created_at1
{
    _created_at = created_at1;
    self.date = [self getTime:_created_at];
}

-(void)setSource:(NSString *)source1
{
    _source = source1;
    self.from = [self GetPartResultString:_source startString:@">" toEndString:@"<"];
}


//得到：几分钟以前   几个小时以前   几天以前
-(NSString *)getTime:(NSString *)dateString{
    NSArray *array=[dateString componentsSeparatedByString:@" "];
    //NSLog(@"array=%@",array);
    NSArray *arry1=[[array objectAtIndex:3] componentsSeparatedByString:@":"];
    NSLog(@"a==%@",arry1);
    NSDate *senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"HH:mm:ss"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    NSArray *systemTime=[locationString componentsSeparatedByString:@":"];
    NSLog(@"ttttt=%@",locationString);
    NSCalendar  * cal=[NSCalendar  currentCalendar];
    NSUInteger  unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit;
    NSDateComponents * conponent= [cal components:unitFlags fromDate:senddate];
    NSInteger day=[conponent day];
    NSString *day1=[[NSString alloc]initWithFormat:@"%2d",day];
    NSLog(@"day=%@",day1);
    if ([day1 isEqualToString:[array objectAtIndex:2]]) {
        if ([[arry1 objectAtIndex:0] isEqualToString:[systemTime objectAtIndex:0]]) {
            if ([[arry1 objectAtIndex:1] isEqualToString:[systemTime objectAtIndex:1]]) {
                if ([[arry1 objectAtIndex:2] isEqualToString:[systemTime objectAtIndex:2]]) {
                    NSLog(@"时间相同");
                    return nil;
                }else{
                    NSString *s=[self onetring:[arry1 objectAtIndex:2] twoString:[systemTime objectAtIndex:2]];
                    NSString *ns=[[NSString alloc]initWithFormat:@"%@秒以前",s];
                    return ns;
                }
            }else{
                NSString *s=[self onetring:[arry1 objectAtIndex:1] twoString:[systemTime objectAtIndex:1]];
                NSString *ns=[[NSString alloc]initWithFormat:@"%@分钟以前",s];
                return ns;
            }
        }else{
            NSString *s=[self onetring:[arry1 objectAtIndex:0] twoString:[systemTime objectAtIndex:0]];
            if (s.intValue>=1) {
                NSString *a=[arry1 objectAtIndex:0];
                NSString *b=[arry1 objectAtIndex:1];
                NSString *ns=[[NSString alloc]initWithFormat:@"今天 %@:%@",a,b];
                return ns;
                
            }
            NSString *ns=[[NSString alloc]initWithFormat:@"%@小时以前",s];
            return ns;
        }
    }else{
        NSString *s=[self onetring:[array objectAtIndex:2] twoString:day1];
        NSString *ns=[[NSString alloc]initWithFormat:@"%@天以前",s];
        return ns;
    }
}
//比较时间
-(NSString *)onetring:(NSString *)one twoString:(NSString *)two{
    int a=one.intValue;
    int b=two.intValue;
    NSString *c=[[NSString alloc]initWithFormat:@"%d",b-a ];
    return c;
}
//获取字符串中自己想要的部分
-(NSString *) GetPartResultString:(NSString *)webCodeString startString:(NSString *)startString toEndString:(NSString *)endString{
	if (![webCodeString length] || ![startString length] || ![endString length]) {
		return nil;
	}
	else {
		if (![webCodeString rangeOfString:startString].length || ![webCodeString rangeOfString:endString].length) {
			return @"";
		}
		int i;
		int j;
		NSRange range1 = [webCodeString rangeOfString:startString];
		if(range1.length>0){
			NSString *result1 = NSStringFromRange(range1);
			i = [self indexByValue:result1];
			i = i+[startString length];
		}
		NSString *str1 = [webCodeString substringFromIndex:i];
		NSRange range2 = [str1 rangeOfString:endString];
		if(range2.length>0){
			NSString *result2 = NSStringFromRange(range2);
			j = [self indexByValue:result2];
		}
		NSString *resultString = [str1 substringToIndex:j];
		return resultString;
	}
}
//排序
-(int)indexByValue:(NSString *) string{
	//使用NSMutableString类，它可以实现追加
	NSMutableString *value = [[NSMutableString alloc] initWithFormat:@""];
	NSString *colum2 = @"";
	int j = 0;
	//遍历出下标值
	for(int i=1;i<[string length];i++){
		NSString *colum1 = [string substringFromIndex:i];
		[value appendString:colum2];
		colum2 = [colum1 substringToIndex:1];
		if([colum2 isEqualToString:@","]){
			j = [value intValue];
			break;
		}
	}
	return j;
}




@end
