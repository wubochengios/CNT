//
//  ApiClient_AFNetworking.m
//  ShixiaobaoForiOS
//
//  Created by 吴帅 on 17/5/9.
//  Copyright © 2017年 choosefine. All rights reserved.
//

#import "ApiClient_AFNetworking.h"

#define CLOUDAPI_HTTP @"http://"

@implementation ApiClient_AFNetworking

#pragma mark get
+ (void)afn_get:(NSString *)path host:(NSString *)host pathParams:(NSDictionary *)pathParams queryParams:(NSDictionary *)queryParams headerParams:(NSDictionary *)headerParams completionBlock:(void (^)(NSDictionary * data, NSError *error))completionBlock {

    headerParams = [NSMutableDictionary dictionaryWithDictionary:headerParams];
    host = [ApiClient_AFNetworking realHostWithHost:host];
    NSString *realPath = [NSString stringWithFormat:@"%@%@%@", CLOUDAPI_HTTP, host, path];
    if (queryParams) {
        NSString *queryPath = [ApiClient_AFNetworking splitJointPathWithQueryParams:queryParams];
        realPath = [NSString stringWithFormat:@"%@?%@", realPath, queryPath];
    }
    
    AFHTTPSessionManager *manager = [ApiClient_AFNetworking managerWithBaseURL:nil sessionConfiguration:YES];
    [ApiClient_AFNetworking setHeaderWithManager:manager headers:headerParams];
    
    [manager GET:realPath parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionBlock(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionBlock(nil, error);
    }];
}

#pragma mark post
+ (void)afn_post:(NSString *)path host:(NSString *)host pathParams:(NSDictionary *)pathParams queryParams:(NSDictionary *)queryParams body:(NSDictionary *)body headerParams:(NSDictionary *)headerParams completionBlock:(void (^)(NSDictionary * data, NSError *error))completionBlock {

    host = [ApiClient_AFNetworking realHostWithHost:host];
    NSString *queryPath = [ApiClient_AFNetworking splitJointPathWithQueryParams:queryParams];
    NSString *realPath = [NSString stringWithFormat:@"%@%@%@?%@", CLOUDAPI_HTTP, host, path, queryPath];
    
    AFHTTPSessionManager *manager = [ApiClient_AFNetworking managerWithBaseURL:nil sessionConfiguration:YES];
    [ApiClient_AFNetworking setHeaderWithManager:manager headers:headerParams];
    
    [manager POST:realPath parameters:body progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionBlock(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionBlock(nil, error);
    }];
}

#pragma mark put
+ (void)afn_put:(NSString *)path host:(NSString *)host pathParams:(NSDictionary *)pathParams queryParams:(NSDictionary *)queryParams body:(NSDictionary *)body headerParams:(NSDictionary *)headerParams completionBlock:(void (^)(NSDictionary * data, NSError *error))completionBlock {

    host = [ApiClient_AFNetworking realHostWithHost:host];
    NSString *queryPath = [ApiClient_AFNetworking splitJointPathWithQueryParams:queryParams];
    NSString *realPath = [NSString stringWithFormat:@"%@%@%@?%@", CLOUDAPI_HTTP, host, path, queryPath];
    
    AFHTTPSessionManager *manager = [ApiClient_AFNetworking managerWithBaseURL:nil sessionConfiguration:YES];
    [ApiClient_AFNetworking setHeaderWithManager:manager headers:headerParams];
    
    [manager PUT:realPath parameters:body success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionBlock(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionBlock(nil, error);
    }];
}

#pragma mark delete
+ (void)afn_delete:(NSString *)path host:(NSString *)host pathParams:(NSDictionary *)pathParams queryParams:(NSDictionary *)queryParams headerParams:(NSDictionary *)headerParams completionBlock:(void (^)(NSDictionary * data, NSError *error))completionBlock {

    host = [ApiClient_AFNetworking realHostWithHost:host];
    NSString *queryPath = [ApiClient_AFNetworking splitJointPathWithQueryParams:queryParams];
    NSString *realPath = [NSString stringWithFormat:@"%@%@%@?%@", CLOUDAPI_HTTP, host, path, queryPath];
    
    AFHTTPSessionManager *manager = [ApiClient_AFNetworking managerWithBaseURL:nil sessionConfiguration:YES];
    [ApiClient_AFNetworking setHeaderWithManager:manager headers:headerParams];
    
    [manager DELETE:realPath parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionBlock(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionBlock(nil, error);
    }];
}

#pragma mark -

+ (AFHTTPSessionManager *)managerWithBaseURL:(NSString *)baseURL sessionConfiguration:(BOOL)isconfiguration {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager =nil;
    
    NSURL *url = [NSURL URLWithString:baseURL];
    manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url sessionConfiguration:configuration];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    return manager;
}

// 设置请求头
+ (void)setHeaderWithManager:(AFHTTPSessionManager *)manager headers:(NSDictionary *)headers {

    headers = [ApiClient_AFNetworking configHeaderWithHeaders:headers];

    for (NSString *key in [headers allKeys]) {
        NSString *value = headers[key];
//        if (!IsEmptyStr(key) && !IsEmptyStr(value)) {
            [manager.requestSerializer setValue:value forHTTPHeaderField:key];
//        }
    }
}

// 拼接path
+ (NSString *)splitJointPathWithQueryParams:(NSDictionary *)queryParams {
    
    NSString *realPath = @"";
    for (NSString *key in [queryParams allKeys]) {
        NSString *value = queryParams[key];
        NSString *query = [NSString stringWithFormat:@"%@=%@", key, value];
        if ([key isEqualToString:[[queryParams allKeys] firstObject]]) {
            realPath = [NSString stringWithFormat:@"%@?%@", realPath, query];
        } else {
            realPath = [NSString stringWithFormat:@"%@&%@", realPath, query];
        }
    }
    
    return realPath;
}

+ (NSString *)realHostWithHost:(NSString *)host {

    return HOST;
}

+ (NSDictionary *)configHeaderWithHeaders:(NSDictionary *)headerParams {

    NSMutableDictionary *headers = [NSMutableDictionary dictionaryWithDictionary:headerParams];
    return headers;
}

@end
