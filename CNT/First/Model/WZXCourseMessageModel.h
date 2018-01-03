//
//  WZXCourseMessageModel.h
//  CNT
//
//  Created by mac on 2017/12/11.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZXCourseMessageModel : NSObject

//课程信息 model

/**课程名字*/
@property (nonatomic , copy) NSString              * courseName;
/**教学目标*/
@property (nonatomic , copy) NSString              * objective;
/**课程安排*/
@property (nonatomic , copy) NSString              * courseplan;
/**课程介绍*/
@property (nonatomic , copy) NSString              * intro;
/**适合对象*/
@property (nonatomic , copy) NSString              * suitObject;
@end
