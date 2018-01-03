//
//  WZXSelectClassViewController.m
//  CNT
//
//  Created by 王智鑫 on 2017/12/2.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXSelectClassViewController.h"
#import "WZXSelectClassView.h"
#import "WZXSelectTableViewCell.h"
#import "WZXSelectClassModel.h"

#define EndTime @"23:00"
#define BeginTime @"15:30"

@interface WZXSelectClassViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)WZXSelectClassView *selectClassView;
@property (nonatomic ,strong)UITableView *selectTableView;
@property (nonatomic ,strong)NSMutableArray *fitstTimeArray;
@property (nonatomic ,strong)NSMutableArray *secondTimeArray;
@property (nonatomic, strong) NSIndexPath *selectIndexPath;
@property (nonatomic, strong)NSString *dayStr;
@property (nonatomic, strong) NSString *mouthStr;
@property (nonatomic, strong) NSString *yearStr;
@end

@implementation WZXSelectClassViewController

/**输入最大时间,取最小节点 eg:12:10 = 12:00   12:45== 12:30 目的:获取有多少个30分钟*/
- (NSString *)setMaximumTimeToShowMinimumTime:(NSString *)inputTime{
    NSString *string = inputTime;
    NSArray *aArray = [string componentsSeparatedByString:@":"];
    NSString *hour = [self getTime:aArray[0] formatType:@"HH"];
    NSString *minute = [self getTime:aArray[1] formatType:@"mm"];
    
    if ([minute intValue] >= 30) {
        hour = [NSString stringWithFormat:@"%@:30",hour];
        NSLog(@"%@",hour);
    }else{
        hour = hour;
        NSLog(@"%@",hour);

    }
    return hour;
}
/**输入时间取最大时间节点9:10 == 9:30 9:40 == 10:00*/
- (NSString *)setMinimumTimeToShowMaximumTime:(NSString *)inputTime{
    NSString *string = inputTime;
    NSArray *aArray = [string componentsSeparatedByString:@":"];
    NSString *hour = [self getTime:aArray[0] formatType:@"HH"];
    NSString *minute = [self getTime:aArray[1] formatType:@"mm"];
    NSString *time;

    if ([minute intValue] >= 30) {
        hour = [NSString stringWithFormat:@"%d",[hour intValue] + 1 ];
        if ([hour isEqualToString:@"24"]) {
            hour = @"0";
        }
        time = [NSString stringWithFormat:@"%d:00",[hour intValue] ];

    }else{
        time = [NSString stringWithFormat:@"%d:30",[hour intValue]];
    }
    NSLog(@"%@",time);
    return time;
}
/**输入你的时间 --- 输入时间的格式。必须对应*/
- (NSString *)getTime:(NSString *)inputTime formatType:(NSString *)type{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:type]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:inputTime]; //------------将字符串按formatter转成nsdate
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}
/**每30或25分钟返回的时间*/
- (NSString *)returnDataWithtime:(NSString *)inputTime averageMinuetime:(NSInteger)num{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"HH:mm"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:inputTime]; //------------将字符串按formatter转成nsdate
    NSTimeInterval time = num * 60;//一年的秒数
    NSDate *lastTime = [date dateByAddingTimeInterval:time];
    NSString *dateStr = [formatter stringFromDate:lastTime];
    return  dateStr;
}
/**某时间段内返回的多个30分钟*/
- (NSInteger)getMinusTimeWithMaxTime:(NSString *)maxTime minTime:(NSString *)minTime{
    NSString *maxTimeStr = [maxTime stringByReplacingOccurrencesOfString:@":" withString:@"."];
    NSString *minTimeStr = [minTime stringByReplacingOccurrencesOfString:@":" withString:@"."];
    NSString *MinTime = [NSString stringWithFormat:@"%.2f",([maxTimeStr doubleValue]-[minTimeStr doubleValue])];
    NSArray *MinTimeArray = [MinTime componentsSeparatedByString:@"."];
    NSInteger num = [MinTimeArray[0]intValue] * 2;
    if ([MinTimeArray[1] intValue] > 0) {
        num = num + 1;
    }
    NSLog(@"%@",MinTime);
    return num;
}
- (NSMutableArray*)getListBegin:(NSString *)beginTime toEndTime:(NSString *)endTime{
    NSMutableArray *timeArray = [NSMutableArray array];
    NSInteger num = [self getMinusTimeWithMaxTime:endTime minTime:beginTime];
    NSString *time = beginTime;
    [timeArray addObject:time];
    for (int i = 0; i < num; i++) {
      NSString *newTime = [self returnDataWithtime:time averageMinuetime:30];
        time = newTime;
        [timeArray addObject:newTime];
    }
    return timeArray;
}
- (NSString *)sentChineseWithTimeShowOverseasTime:(NSString *)verseasTimeStr{
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    date = [formatter dateFromString:verseasTimeStr];
    NSString *dateStr = [formatter stringFromDate:date];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];//东八区时间
    NSString *dateStrX = [formatter stringFromDate:date];
    
    NSLog(@"国外时间 = %@   中国 = %@",dateStr, dateStrX);
    return dateStrX;
}
//非今天时间列表
- (void)getListTime{
    [_fitstTimeArray removeAllObjects];
    [_secondTimeArray removeAllObjects];
    NSMutableArray *leftArray = [self getListBegin:BeginTime toEndTime:EndTime];
    NSMutableArray *secondArr = [NSMutableArray array];
    for (int i = 0; i < leftArray.count; i++) {
        NSString *time = [self sentChineseWithTimeShowOverseasTime:leftArray[i]];
        [_fitstTimeArray addObject:time];
        
        NSString *secondTimeStr = [self returnDataWithtime:leftArray[i] averageMinuetime:25];
        [secondArr addObject:secondTimeStr];
    }
    
    for (int i = 0; i < secondArr.count; i++) {
        NSString *time = [self sentChineseWithTimeShowOverseasTime:secondArr[i]];
        [_secondTimeArray addObject:time];
    }
    [_selectTableView reloadData];
}
//今天时间列表
- (void)getListOfToDay{
    [_fitstTimeArray removeAllObjects];
    [_secondTimeArray removeAllObjects];
    //获取当前时间
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];//东八区时间
    NSString * currentMinuteTime = [formatter stringFromDate:now];
    NSString *beginTime = [self setMinimumTimeToShowMaximumTime:currentMinuteTime];
    NSMutableArray *leftArray = [self getListBegin:beginTime toEndTime:EndTime];
    NSMutableArray *secondArr = [NSMutableArray array];
    for (int i = 0; i < leftArray.count; i++) {
        NSString *time = [self sentChineseWithTimeShowOverseasTime:leftArray[i]];
        [_fitstTimeArray addObject:time];
        
        NSString *secondTimeStr = [self returnDataWithtime:leftArray[i] averageMinuetime:25];
        [secondArr addObject:secondTimeStr];
    }
    
    for (int i = 0; i < secondArr.count; i++) {
        NSString *time = [self sentChineseWithTimeShowOverseasTime:secondArr[i]];
        [_secondTimeArray addObject:time];
    }
    [_selectTableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _fitstTimeArray = [NSMutableArray array];
    _secondTimeArray = [NSMutableArray array];
    [self getListOfToDay];

    
    self.view.backgroundColor = [UIColor colorWithRed:241.0f/255.0f green:241.0f/255.0f blue:241.0f/255.0f alpha:1];
    [self.navigationController.navigationBar setBarTintColor:REDCOLOR];//修改navigationBar颜色
    //改变NavigationItem.title 颜色
    UIFont *font = [UIFont fontWithName:@"Arial-ItalicMT" size:18 * IPHONE6_WIDTH];
    NSDictionary *dic = @{NSFontAttributeName:font,
                          NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.navigationController.navigationBar.titleTextAttributes = dic;
    self.navigationItem.title = @"选课";
    self.navigationController.navigationBarHidden = NO;
#pragma mark - navigation 左侧返回键
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_jiantou_default"] style:UIBarButtonItemStylePlain target:self action:@selector(returnAction:)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
#pragma mark - 保存
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(requstWithSave)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
#pragma mark - 添加ThrratingView
    self.selectClassView = [[WZXSelectClassView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 145 * IPHONE6_HEIGHT)];
    __weak typeof(*&self) weakSelf = self;
    _selectClassView.SelectClassBlock = ^(NSString *day, NSString *mouth, NSString *year) {
        NSLog(@"%@",day);
        weakSelf.dayStr = day;
        weakSelf.mouthStr = mouth;
        weakSelf.yearStr = year;
        
        NSDate *now = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd"];
        formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];//东八区时间
        NSString * currentDay = [formatter stringFromDate:now];
        
        if ([day isEqualToString:currentDay]) {
            [weakSelf getListOfToDay];
        }else{
        [weakSelf getListTime];
        }
    };
    self.selectClassView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.selectClassView];
// tableview
    [self creatTableView];
}

#pragma mark - 创建tableView
- (void)creatTableView{
    
    self.selectTableView = [[UITableView alloc] initWithFrame:CGRectMake(30 * IPHONE6_WIDTH, 220 * IPHONE6_HEIGHT, 315 * IPHONE6_WIDTH, KHEIGHT - 220 * IPHONE6_HEIGHT) style:UITableViewStylePlain];
    self.selectTableView.delegate = self;
    self.selectTableView.dataSource = self;
    self.selectTableView.separatorStyle = UITableViewCellSeparatorStyleNone;//cell取消分割线
    [self.view addSubview:self.selectTableView];
    
#pragma mark - 注册cell
    [self.selectTableView registerClass:[WZXSelectTableViewCell class] forCellReuseIdentifier:@"selectCell"];
}


#pragma mark - 必要的方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WZXSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectCell"];
    cell.firsClockLabel.text = _fitstTimeArray[indexPath.row];
    cell.secondClockLabel.text = _secondTimeArray[indexPath.row];
    if (indexPath == _selectIndexPath) {
        cell.orderingBtn.backgroundColor = [UIColor redColor];
    } else {
        cell.orderingBtn.backgroundColor = [UIColor whiteColor];
    }
    
    cell.myBlock = ^{
        NSLog(@"%ld",indexPath.row);
        _selectIndexPath = indexPath;
        [_selectTableView reloadData];
    };


    

    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40 * IPHONE6_HEIGHT;
}
#pragma mark - 分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _fitstTimeArray.count;
}

#pragma mark - header
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.5;
}

#pragma mark - footer
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //取消点击至灰效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"yes");
}

#pragma mark - 点击保存上传用户信息
- (void)requstWithSave {
    //时间
    NSString *beginTimeStr = _fitstTimeArray[_selectIndexPath.row];
//    NSString *endTimeStr = _secondTimeArray[_selectIndexPath.row];
    //年月日
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];//东八区时间
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd"];
    NSDateFormatter *mouthFormatter = [[NSDateFormatter alloc]init];
    [mouthFormatter setDateFormat:@"MM"];
    NSDateFormatter *yearFormatter = [[NSDateFormatter alloc]init];
    [yearFormatter setDateFormat:@"yyyy"];
    NSString * currentDateStr = [dateFormatter stringFromDate:now];
    NSString *currentMouthStr = [mouthFormatter stringFromDate:now];
    NSString * currentYearStr = [yearFormatter stringFromDate:now];
    
    
    if (_dayStr.length <= 0 || [_dayStr isEqualToString:@""] || [_dayStr isEqual:[NSNull class]]) {
        //_dayStr 为空时,没有点击时,默认为今天年月日
        _dayStr = currentDateStr;
        _mouthStr = currentMouthStr;
        _yearStr = currentYearStr;
    }else{
        
    }
    
    NSLog(@"年%@ -- 月%@--- 日%@------时间%@",_yearStr,_mouthStr,_dayStr,beginTimeStr);

    NSLog(@"保存");
}
#pragma mark - 返回
- (void)returnAction:(UIButton *)returnBtn {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
