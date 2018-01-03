//
//  WZXYoungViewController.h
//  CNT
//
//  Created by 王智鑫 on 2017/12/6.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZXYoungModel.h"

@interface WZXYoungViewController : UIViewController

@property (nonatomic ,copy)NSString *type;        /** 1 - 1对1 2 - 1对多 */
@property (nonatomic, strong)NSMutableArray *myDataArray;
@property (nonatomic, assign)NSInteger cateoryID;//1003  1004
@end
