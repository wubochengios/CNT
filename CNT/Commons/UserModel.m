//
//  UserModel.m
//  CNT
//
//  Created by YHY on 2017/12/4.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

static UserModel *shareUserModel = nil;
+ (UserModel *)shareUserModel{
    if (!shareUserModel) {
        shareUserModel = [[UserModel alloc]init];
    }
    return shareUserModel;
}
- (void)setUserModelBasicDataWithDict:(NSDictionary *)dict {
    if (dict) {
        _age = [[dict objectForKey:@"age"] integerValue];
        _currentCity = [dict objectForKey:@"currentCity"];//当前城市
        _email = [dict objectForKey:@"email"];
        _uid = [dict objectForKey:@"uid"];
        _lid = [[dict objectForKey:@"lid"] integerValue];
        _image = [dict objectForKey:@"image"];
        _mandrin = [dict objectForKey:@"mandrin"];
        _nickname = [dict objectForKey:@"nickname"];
        _refCode = [dict objectForKey:@"refCode"];
        _selfAssessment = [dict objectForKey:@"selfAssessment"];//自评
        _sex = [[dict objectForKey:@"sex"] integerValue];////1-是男  2-是女
        _type = [[dict objectForKey:@"type"] integerValue];////1-用户  2-老师
        _status = [[dict objectForKey:@"status"]integerValue];//是否完成车是课程的状态值
        
        //这里token只有在登陆和注册的时候才有，所以需要存本地
        NSString * tokenString = [dict objectForKey:@"token"];
        if (tokenString != nil && tokenString.length > 0) {
            _token = [dict objectForKey:@"token"];
            [WSTools setInfoObject:tokenString forKey:TokenKey];
        }else{
            _token = [WSTools getInfoObject:TokenKey];

        }
        //保存用户信息到本地,下次还能用
        [WSTools setInfoObject:dict forKey:SaveUserModelKey];
        
        //登录成功发通知，刷新一些东西 -- 不知道后期能不能用到
//        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOGIN_SUCCESS object:nil];
        
    }
}




/** 判断token是否已经登录过期 */
- (BOOL)isAlreadyLogined {
    if (AppUserModel.uid > 0 && AppUserModel.token > 0) {
        return YES;
    }
        return NO;

}
@end
