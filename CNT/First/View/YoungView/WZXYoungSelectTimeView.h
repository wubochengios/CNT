//
//  WZXYoungSelectTimeView.h
//  CNT
//
//  Created by 王智鑫 on 2017/12/6.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZXTimeModel.h"

@interface WZXYoungSelectTimeView : UIView
//  选择日期图标
@property (nonatomic ,strong)UIImage *dateImage;
@property (nonatomic ,strong)UIImageView *dateImageView;
//  选择日期label
@property (nonatomic ,strong)UILabel *dateLable;
//  横线
@property (nonatomic ,strong)UIView *lightView;
//  星期几label
@property (nonatomic ,strong)UILabel *dateLabel;
//  日期label
@property (nonatomic ,strong)UIButton *dateBtn;
//  星期几title数组
@property (nonatomic ,strong)NSArray *weektitleArray;
//  日期title数组
@property (nonatomic ,strong)NSMutableArray *btnTitleArray;
//  粗的横线
@property (nonatomic ,strong)UIView *secondLightView;
//  选择日期图标
@property (nonatomic ,strong)UIImage *secondDateImage;
@property (nonatomic ,strong)UIImageView *secondDateImageView;
//  选择日期label
@property (nonatomic ,strong)UILabel *secondDateLable;
//  横线
@property (nonatomic ,strong)UIView *thirdLightView;
//  三个点
@property (nonatomic ,strong)UIImage *fitstDotImage;
@property (nonatomic ,strong)UIImageView *fitstDotImageView;
@property (nonatomic ,strong)UILabel *fitstDotLable;

@property (nonatomic ,strong)UIImage *secondDotImage;
@property (nonatomic ,strong)UIImageView *secondDotImageView;
@property (nonatomic ,strong)UILabel *secondDotLable;

@property (nonatomic ,strong)UIImage *thirdDotImage;
@property (nonatomic ,strong)UIImageView *thirdDotImageView;
@property (nonatomic ,strong)UILabel *thirdDotLable;

//  time数组
@property (nonatomic ,strong)NSMutableArray *timeArray;
//  time butotn
@property (nonatomic ,strong)UIButton *timeBtn;
//  预约btn
@property (nonatomic ,strong)UIButton *orderingBtn;

@property (nonatomic, strong) NSMutableDictionary *myDataDic;

@property (nonatomic, copy) void(^timeBlock)(WZXTimeModel *model,NSString *year,NSString *mouth,NSString *day);

@property (nonatomic, strong)WZXTimeModel *selectModel;
@property (nonatomic, strong) NSMutableArray *mouthArray;

@property (nonatomic, strong) NSMutableArray *yearArray;

@property (nonatomic, strong)NSString *yearStr;
@property (nonatomic, strong)NSString *modeuthStr;
@property (nonatomic, strong)NSString *dayStr;

#pragma mark - 判断创建多少个时间的button
@property (nonatomic ,strong)NSString *typeStr;


@end
