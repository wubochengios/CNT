//
//  ApiClient_AFNetworking.h
//  ShixiaobaoForiOS
//
//  Created by 吴帅 on 17/5/9.
//  Copyright © 2017年 choosefine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiClient_AFNetworking : NSObject

+ (void)afn_get:(NSString *)path host:(NSString *)host pathParams:(NSDictionary *)pathParams queryParams:(NSDictionary *)queryParams headerParams:(NSDictionary *)headerParams completionBlock:(void (^)(NSDictionary * data, NSError *error))completionBlock;

+ (void)afn_post:(NSString *)path host:(NSString *)host pathParams:(NSDictionary *)pathParams queryParams:(NSDictionary *)queryParams body:(NSDictionary *)body headerParams:(NSDictionary *)headerParams completionBlock:(void (^)(NSDictionary * data, NSError *error))completionBlock;

+ (void)afn_put:(NSString *)path host:(NSString *)host pathParams:(NSDictionary *)pathParams queryParams:(NSDictionary *)queryParams body:(NSDictionary *)body headerParams:(NSDictionary *)headerParams completionBlock:(void (^)(NSDictionary * data, NSError *error))completionBlock;

+ (void)afn_delete:(NSString *)path host:(NSString *)host pathParams:(NSDictionary *)pathParams queryParams:(NSDictionary *)queryParams headerParams:(NSDictionary *)headerParams completionBlock:(void (^)(NSDictionary * data, NSError *error))completionBlock;

@end
