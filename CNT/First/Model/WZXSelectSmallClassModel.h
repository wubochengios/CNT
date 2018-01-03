//
//  WZXSelectSmallClassModel.h
//  CNT
//
//  Created by 王智鑫 on 2017/12/9.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZXSelectSmallClassModel : NSObject

@property (nonatomic ,assign)NSInteger courseId;    //课程Id
@property (nonatomic ,copy)NSString *courseTime;         //课程的时间
@property (nonatomic ,copy)NSString *courseName;    //课程的名字
@property (nonatomic ,copy)NSString *price;  //一对多课程价钱
@property (nonatomic ,copy)NSString *price_one; //一对一的价格


//首页共用
@property (nonatomic , copy) NSString              * intro;
@property (nonatomic , copy) NSString              * courseDesc;
@property (nonatomic , assign) NSInteger              updateTime;
@property (nonatomic , copy) NSString              * courseOutline;//image
@property (nonatomic , copy) NSString              * courseplan;
@property (nonatomic , copy) NSString              * suitObject;
@property (nonatomic , copy) NSString              * objective;
@property (nonatomic , assign) NSInteger              createTime;
@property (nonatomic , assign) NSInteger              courseType;
@property (nonatomic , assign) NSInteger              cParentId;
@property (nonatomic , assign) NSInteger              categoryId;
/*
//"courseId":1222,          课程id  Integer
"cParentId":100001,       父课程id  Integer
"courseName":"少儿汉语",  课程名称  String
"courseTime":19,           课程时长  Integer
"courseType":3,
课程类型（默认为零，一对一：1，一对多：2，今日课程：3）  Integer
"categoryId":0,      对应类别id    Integer
"price":299.99,        课程价格  BigDecimal
"intro":           课程说明         String

"courseDesc":"http:dizhi.com",         课件  String
"courseOutline":"http:dizhi.com"      封面      String
 */
@end
