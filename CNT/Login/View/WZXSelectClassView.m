//
//  WZXSelectClassView.m
//  CNT
//
//  Created by 王智鑫 on 2017/12/2.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXSelectClassView.h"

@implementation WZXSelectClassView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createSubView];
    }
    return self;
}

- (void)createSubView {
    /** 根据系统星期  -  判断array **/
    NSDate *now = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];//东八区时间
    
    NSString *dateStr = [formatter stringFromDate:now];
    
    NSLog(@"字符串时间 = %@", dateStr);
    
    
    
    
    NSInteger year,month,day,hour,min,sec,week;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
   // now=[NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
    week = [comps weekday];
    day = [comps day];
    //    NSLog(@"-----------weekday is %ld",[comps weekday]);//在这里需要注意的是：星期日是数字1，星期一时数字2，以此类推。。。
    //    NSLog(@"-----------month is %ld",[comps month]);
    //    NSLog(@"-----------day is %ld",[comps day]);
    //    NSLog(@"-----------weekdayOrdinal is %ld",[comps weekdayOrdinal]);
    
    if (week == 1) {
        _weektitleArray = [NSArray arrayWithObjects:@"今天",@"一",@"二",@"三",@"四",@"五",@"六", nil];
    }else if (week == 2) {
        _weektitleArray = [NSArray arrayWithObjects:@"今天",@"二",@"三",@"四",@"五",@"六",@"日", nil];
    }else if (week == 3) {
        _weektitleArray = [NSArray arrayWithObjects:@"今天",@"三",@"四",@"五",@"六",@"日",@"一", nil];
    }else if (week == 4) {
        _weektitleArray = [NSArray arrayWithObjects:@"今天",@"四",@"五",@"六",@"日",@"一",@"二", nil];
    }else if (week == 5) {
        _weektitleArray = [NSArray arrayWithObjects:@"今天",@"五",@"六",@"日",@"一",@"二",@"三", nil];
    }else if (week == 6) {
        _weektitleArray = [NSArray arrayWithObjects:@"今天",@"六",@"日",@"一",@"二",@"三",@"四", nil];
    }else if (week == 7) {
        _weektitleArray = [NSArray arrayWithObjects:@"今天",@"日",@"一",@"二",@"三",@"四",@"五", nil];
    }
    
/** 根据系统日期  -  获取7天的日期 **/
    
    _btnTitleArray = [[NSMutableArray alloc] init];
    _mouthArray = [NSMutableArray array];
    _yearArray = [NSMutableArray array];
    for (int i = 0; i < 7; i++) {
    
        NSInteger dis = i; //前后的天数
        
        NSDate*nowDate = [NSDate date];
        NSDate* theDate;
        
        if(dis!=0)
        {
            NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
            
            theDate = [nowDate initWithTimeIntervalSinceNow: +oneDay*dis ];
        }
        else
        {
            theDate = nowDate;
        }
        //实例化一个NSDateFormatter对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter setDateFormat:@"dd"];
        NSDateFormatter *mouthFormatter = [[NSDateFormatter alloc]init];
        [mouthFormatter setDateFormat:@"MM"];
        NSDateFormatter *yearFormatter = [[NSDateFormatter alloc]init];
        [yearFormatter setDateFormat:@"yyyy"];
        //用[NSDate date]可以获取系统当前时间
        NSString * currentDateStr = [dateFormatter stringFromDate:theDate];
        NSString *currentMouthStr = [mouthFormatter stringFromDate:theDate];
        NSString * currentYearStr = [yearFormatter stringFromDate:theDate];
        [_btnTitleArray addObject:currentDateStr];
        [_mouthArray addObject:currentMouthStr];
        [_yearArray addObject:currentYearStr];
//        NSLog(@"%@",_btnTitleArray);
    
    }
    
    //循环创建日期label
    for (int i = 0; i < 7; i++) {
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake((25 + (25 * i) + (25 * i )) * IPHONE6_WIDTH, 20 * IPHONE6_HEIGHT, 30 * IPHONE6_WIDTH, 20 * IPHONE6_HEIGHT)];
        _dateLabel.font = [UIFont systemFontOfSize:13 * IPHONE6_HEIGHT];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.textColor = [UIColor grayColor];
        _dateLabel.text = _weektitleArray[i];
        [self addSubview:_dateLabel];
    }
    //循环创建btn
    for (int i = 0; i < 7; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((25 + (25 * i) + (25 * i )) * IPHONE6_WIDTH, 60 * IPHONE6_HEIGHT, 30 * IPHONE6_WIDTH, 30 * IPHONE6_HEIGHT);
        [btn setTitle:_btnTitleArray[i] forState:UIControlStateNormal];
        if (i == 0) {
            _dateBtn = btn;
            [btn setBackgroundColor:REDCOLOR];
        }
        [btn addTarget:self action:@selector(buttonOfAction:) forControlEvents:(UIControlEventTouchUpInside)];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        //_dateBtn.backgroundColor = REDCOLOR;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 15 * IPHONE6_HEIGHT;
        btn.clipsToBounds = YES;
        btn.tag = i + 100;
        [self addSubview:btn];
    }
    
    //创建说明label
    _WarmTipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 125, 350, 10)];
    _WarmTipsLabel.textColor = [UIColor grayColor];
    _WarmTipsLabel.text = @"*  测试课的上课时长为25分钟，请提前安排好您的时间";
    NSMutableAttributedString *textStr = [[NSMutableAttributedString alloc]initWithString:_WarmTipsLabel.text];
    [textStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[[textStr string]rangeOfString:@"* "]];
    _WarmTipsLabel.attributedText = textStr;
    _WarmTipsLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_WarmTipsLabel];
}

#pragma mark - 日期按钮点击事件
- (void)buttonOfAction:(UIButton *)sender{
    NSInteger index = sender.tag -100;
    
    if(_dateBtn == sender) {
        //上次点击过的按钮，不做处理
    } else{
        //本次点击的按钮设为红色
        [sender setBackgroundColor:REDCOLOR];
        //将上次点击过的按钮设为黑色
        [_dateBtn setBackgroundColor:[UIColor whiteColor]];
    }
    _dateBtn= sender;
    
    NSString *str = [sender currentTitle];
    if (_SelectClassBlock) {
        _SelectClassBlock(str,_mouthArray[index],_yearArray[index]);
    }
}




@end
