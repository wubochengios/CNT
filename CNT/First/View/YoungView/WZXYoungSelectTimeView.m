//
//  WZXYoungSelectTimeView.m
//  CNT
//
//  Created by 王智鑫 on 2017/12/6.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXYoungSelectTimeView.h"

@implementation WZXYoungSelectTimeView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubView];
    }
    return self;
}
- (void)setMyDataDic:(NSMutableDictionary *)myDataDic{
    NSLog(@"%@",myDataDic);
    [self addDataView:myDataDic];

}
- (void)createSubView {
    NSLog(@"%@",_myDataDic);
#pragma mark - 第一部分图标 + label创建
    _dateImage = [UIImage imageNamed:@"con_time_icon_default"];
    _dateImageView = [[UIImageView alloc] initWithImage:_dateImage];
    _dateImageView.frame = CGRectMake(15 * IPHONE6_WIDTH, 12 * IPHONE6_HEIGHT, 18 * IPHONE6_WIDTH, 18 * IPHONE6_HEIGHT);
    [self addSubview:_dateImageView];
    
    _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(43 * IPHONE6_WIDTH, 13 * IPHONE6_HEIGHT, 60 * IPHONE6_WIDTH, 20 * IPHONE6_HEIGHT)];
    _dateLabel.text = @"选择日期";
    _dateLabel.font = [UIFont systemFontOfSize:14 * IPHONE6_WIDTH];
    [self addSubview:_dateLabel];
    
    _lightView = [[UIView alloc] initWithFrame:CGRectMake(0, 40 * IPHONE6_HEIGHT, KWIDTH, 1)];
    _lightView.backgroundColor = [UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1];
    [self addSubview:_lightView];
    
#pragma mark - 星期几 几号 button创建
    /** 根据系统星期  -  判断array **/
    NSInteger year,month,day,hour,min,sec,week;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    now=[NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
    week = [comps weekday];
    day = [comps day];
    //    NSLog(@"-----------weekday is %ld",[comps weekday]);//在这里需要注意的是：星期日是数字1，星期一时数字2，以此类推。。。
    //    NSLog(@"-----------month is %ld",[comps month]);
    //    NSLog(@"-----------day is %ld",[comps day]);
    _dayStr = [NSString stringWithFormat:@"%ld",[comps day]];
    
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
//        //实例化一个NSDateFormatter对象
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        //设定时间格式,这里可以设置成自己需要的格式
//        [dateFormatter setDateFormat:@"dd"];
//        //用[NSDate date]可以获取系统当前时间
//        NSString * currentDateStr = [dateFormatter stringFromDate:theDate];
//        [_btnTitleArray addObject:currentDateStr];
    }
    //循环创建日期label
    for (int i = 0; i < 7; i++) {
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake((40 + (20 * i) + (25 * i )) * IPHONE6_WIDTH, 54 * IPHONE6_HEIGHT, 30 * IPHONE6_WIDTH, 20 * IPHONE6_HEIGHT)];
        _dateLabel.font = [UIFont systemFontOfSize:13 * IPHONE6_HEIGHT];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.textColor = [UIColor grayColor];
        _dateLabel.text = _weektitleArray[i];
        [self addSubview:_dateLabel];
    }
    //循环创建btn
    for (int i = 0; i < 7; i++) {
       UIButton *dateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        dateBtn.frame = CGRectMake((40 + (20 * i) + (25 * i )) * IPHONE6_WIDTH, 74 * IPHONE6_HEIGHT, 30 * IPHONE6_WIDTH, 30 * IPHONE6_HEIGHT);
        [dateBtn setTitle:_btnTitleArray[i] forState:UIControlStateNormal];
        [dateBtn addTarget:self action:@selector(buttonOfAction:) forControlEvents:(UIControlEventTouchUpInside)];
        if (i == 0) {
            _dateBtn = dateBtn;
            [_dateBtn setBackgroundColor:REDCOLOR];
        }
        dateBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [dateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        dateBtn.layer.cornerRadius = 15 * IPHONE6_HEIGHT;
        dateBtn.clipsToBounds = YES;
        dateBtn.tag = i + 100;
        [self addSubview:dateBtn];
    }
#pragma mark - 粗的横线
    _secondLightView = [[UIView alloc] initWithFrame:CGRectMake(0, 114 * IPHONE6_HEIGHT, KWIDTH, 10 * IPHONE6_HEIGHT)];
    _secondLightView.backgroundColor = [UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1];
    [self addSubview:_secondLightView];
    
#pragma mark - 第二个日期图标 和label
    _secondDateImage = [UIImage imageNamed:@"con_time_icon_default"];
    _secondDateImageView = [[UIImageView alloc] initWithImage:_secondDateImage];
    _secondDateImageView.frame = CGRectMake(15 * IPHONE6_WIDTH, 134 * IPHONE6_HEIGHT, 18 * IPHONE6_WIDTH, 18 * IPHONE6_HEIGHT);
    [self addSubview:_secondDateImageView];
    
    _secondDateLable = [[UILabel alloc] initWithFrame:CGRectMake(43 * IPHONE6_WIDTH, 135 * IPHONE6_HEIGHT, 60 * IPHONE6_WIDTH, 20 * IPHONE6_HEIGHT)];
    _secondDateLable.text = @"选择日期";
    _secondDateLable.font = [UIFont systemFontOfSize:14 * IPHONE6_WIDTH];
    [self addSubview:_secondDateLable];
    
    _thirdLightView = [[UIView alloc] initWithFrame:CGRectMake(0, 165 * IPHONE6_HEIGHT, KWIDTH, 1)];
    _thirdLightView.backgroundColor = [UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1];
    [self addSubview:_thirdLightView];
    
#pragma mark - 创建 三个 小点
    _fitstDotImage = [UIImage imageNamed:@"con_round_02_default"];
    _fitstDotImageView = [[UIImageView alloc] initWithImage:_fitstDotImage];
    _fitstDotImageView.frame = CGRectMake(200 * IPHONE6_WIDTH, 145 * IPHONE6_HEIGHT, 6 * IPHONE6_WIDTH, 6 * IPHONE6_HEIGHT);
    [self addSubview:_fitstDotImageView];
    
    _fitstDotLable = [[UILabel alloc] initWithFrame:CGRectMake(207 * IPHONE6_WIDTH, 143 * IPHONE6_HEIGHT, 40 * IPHONE6_WIDTH, 10 * IPHONE6_HEIGHT)];
    _fitstDotLable.textColor = [UIColor grayColor];
    _fitstDotLable.text = @"不可选";
    _fitstDotLable.font = [UIFont systemFontOfSize:11 * IPHONE6_WIDTH];
    [self addSubview:_fitstDotLable];
    
    _secondDotImage = [UIImage imageNamed:@"con_round_02_default"];
    _secondDotImageView = [[UIImageView alloc] initWithImage:_secondDotImage];
    _secondDotImageView.frame = CGRectMake(260 * IPHONE6_WIDTH, 145 * IPHONE6_HEIGHT, 6 * IPHONE6_WIDTH, 6 * IPHONE6_HEIGHT);
    [self addSubview:_secondDotImageView];
    
    _secondDotLable = [[UILabel alloc] initWithFrame:CGRectMake(267 * IPHONE6_WIDTH, 143 * IPHONE6_HEIGHT, 40 * IPHONE6_WIDTH, 10 * IPHONE6_HEIGHT)];
    _secondDotLable.textColor = [UIColor grayColor];
    _secondDotLable.text = @"可选";
    _secondDotLable.font = [UIFont systemFontOfSize:11 * IPHONE6_WIDTH];
    [self addSubview:_secondDotLable];
    
    _thirdDotImage = [UIImage imageNamed:@"con_round_02_default"];
    _thirdDotImageView = [[UIImageView alloc] initWithImage:_secondDotImage];
    _thirdDotImageView.frame = CGRectMake(317 * IPHONE6_WIDTH, 145 * IPHONE6_HEIGHT, 6 * IPHONE6_WIDTH, 6 * IPHONE6_HEIGHT);
    [self addSubview:_thirdDotImageView];
    
    _thirdDotLable = [[UILabel alloc] initWithFrame:CGRectMake(327 * IPHONE6_WIDTH, 143 * IPHONE6_HEIGHT, 40 * IPHONE6_WIDTH, 10 * IPHONE6_HEIGHT)];
    _thirdDotLable.textColor = [UIColor grayColor];
    _thirdDotLable.text = @"午休";
    _thirdDotLable.font = [UIFont systemFontOfSize:11 * IPHONE6_WIDTH];
    [self addSubview:_thirdDotLable];
    

    
    //  预约button
    _orderingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _orderingBtn.frame = CGRectMake(53 * IPHONE6_WIDTH, 550  * IPHONE6_HEIGHT, 269 * IPHONE6_WIDTH, 40  * IPHONE6_HEIGHT);
    _orderingBtn.backgroundColor = REDCOLOR;
    [_orderingBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_orderingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _orderingBtn.layer.cornerRadius = 20 * IPHONE6_HEIGHT;
    _orderingBtn.clipsToBounds = YES;
    _orderingBtn.titleLabel.font = [UIFont systemFontOfSize:17 * IPHONE6_WIDTH];
    [self addSubview:_orderingBtn];
    [self.orderingBtn addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)addDataView:(NSMutableDictionary *)dataDic{
#pragma mark - 循环创建btn
    _timeArray = [NSMutableArray array];
//    _timeArray = [NSArray arrayWithObjects:@"06:00",@"06:30",@"07:00",@"07:30",@"08:00",@"08:30",@"09:00",@"09:30",@"10:00",@"10:30",@"11:00",@"11:30",@"12:00",@"12:30",@"13:00",@"13:30",@"14:00",@"14:30",@"15:00",@"15:30",@"16:00",@"16:30",@"17:00",@"17:30",@"18:00",@"18:30",@"19:00",@"19:30",@"20:00",@"20:30",@"21:00",@"21:30",@"22:00",@"22:30",@"23:00",@"23:30", nil];
    NSMutableArray *notApplicableTimeList = [dataDic objectForKey:@"notApplicableTimeList"];
    NSMutableArray *notArray = [NSMutableArray array];
    for (NSDictionary *dic in notApplicableTimeList) {
        WZXTimeModel *model = [[WZXTimeModel alloc]init];
        [model yy_modelSetWithJSON:dic];
        model.type = NotApplicableTimeList;
        [notArray addObject:model];
        [_timeArray addObject:model];
    }
    NSMutableArray *middayRestList = [dataDic objectForKey:@"middayRestList"];
    NSMutableArray *middayRestListArray = [NSMutableArray array];
    for (NSDictionary *dic in middayRestList) {
        WZXTimeModel *model = [[WZXTimeModel alloc]init];
        [model yy_modelSetWithJSON:dic];
        model.type = MiddayRestList;
        [middayRestListArray addObject:model];
        [_timeArray addObject:model];
    }
    NSMutableArray *usableTimeList = [dataDic objectForKey:@"usableTimeList"];
    NSMutableArray *usableTimeListArray = [NSMutableArray array];
    for (NSDictionary *dic in usableTimeList) {
        WZXTimeModel *model = [[WZXTimeModel alloc]init];
        [model yy_modelSetWithJSON:dic];
        model.type = UsableTimeList;
        [usableTimeListArray addObject:model];
        [_timeArray addObject:model];
    }
    
#pragma mark - 根据typeStr来判断，创建多少个时间button
    if ([self.typeStr isEqualToString:@"1"]) {
        for (int i = 0; i < 8; i++) {
            for (int j = 0; j < 5; j++) {
                if (i == 7 && j == 1) break;
                UIButton *timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                timeBtn.frame = CGRectMake((40 + 65 * j) * IPHONE6_WIDTH , (185 + 45 * i) * IPHONE6_HEIGHT, 35 * IPHONE6_WIDTH, 20 * IPHONE6_HEIGHT);
                //            [_timeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                timeBtn.titleLabel.font = [UIFont systemFontOfSize:11 * IPHONE6_HEIGHT];
                WZXTimeModel *model = _timeArray[i * 5 + j];
                NSString *title = model.time;
                [timeBtn setTitle:title forState:UIControlStateNormal];
                if (model.type == NotApplicableTimeList) {
                    [timeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                }else if (model.type == MiddayRestList){
                    [timeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                }
                else if (model.type == UsableTimeList){
                    [timeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                }
                [timeBtn addTarget:self action:@selector(clickTime:) forControlEvents:UIControlEventTouchUpInside];
                timeBtn.tag = i * 5 + j;
                [self addSubview:timeBtn];
            }
        }
    } else {
        for (int i = 0; i < 4; i++) {
            for (int j = 0; j < 5; j++) {
                if (i == 4 && j == 3) break;
                UIButton *timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                timeBtn.frame = CGRectMake((40 + 65 * j) * IPHONE6_WIDTH , (185 + 45 * i) * IPHONE6_HEIGHT, 35 * IPHONE6_WIDTH, 20 * IPHONE6_HEIGHT);
                //            [_timeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                timeBtn.titleLabel.font = [UIFont systemFontOfSize:11 * IPHONE6_HEIGHT];
                WZXTimeModel *model = _timeArray[i * 5 + j];
                NSString *title = model.time;
                [timeBtn setTitle:title forState:UIControlStateNormal];
                if (model.type == NotApplicableTimeList) {
                    [timeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                }else if (model.type == MiddayRestList){
                    [timeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                }
                else if (model.type == UsableTimeList){
                    [timeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                }
                [timeBtn addTarget:self action:@selector(clickTime:) forControlEvents:UIControlEventTouchUpInside];
                timeBtn.tag = i * 5 + j;
                [self addSubview:timeBtn];
                
            }
        }
    }
    
}
- (void)sureAction:(UIButton *)btu{
//    _modeuthStr = _mouthArray[0];
//    _yearStr = _yearArray[0];
//
//    if (_selectModel == nil || _dayStr == nil || _modeuthStr == nil || _yearStr == nil) {
//        
//        [MBProgressHUD showSuccess:@"请选择时间" toView:self];
//        return;
//    }else{
//    }
//    if (_timeBlock) {
//        _timeBlock(_selectModel,_yearStr,_modeuthStr,_dayStr);
//    }
    
}
#pragma mark - 日期按钮点击事件
- (void)buttonOfAction:(UIButton *)sender{
    NSInteger index = sender.tag -100;
    
    if (_dateBtn == sender) {
        
    }else{
        //本次点击的按钮设为红色
        [sender setBackgroundColor:REDCOLOR];
        //将上次点击过的按钮设为黑色
        [_dateBtn setBackgroundColor:[UIColor whiteColor]];
    }
    _dateBtn = sender;
    
    NSString *str = [sender currentTitle];
    _yearStr = _yearArray[index];
    _modeuthStr = _mouthArray [index];
    _dayStr = str;

//    if () {
//        <#statements#>
//    }
//    if(_dateBtn == sender) {
//        //上次点击过的按钮，不做处理
//    } else{
//        //本次点击的按钮设为红色
//        [sender setBackgroundColor:REDCOLOR];
//        //将上次点击过的按钮设为黑色
//        [_dateBtn setBackgroundColor:[UIColor whiteColor]];
//    }
//    _dateBtn= sender;
}

#pragma mark - 选择时间点击事件
- (void)clickTime:(UIButton *)clickBtn {
    for (WZXTimeModel *model in _timeArray) {
        NSString *titleStr = [clickBtn currentTitle];
        if ([model.time isEqualToString:titleStr]) {
            NSLog(@"%ld",model.type);
            if (model.type == NotApplicableTimeList) {
                return;
            }else if (model.type == MiddayRestList){
                return;
            }else if (model.type == UsableTimeList){
                
                _selectModel = model;
                [_timeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [clickBtn setTitleColor:REDCOLOR forState:UIControlStateNormal];
                _timeBtn = clickBtn;

                _modeuthStr = _mouthArray[0];
                _yearStr = _yearArray[0];
                
                if (_selectModel == nil || _dayStr == nil || _modeuthStr == nil || _yearStr == nil) {
                    
                    [MBProgressHUD showSuccess:@"请选择时间" toView:self];
                    return;
                }else{
                }
                if (_timeBlock) {
                    _timeBlock(_selectModel,_yearStr,_modeuthStr,_dayStr);
                }
            }
        }
    }
}




@end
