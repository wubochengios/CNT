//
//  WZXSelectClassDetailViewController.h
//  CNT
//
//  Created by 王智鑫 on 2017/12/7.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZXSelectClassDetailViewController : UIViewController

@property (nonatomic ,assign)NSInteger courseId;    //课程Id
//yhy
@property (nonatomic, strong) NSString *teacherIdStr;//前页面传入
@property (nonatomic, strong) NSString *typeStr;//前页面传入
@property (nonatomic, strong) NSMutableDictionary *myDataDic;////前页面传入
@end
