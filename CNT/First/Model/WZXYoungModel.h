//
//  WZXYoungModel.h
//  CNT
//
//  Created by 王智鑫 on 2017/12/7.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZXYoungModel : NSObject

#pragma mark - 查询类别
@property (nonatomic ,assign) NSInteger categoryId;     //类别id
@property (nonatomic ,copy) NSString *categoryName;      //类别的名字 如:少儿汉语
@property (nonatomic ,copy) NSString *presentation;      //类别的介绍

#pragma mark - 选课中心_老师列表
@property (nonatomic ,assign) NSInteger grade;     //老师评分
@property (nonatomic ,copy) NSString *image;      //老师头像地址
@property (nonatomic ,copy) NSString *realname;      //老师名字
@property (nonatomic ,copy) NSString *suitType;      //适合类型    如 “适合初级学者”
@property (nonatomic ,assign) NSInteger tId;     //老师的Id

@property (nonatomic , copy) NSString              * category_name;
@property (nonatomic , copy) NSString              * categoryImage;

@end
