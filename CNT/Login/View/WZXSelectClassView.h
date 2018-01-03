//
//  WZXSelectClassView.h
//  CNT
//
//  Created by 王智鑫 on 2017/12/2.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZXSelectClassView : UIView

@property (nonatomic ,strong)UILabel *dateLabel;

@property (nonatomic ,strong)UIButton *dateBtn;

@property (nonatomic ,strong)UILabel *WarmTipsLabel;

@property (nonatomic ,strong)NSMutableArray *weekDayArray;

@property (nonatomic ,strong)NSArray *weektitleArray;

@property (nonatomic ,strong)NSMutableArray *btnTitleArray;

@property (nonatomic, strong) NSMutableArray *mouthArray;

@property (nonatomic, strong) NSMutableArray *yearArray;

@property (nonatomic, copy) void(^SelectClassBlock) (NSString *day,NSString *mouth,NSString *year);
@property (nonatomic, strong)UIButton *button;
@end
