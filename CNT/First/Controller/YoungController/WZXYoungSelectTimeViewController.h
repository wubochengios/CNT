//
//  WZXYoungSelectTimeViewController.h
//  CNT
//
//  Created by 王智鑫 on 2017/12/6.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, selectType) {
    selectOneToOne = 1,
    selectOneToTWo = 2//从1对1精品课程进入
};

@interface WZXYoungSelectTimeViewController : UIViewController

@property (nonatomic ,assign)NSInteger courseId;    //课程Id前页面传入
@property (nonatomic, strong) NSString *teacherIdStr;//前页面传入
@property (nonatomic, strong) NSString *typeStr;//前页面传入
@property (nonatomic, assign)selectType selType;

@property (nonatomic, copy) void(^SelectTimeBlock)(NSMutableDictionary *dic);

@end
