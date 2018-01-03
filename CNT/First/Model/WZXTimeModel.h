//
//  WZXTimeModel.h
//  CNT
//
//  Created by mac on 2017/12/9.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TimeStyle) {
    NotApplicableTimeList              = 0,
    MiddayRestList           = 1,
    UsableTimeList             =2,
};
@interface WZXTimeModel : NSObject
@property (nonatomic, copy) NSString *time;
@property (nonatomic, assign) NSInteger cid;
@property (nonatomic, assign) TimeStyle type;
@end
