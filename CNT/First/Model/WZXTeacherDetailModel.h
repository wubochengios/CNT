//
//  WZXTeacherDetailModel.h
//  CNT
//
//  Created by 王智鑫 on 2017/12/8.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZXTeacherDetailModel : NSObject

#pragma mark - 老师详情
@property (nonatomic ,assign) NSInteger grade;     //老师评分
@property (nonatomic ,copy) NSString *image;      //老师头像地址
@property (nonatomic ,copy) NSString *realname;      //老师名字
@property (nonatomic ,copy) NSString *suitType;      //适合类型    如 “适合初级学者”
@property (nonatomic ,copy) NSString *hsEstimate;      //华说对老师xxx的评价
@property (nonatomic ,copy) NSString *selfAssessment;      //自我评价
@property (nonatomic ,assign) NSInteger tId;     //老师的Id
@property (nonatomic ,copy) NSString *type;             //表示课程 一对一为:1   一对多为:2



//和首页model公用
@property (nonatomic , assign) NSInteger              birthday;
@property (nonatomic , assign) NSInteger              workStatus;
@property (nonatomic , copy) NSString              * category_name;
@property (nonatomic , assign) NSInteger              updateTime;
@property (nonatomic , copy) NSString              * major;
@property (nonatomic , assign) NSInteger              accountstatus;
@property (nonatomic , assign) NSInteger              operatorOpinion;
@property (nonatomic , assign) NSInteger              teachAge;
@property (nonatomic , copy) NSString              * token;
@property (nonatomic , copy) NSString              * categoryImage;
@property (nonatomic , copy) NSString              * tUsername;
@property (nonatomic , copy) NSString              * presentation;
@property (nonatomic , copy) NSString              * page;
@property (nonatomic , assign) NSInteger              createTime;
@property (nonatomic , copy) NSString              * tPassword;
@property (nonatomic , assign) NSInteger              userId;




@end
