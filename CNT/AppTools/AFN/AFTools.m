//
//  AFTools.m
//  AFTools
//
//  Created by 姚旭 on 16/7/18.
//  Copyright © 2016年 YaoXu. All rights reserved.
//

#import "AFTools.h"

static NSString *signString = nil;
@implementation AFTools

+ (void)setSignString:(NSString *)signString {
    signString = signString;
}

+ (NSString *)getSignString {
    return signString;
}


#pragma mark GET请求
+ (void)getWithUrl:(NSString *)url andParameters:(NSDictionary *)parameter andSuccessBlock:(successBlock)success andFaileBlock:(faileBlock)faile {
    //yhy添加
    //添加公共参数
    parameter = [AFTools addCommonsKeyValues:parameter];
    
    //#pragma mark 将用户id与密码存储到本地中
    //    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    //    NSString *passWord = [[NSUserDefaults standardUserDefaults] objectForKey:@"passWord"];
    //    if (userId && passWord) {
    //
    //    [parameter setValue:userId forKey:@"userId"];
    //        [parameter setValue:passWord forKey:@"passWord"];
    //    }
#pragma mark 1. 创建管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
#pragma mark 2. 发送请求
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
#pragma mark 3. 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
#pragma mark 4. Https请求
    AFSecurityPolicy *securt = [AFSecurityPolicy defaultPolicy];
    securt.allowInvalidCertificates = YES;
    manager.securityPolicy =securt;
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    //yhy
    NSString *localUrl = [NSString stringWithFormat:@"%@%@",LOCALBASEURL,url];
    [manager GET:localUrl parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            if ([[responseObject objectForKey:@"code"]integerValue] == 200) {
                success([responseObject objectForKey:@"data"]);
            }
            if ([[responseObject objectForKey:@"code"]  isEqual: @(10009)] ) {
                //token过期,那我们就移除一个本地model过期的tokent对象.
                //第一种:移除,但每个VC都要单列判断,但登入后会跳转到当前页面.
                
                [WSTools removeInfoObject:TokenKey];
                //第二种:直接跳到登入,但登入后会直接跳到首页
                [CommonsClassMethod pushLoginViewController];
            }
            else {
                NSError *error = [NSError errorWithDomain:@"服务器错误" code:[[responseObject objectForKey:@"code"]integerValue] userInfo:nil];
                
                faile(error);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (faile) {
            faile(error);
        }
    }];
    
}
#pragma mark POST上传请求

+ (void)postWithUrl:(NSString *)url andParameters:(NSDictionary *)parameter andSuccessBlock:(successBlock)success andFaileBlock:(faileBlock)faile {
    //yhy添加
    //添加公共参数
    parameter = [AFTools addCommonsKeyValues:parameter];
    
    //    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:parameter];
    
    //    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    //    NSString *passWord = [[NSUserDefaults standardUserDefaults] objectForKey:@"passWord"];
    //
    //    if (userId && passWord) {
    //        [dictionary setValue:userId forKey:@"userId"];
    //        [dictionary setValue:passWord forKey:@"passWord"];
    //    }
    //
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    NSString *userCode = [defaults objectForKey:@"username"];
    //    NSTimeInterval inter = [[NSDate date] timeIntervalSince1970]*1000;
    //    NSString *interString = [NSString stringWithFormat:@"%.0f",inter];
    //    long long interLong = [interString longLongValue];
    //    if (userCode == nil) {
    //        signString = [NSString stringWithFormat:@"%@",interString].md5;
    //
    //    }else {
    //        signString = [NSString stringWithFormat:@"%@%@",interString,userCode].md5;
    //    }
    //    CGFloat version = VERSION;
    
    
    //    NSMutableDictionary *allDictionary = @{@"sign":signString,@"timestamp":@(interLong),@"v":@(version)}.mutableCopy;
    //    if (userCode == nil) {
    //        [allDictionary setValue:@"" forKey:@"username"];
    //
    //    }else {
    //        [allDictionary setValue:userCode forKey:@"username"];
    //
    //    }
    //
    //    [allDictionary addEntriesFromDictionary:parameter];
    
    
#pragma mark 1.创建管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
#pragma mark 2.发送请求
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
#pragma mark 3.设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
#pragma mark 4.https请求
    NSString *certString = [[NSBundle mainBundle] pathForResource:@"ca" ofType:@"cer"];
    NSData *cerDate = [NSData dataWithContentsOfFile:certString];
    NSSet *set = [[NSSet alloc] initWithObjects:cerDate, nil];
    
    AFSecurityPolicy *securt = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:set];
    securt.allowInvalidCertificates = YES;
    securt.validatesDomainName = NO;
    manager.securityPolicy = securt;
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    //yhy刚添加
    manager.responseSerializer = [AFJSONResponseSerializer serializer];// 请求返回的格式为json
    
    //
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    NSString *localUrl = [NSString stringWithFormat:@"%@%@",LOCALBASEURL,url];
    [manager POST:localUrl parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            if ([url isEqualToString:localUrl]) {
                [self cacheDataWithUrl:url responseObject:responseObject];
            }
            //yhy
            if ([[responseObject objectForKey:@"code"]  isEqual: @(10009)] ) {
                //token过期,那我们就移除一个本地model过期的tokent对象.
                //第一种:移除,但每个VC都要单列判断,但登入后会跳转到当前页面.
                [WSTools removeInfoObject:TokenKey];
                //第二种:直接跳到登入,但登入后会直接跳到首页
                [CommonsClassMethod pushLoginViewController];
            }
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (faile) {
            if ([url isEqualToString:localUrl]) {
                success([self getCacheDataWithUrl:url]);
            } else {
                faile(error);
            }
        }
    }];
    
}

#pragma mark 上传图片

+ (void)updateHeaderImage:(UIImage *)image andImageUrl:(NSString *)url andSuccessBlock:(successBlock)success andFaileBlock:(faileBlock)faile {
#pragma mark 将图片转化成二进制
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    
#pragma mark 获取userId
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userId = [defaults objectForKey:@"userId"];
    NSString *passWord = [defaults objectForKey:@"passWord"];
    [defaults setObject:data forKey:@"headImage"];
    [defaults synchronize];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    [manager POST:url parameters: @{@"userId":userId, @"passWord":passWord}constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"file" fileName:@"file.jpg" mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(@"success");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faile(error);
    }];
    
    
    
    
    
    
}

#pragma mark 缓存数据
+ (void)cacheDataWithUrl:(NSString *)url responseObject:(id)responseObject {
    
    NSString *path = [NSString stringWithFormat:@"%ld.plist", [url hash]];
    // 存储的沙盒路径
    NSString *path_doc = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    // 归档
    [NSKeyedArchiver archiveRootObject:responseObject toFile:[path_doc stringByAppendingPathComponent:path]];
}

#pragma mark 得到缓存的数据
+ (id)getCacheDataWithUrl:(NSString *)url {
    
    // 缓存的文件夹
    NSString *path = [NSString stringWithFormat:@"%ld.plist", [url hash]];
    NSString *path_doc = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    id result = [NSKeyedUnarchiver unarchiveObjectWithFile:[path_doc stringByAppendingPathComponent:path]];
    return result;
}

//yhy 添加
#pragma mark --- 公共参数
+ (NSMutableDictionary *)addCommonsKeyValues:(NSDictionary *)dic {
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithDictionary:dic];
    //现在用不上,以后用上了
    [dict setObject:[WSTools getAppCurrentVersion] forKey:@"app_version"];
    //    [dict setObject:@"1" forKey:@"iOS"];可在这里区分是iOS还是安卓
    
    if (AppUserModel.uid > 0) {
        [dict setObject:[NSString stringWithFormat:@"%@",AppUserModel.uid] forKey:@"uid"];//用户id
    }
    // token
    AppUserModel.token = [WSTools getInfoObject:TokenKey];
    if (AppUserModel.token.length > 0) {
        [dict setObject:AppUserModel.token forKey:@"token"];//用户token
    }
    return dict;
}

@end
