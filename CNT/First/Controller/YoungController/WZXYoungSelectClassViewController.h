//
//  WZXYoungSelectClassViewController.h
//  CNT
//
//  Created by 王智鑫 on 2017/12/6.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZXYoungSelectClassViewController : UIViewController

@property (nonatomic ,copy)NSString *teacherID;

@property (nonatomic ,assign)NSInteger selectUrlTag;
@property (nonatomic, strong) NSString *typeStr;//yhy
@property (nonatomic, assign) NSInteger categoryIdInt;//类别的id

@end
