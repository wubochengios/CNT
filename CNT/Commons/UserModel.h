//
//  UserModel.h
//  CNT
//
//  Created by YHY on 2017/12/4.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
//用户管理
#define AppUserModel   ([UserModel shareUserModel])


@interface UserModel : NSObject

@property (nonatomic , assign) NSInteger            age;//年龄
@property (nonatomic , copy) NSString              * currentCity;//当前城市
@property (nonatomic , copy) NSString              * email;//邮箱账号
@property (nonatomic , copy) NSString              * uid;//用户uid
@property (nonatomic , assign) NSInteger              lid;//在数据库中的id
@property (nonatomic , copy) NSString              * image;//图片地址
@property (nonatomic , copy) NSString              * mandrin;//国语
@property (nonatomic , copy) NSString              * nickname;//昵称
@property (nonatomic , copy) NSString              * refCode;//推荐码
@property (nonatomic , copy) NSString              * selfAssessment;//自评
@property (nonatomic , assign) NSInteger              sex;//1-是男  2-是女
@property (nonatomic , copy) NSString              * token;
@property (nonatomic , assign) NSInteger              type;//1-用户  2-老师
@property (nonatomic , assign) NSInteger              status;//是否完成车是课程的状态值

+ (UserModel *)shareUserModel;

/** 登陆,保存到本地 */
- (void)setUserModelBasicDataWithDict:(NSDictionary *)dict;
/** 判断是否已经登录 */
- (BOOL)isAlreadyLogined;
@end
