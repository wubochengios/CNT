//
//  RingCall.h
//  CNT
//
//  Created by 姚旭 on 2017/12/19.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RingCall : NSObject
+ (instancetype)sharedMCCall;
- (void)regsionPush;

@end
