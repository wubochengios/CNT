//
//  WZXSelectTeacherViewController.h
//  CNT
//
//  Created by YHY on 2017/12/11.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZXYoungModel.h"

@interface WZXSelectTeacherViewController : UIViewController
@property (nonatomic, copy) void(^selectTeacherBlock)(WZXYoungModel *model);
@property (nonatomic, strong) NSString *typeStr;//type1 是表示课程是一对一的2是一对多的
@property (nonatomic, assign) NSInteger categoryIdInt;//类别的id

@end
