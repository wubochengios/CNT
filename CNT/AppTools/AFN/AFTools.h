//
//  AFTools.h
//  AFTools
//
//  Created by 姚旭 on 16/7/18.
//  Copyright © 2016年 YaoXu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFNetworking.h"

typedef void (^successBlock)(id responseObject);
typedef void (^faileBlock)(NSError *error);

/*
 请求成功Block
 responceObject 请求成功返回数据
*/
typedef void (^YXResponseSuccess)(NSURLSessionDataTask * task,id responseObject);
/*
 请求失败Block
 error 错误信息
 */
typedef void (^YXResponseFaile)(NSURLSessionDataTask * task,NSError *error);
/*
 上传或者下载进度
 progress 进度
 */
typedef void (^YXProgress)(NSProgress *progress);
@interface AFTools : NSObject



#pragma mark Get请求
+ (void)getWithUrl:(NSString *)url andParameters:(NSDictionary *)parameter andSuccessBlock:(successBlock)success andFaileBlock:(faileBlock)faile;
#pragma mark Post请求
+ (void)postWithUrl:(NSString *)url andParameters:(NSDictionary *)parameter andSuccessBlock:(successBlock)success andFaileBlock:(faileBlock)faile;
#pragma mark 上传头像图片
+ (void)updateHeaderImage:(UIImage *)image andImageUrl:(NSString *)url andSuccessBlock:(successBlock)success andFaileBlock:(faileBlock)faile;


+ (void)setSignString:(NSString *)signString;

+ (NSString *)getSignString;



@end
