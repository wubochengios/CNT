//
//  VideoTalkManager.m
//  CNT
//
//  Created by 姚旭 on 2017/12/19.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "VideoTalkManager.h"
#import <PushKit/PushKit.h>
#import "RingCall.h"

@interface VideoTalkManager ()<PKPushRegistryDelegate>{
    
    NSString *token;
}

@property (nonatomic,strong)id<VideoCallbackDelegate>mydelegate;

@end

@implementation VideoTalkManager



static VideoTalkManager *instance = nil;

+ (VideoTalkManager *)sharedClinet {
    
    if (instance == nil) {
        
        instance = [[super allocWithZone:NULL] init];
    }
    return instance;
}

-(void)initWithSever {
    //voip delegate
    PKPushRegistry *pushRegistry = [[PKPushRegistry alloc] initWithQueue:dispatch_get_main_queue()];
    pushRegistry.delegate = self;
    pushRegistry.desiredPushTypes = [NSSet setWithObject:PKPushTypeVoIP];
    //ios10注册本地通知
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        
        [[RingCall sharedMCCall] regsionPush];
    }
    
}



- (void)setDelegate:(id<VideoCallbackDelegate>)delegate {
    
    self.mydelegate = delegate;
}


#pragma mark - <PKPushRegistryDelegate>

- (void)pushRegistry:(PKPushRegistry *)registry didUpdatePushCredentials:(PKPushCredentials *)credentials forType:(NSString *)type{
    if([credentials.token length] == 0) {
        NSLog(@"voip token NULL");
        return;
    }
    //应用启动获取token，并上传服务器
    token = [[[[credentials.token description] stringByReplacingOccurrencesOfString:@"<"withString:@""]
              stringByReplacingOccurrencesOfString:@">" withString:@""]
             stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [WSTools setInfoObject:token forKey:DeviceToken];
    
    
    
}

- (void)pushRegistry:(PKPushRegistry *)registry didReceiveIncomingPushWithPayload:(PKPushPayload *)payload forType:(NSString *)type{
    
    
    
    BOOL isCalling = false;
    switch ([UIApplication sharedApplication].applicationState) {
        case UIApplicationStateActive: {
            isCalling = false;
        }
        break;
        case UIApplicationStateInactive: {
            isCalling = false;
        }
        break;
        case UIApplicationStateBackground: {
            isCalling = true;
        }
        break;
        default:
        isCalling = true;
        break;
    }
    
    if (isCalling){
        //本地通知，实现响铃效果
        NSDictionary *dictionary = [payload.dictionaryPayload objectForKey:@"aps"];
        NSString *string = [dictionary objectForKey:@"alert"];
        [self.mydelegate onCallRing:string];
        
    }
}

@end
