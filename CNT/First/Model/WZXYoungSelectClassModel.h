//
//  WZXYoungSelectClassModel.h
//  CNT
//
//  Created by 王智鑫 on 2017/12/8.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZXYoungSelectClassModel : NSObject

@property (nonatomic ,assign)NSInteger courseId;    //课程Id

@property (nonatomic ,copy)NSString *intro;         //课程的介绍

@property (nonatomic ,copy)NSString *courseName;    //课程的名字

@property (nonatomic, assign) NSInteger categoryId; //类别Id

@end
