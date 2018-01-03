//
//  WSTools.m
//  ShiXiaoBao
//
//  Created by 一一 on 16/11/14.
//  Copyright © 2016年 QuHeng. All rights reserved.
//

#import "WSTools.h"
#import <UIKit/UIKit.h>
//#import "WWY_HUDView.h"
//#import "WSAlertViewController.h"
//#import "WSProgressHUD.h"
//#import "TabBarController.h"
#define  IsEmptyStr(string) ([string isKindOfClass:[NSNull class]] || string == nil || string == NULL || [string isEqualToString:@""] || [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
#define kWeeks @[@"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六"]

@implementation WSTools

- (CGFloat)getCellHeight:(UITableViewCell *)cell
{
    
    [cell layoutIfNeeded];
    [cell setNeedsLayout];
    
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    return height + 1;
}

+ (UIViewController *)getPresentedViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    
    return topVC;
}

//#pragma 获取window上当前显示的VC
//+ (UIViewController *)getCurrentVC
//{
//    WSTools *tool = [[WSTools alloc] init];
//    return [tool getCurentVc];
//    
//}

//- (UIViewController *)getCurentVc {
//    
//    UIViewController *result = nil;
//    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
//    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
//    if (window.windowLevel != UIWindowLevelNormal)
//    {
//        NSArray *windows = [[UIApplication sharedApplication] windows];
//        for(UIWindow * tmpWin in windows)
//        {
//            if (tmpWin.windowLevel == UIWindowLevelNormal)
//            {
//                window = tmpWin;
//                break;
//            }
//        }
//    }
//    id  nextResponder = nil;
//    UIViewController *appRootVC=window.rootViewController;
//    //    如果是present上来的appRootVC.presentedViewController 不为nil
//    if (appRootVC.presentedViewController) {
//        nextResponder = appRootVC.presentedViewController;
//    } else {
//        UIView *frontView = [[window subviews] objectAtIndex:0];
//        nextResponder = [frontView nextResponder];//  这方法下面有详解
//    }
//    
//    if ([nextResponder isKindOfClass:[TabBarController class]]){
//        TabBarController * tabbar = (TabBarController *)nextResponder;
//        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
//        //        UINavigationController * nav = tabbar.selectedViewController ; 上下两种写法都行
//        result=nav.childViewControllers.lastObject;
//        
//    } else if ([nextResponder isKindOfClass:[UINavigationController class]]){
//        UIViewController * nav = (UIViewController *)nextResponder;
//        result = nav.childViewControllers.lastObject;
//    } else {
//        result = nextResponder;
//    }
//    
//    return result;
//    
//}

#pragma mark 正则校验邮箱
+ (BOOL)checkEmail:(NSString *)email {
    // ^(\\w)+(\\.\\w+)*@(\\w)+((\\.\\w{2,3}){1,3})$
    NSString *regex = @"^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [emailTest evaluateWithObject:email];
    
    /*
     NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
     NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
     return [emailTest evaluateWithObject:email];
     */
}

#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber
{
    //    电信号段:133/149/153/180/181/189/177/173
    //    联通号段:130/131/132/155/156/185/186/145/176
    //    移动号段:134/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178
    //    虚拟运营商:170/171
    
    NSString *MOBILE = @"^1(3[0-9]|4[579]|5[0-35-9]|8[0-9]|7[0-36-8])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [regextestmobile evaluateWithObject:telNumber];
}


#pragma 正则匹配用户密码6-18位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password
{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
    
}

#pragma 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName : (NSString *) userName
{
    NSString *pattern = @"^[a-zA-Z\u4E00-\u9FA5]{1,20}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:userName];
    return isMatch;
    
}


#pragma 正则匹配用户身份证号15或18位
+ (BOOL)checkUserIdCard: (NSString *) idCard
{
    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:idCard];
    return isMatch;
}

#pragma 正则匹员工号,12位的数字
+ (BOOL)checkEmployeeNumber : (NSString *) number
{
    NSString *pattern = @"^[0-9]{12}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:number];
    return isMatch;
    
}

#pragma 正则匹配URL
+ (BOOL)checkURL : (NSString *) url
{
    NSString *pattern = @"^[0-9A-Za-z]{1,50}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:url];
    return isMatch;
}

//#pragma 弹出提示框(自动消失)
//
//+ (void)showMessageInWFHudView:(NSString *)message andFinish:(void(^)(id send))block {
//    if (![message isKindOfClass:[NSString class]]) {
//        message = @"";
//    }
//    
//    if (IsEmptyStr(message)){
//        return;
//    }
//    [WSProgressHUD setProgressHUDFont:kTextFontSize(15)];
//    [WSProgressHUD showImage:nil status:message];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [WSProgressHUD dismiss];
//        if (block) {
//            block(nil);
//        }
//    });
//}

+ (NSInteger)timeStampWithTime:(NSString *)time {
    
    if (IsEmptyStr(time)) {
        return 0;
    }
    NSMutableString *timeString = time.mutableCopy;
    if (time.length < 11) {
        NSInteger yearIndex = [WSTools locationString:time character:@"年"];
        if (yearIndex != 4) {
            NSString *yearString = [time substringToIndex:yearIndex];
            if ([yearString integerValue]>=90) {
                [timeString insertString:@"19" atIndex:0];
            } else {
                [timeString insertString:@"20" atIndex:0];
            }
        }
        NSInteger monthIndex = [WSTools locationString:time character:@"月"];
        if (monthIndex == -1) {
            timeString = [NSString stringWithFormat:@"%@%@", timeString, @"01月"].mutableCopy;
        } else if (monthIndex != 2) {
            NSString *monthString = [time substringToIndex:monthIndex];
            if ([monthString integerValue]<10) {
                [timeString replaceCharactersInRange:NSMakeRange(monthIndex-1, 1) withString:[NSString stringWithFormat:@"%2ld", [monthString integerValue]]];
            }
        }
        
        NSInteger dayIndex = [WSTools locationString:time character:@"日"];
        if (dayIndex == -1) {
            timeString = [NSString stringWithFormat:@"%@%@", timeString, @"01日"].mutableCopy;
        } else if (dayIndex != 2) {
            NSString *dayString = [time substringToIndex:dayIndex];
            if ([dayString integerValue]<10) {
                [timeString replaceCharactersInRange:NSMakeRange(dayIndex-1, 1) withString:[NSString stringWithFormat:@"%2ld", [dayString integerValue]]];
            }
        }
    }
    
    return [self timeStampWithFixedTime:timeString];
}

+ (NSInteger)timeStampWithFixedTime:(NSString *)time {
    
    time = [time stringByReplacingOccurrencesOfString:@"年" withString:@"/"];
    time = [time stringByReplacingOccurrencesOfString:@"月" withString:@"/"];
    time = [time stringByReplacingOccurrencesOfString:@"日" withString:@""];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy/M/d"];
    
    NSDate* date = [formatter dateFromString:time];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]*1000];
    
    return [timeSp integerValue];
}

+ (NSInteger)timeStampWithYearMonthTime:(NSString *)time {
    
    time = [time stringByReplacingOccurrencesOfString:@"年" withString:@"/"];
    time = [time stringByReplacingOccurrencesOfString:@"月" withString:@""];
    time = [NSString stringWithFormat:@"%@/1", time];
    
    return [WSTools timeStampWithFixedTime:time];
}

+ (NSString *)timeWithTimeStamp:(NSInteger)timeStamp formet:(NSString *)formet {
    
//    if ([timeStamp ]) {
//        <#statements#>
//    }
    NSTimeInterval _interval=0;

    _interval=timeStamp/1000;

    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
    [_formatter setDateStyle:NSDateFormatterMediumStyle];
    [_formatter setTimeStyle:NSDateFormatterShortStyle];
    [_formatter setDateFormat:formet];
    NSString *dateStr=[_formatter stringFromDate:date];
    
    return [NSString stringWithFormat:@"%@", dateStr];
    
}

+ (NSString *)getWeekWithTimeStamp:(NSInteger)timeStamp {

    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:timeStamp/1000];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *weekdayComponents = [gregorian components:NSCalendarUnitWeekday fromDate:date];
    NSInteger weekday = [weekdayComponents weekday];
    
    return kWeeks[weekday-1];
}
+ (NSString *)getNowTimeOfChinese{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];//东八区时间
    
    NSString *dateStr = [formatter stringFromDate:now];
    
    NSLog(@"字符串时间 = %@", dateStr);
    return dateStr;
}
+ (NSInteger)getNowTimeStamp {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate* date = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]*1000];
    
    return [timeSp integerValue];
}

+ (NSInteger)locationString:(NSString *)string character:(NSString *)character {
    
    NSRange range;
    range = [string rangeOfString:character];
    if (range.location != NSNotFound) {
        return range.location;
    }else{
        return -1;
    }
}

+ (NSArray *)timeDiffToNowFromTimeStamp:(NSInteger)timeStamp {
    
    NSInteger nowTime = [WSTools getNowTimeStamp];
    NSArray *timeArray = [WSTools timeDiffWithStartTime:timeStamp endTime:nowTime];
    return timeArray;
}

+ (NSArray *)timeDiffWithStartTime:(NSInteger)startTime endTime:(NSInteger)endTime {
    
    startTime = [WSTools timeMSStamp:startTime];
    endTime = [WSTools timeMSStamp:endTime];
    
    NSDate* fromDate = [NSDate dateWithTimeIntervalSince1970:startTime];
    NSDate* toDate = [NSDate dateWithTimeIntervalSince1970:endTime];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSUInteger unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitDay |NSCalendarUnitMonth | NSCalendarUnitYear;
    NSCalendar* chineseClendar = [ [ NSCalendar alloc ] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *fromCps = [chineseClendar components:unitFlags fromDate:fromDate];
    NSDateComponents *toCps = [chineseClendar components:unitFlags fromDate:toDate];
    
    NSMutableArray *timeArray = [NSMutableArray array];
    
    for (NSInteger years = fromCps.year; years <= toCps.year; years++) {
        NSInteger start = 1;
        NSInteger end = 12;
        if (years == fromCps.year) {
            start = fromCps.month;
        }
        if(years == toCps.year){
            end = toCps.month;
        }
        NSMutableArray *monthArray = [NSMutableArray array];
        for (NSInteger mount = start; mount <= end; mount++) {
            [monthArray addObject:[NSString stringWithFormat:@"%02ld", mount]];
        }
        NSDictionary *timeDic = @{@"year":[NSString stringWithFormat:@"%ld", years],
                                  @"month":monthArray};
        [timeArray addObject:timeDic];
    }
    
    return timeArray;
}

+ (NSInteger)timeMSStamp:(NSInteger)timeStamp {
    
    if (timeStamp < 2000000000) {
        return timeStamp;
    } else {
        return timeStamp/1000;
    }
}

+ (NSInteger)getByteWithContent:(id)content {
    
    int strlength = 0;
    char* p = (char*)[content cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[content lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return (strlength+1)/2;
}

- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

#pragma mark 起止时间戳月份 单行
+ (NSArray *)singleTimeDiffToNowFromTimeStamp:(NSInteger)timeStamp {
    
    NSInteger nowTime = [WSTools getNowTimeStamp];
    NSArray *timeArray = [WSTools timeDiffWithStartTime:timeStamp endTime:nowTime];
    return timeArray;
}

#pragma mark 起止时间戳月份 单行
+ (NSArray *)singleTimeDiffWithStartTime:(NSInteger)startTime endTime:(NSInteger)endTime {

    startTime = [WSTools timeMSStamp:startTime];
    endTime = [WSTools timeMSStamp:endTime];
    
    NSDate* fromDate = [NSDate dateWithTimeIntervalSince1970:startTime];
    NSDate* toDate = [NSDate dateWithTimeIntervalSince1970:endTime];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSUInteger unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitDay |NSCalendarUnitMonth | NSCalendarUnitYear;
    NSCalendar* chineseClendar = [ [ NSCalendar alloc ] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *fromCps = [chineseClendar components:unitFlags fromDate:fromDate];
    NSDateComponents *toCps = [chineseClendar components:unitFlags fromDate:toDate];
    
    NSMutableArray *timeArray = [NSMutableArray array];
    
    for (NSInteger years = fromCps.year; years <= toCps.year; years++) {
        NSInteger start = 1;
        NSInteger end = 12;
        if (years == fromCps.year) {
            start = fromCps.month;
        }
        if(years == toCps.year){
            end = toCps.month;
        }
        for (NSInteger mount = start; mount <= end; mount++) {
            NSString *time = [NSString stringWithFormat:@"%02ld年%02ld月", years%100, mount];
            [timeArray addObject:time];
        }
    }
    
    return timeArray;
}

#pragma mark - 判断空值
+ (BOOL)isEmptyString:(NSString *)string{
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
#pragma mark - 打电话
+ (void)callPhone:(NSString *)callNumber{
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",callNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}

// 四舍五入计算
+ (double)moneyCalculation:(double)money baseNum:(float)baseNum {
    
    if (baseNum == 1) {
        return money;
    }
    money = money/baseNum;
    NSInteger temp = money*100/1;
    money = temp/100.f;
    return money;
}
#pragma mark - 关于"NSUserDefaults"快捷方法
/**
 保存数据 - NSUserDefaults
 注：必须NSUserDefaults 识别的类型
 */
+ (void)setInfoObject:(id)object forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setBoolObject:(BOOL)objecct forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setBool:objecct forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
/** 获取数据 - NSUserDefaults */
+ (id)getInfoObject:(NSString *)key {
    id value = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return value;
}

/** 删除数据 - NSUserDefaults */
+ (void)removeInfoObject:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
#pragma mark - APP设备信息
/** 获取当前APP版本号 */
+ (NSString *)getAppCurrentVersion {
    NSString * currentVersionString = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleShortVersionString"];
    return currentVersionString;
}
/** 获取当前设备UUID */
+ (NSString *)getUUIDString {
    NSString * uuidString = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    return uuidString;
}


@end
