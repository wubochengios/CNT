//
//  WSTools.h
//  ShiXiaoBao
//
//  Created by 一一 on 16/11/14.
//  Copyright © 2016年 QuHeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WSTools : NSObject
// 正则校验邮箱
+ (BOOL)checkEmail:(NSString *)email;
// 获取当前Window上显示的VC
+ (UIViewController *)getCurrentVC;
// 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber;
// 正则匹配用户密码6-18位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password;
// 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName : (NSString *) userName;
// 正则匹配用户身份证号
+ (BOOL)checkUserIdCard: (NSString *) idCard;
// 正则匹配URL
+ (BOOL)checkURL : (NSString *) url;
// 时间->时间戳(yyyy年MM月dd日 或 yy年M月d日)
+ (NSInteger)timeStampWithTime:(NSString *)time;
// 时间->时间戳(yyyy年/MM/dd)
+ (NSInteger)timeStampWithFixedTime:(NSString *)time;
// 时间戳->时间
+ (NSString *)timeWithTimeStamp:(NSInteger)timeStamp formet:(NSString *)formet;
// 当前时间的时间戳
+ (NSInteger)getNowTimeStamp;
//yhy 获取当前中国时间
+ (NSString *)getNowTimeOfChinese;
// 获取星期
+ (NSString *)getWeekWithTimeStamp:(NSInteger)timeStam;
// 固定时间戳 到 当前时间月份 单行
+ (NSArray *)singleTimeDiffToNowFromTimeStamp:(NSInteger)timeStamp;
// 起止时间戳月份 单行
+ (NSArray *)singleTimeDiffWithStartTime:(NSInteger)startTime endTime:(NSInteger)endTime;
// 固定时间戳 到 当前时间月份 2行
+ (NSArray *)timeDiffToNowFromTimeStamp:(NSInteger)timeStamp;
// 起止时间戳月份 2行
+ (NSArray *)timeDiffWithStartTime:(NSInteger)startTime endTime:(NSInteger)endTime;
//字符在字符串中的位置
+ (NSInteger)locationString:(NSString *)string character:(NSString *)character;
// 显示hud
+ (void)showMessageInWFHudView:(NSString *)message andFinish:(void(^)(id send))block;
// 判断字符串为空
+ (BOOL)isEmptyString:(NSString *)string;
//打电话
+ (void)callPhone:(NSString *)callNumber;
//获取内容字节
+ (NSInteger)getByteWithContent:(NSString *)content;
// 获取当前ViewController
- (UIViewController *)getCurrentVC;
//获取present出来的viewcontroller
+ (UIViewController *)getPresentedViewController;

+ (NSInteger)timeStampWithYearMonthTime:(NSString *)time;

+ (double)moneyCalculation:(double)money baseNum:(float)baseNum;
//yhy 添加
#pragma mark - 关于"NSUserDefaults"快捷方法
/**
 保存数据 - NSUserDefaults
 注：必须NSUserDefaults 识别的类型
 */
+ (void)setInfoObject:(id)object forKey:(NSString *)key;

/** 获取数据 - NSUserDefaults */
+ (id)getInfoObject:(NSString *)key;

/** 删除数据 - NSUserDefaults */
+ (void)removeInfoObject:(NSString *)key;

//存储Bool类型的值
+ (void)setBoolObject:(BOOL)objecct forKey:(NSString *)key;


#pragma mark - APP设备信息
/** 获取当前APP版本号 */
+ (NSString *)getAppCurrentVersion;

/** 获取当前设备UUID */
+ (NSString *)getUUIDString;

@end
