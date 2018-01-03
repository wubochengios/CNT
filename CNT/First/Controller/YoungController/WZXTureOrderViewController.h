//
//  WZXTureOrderViewController.h
//  CNT
//
//  Created by 王智鑫 on 2017/12/12.
//  Copyright © 2017年 王智鑫. All rights reserved.
// YHY确认订单

#import <UIKit/UIKit.h>
#import "WZXSelectSmallClassModel.h"

@interface WZXTureOrderViewController : UIViewController
@property (nonatomic, strong) NSString *teacherIdStr;//前页面传入
@property (nonatomic, strong) NSString *typeStr;//前页面传入
@property (nonatomic ,assign)NSInteger courseId;    //课程Id
@property (nonatomic, strong) NSMutableDictionary *myDataDic;////前页面传入
@property (nonatomic, strong) WZXSelectSmallClassModel *presentModel;//前页面传入
@end
