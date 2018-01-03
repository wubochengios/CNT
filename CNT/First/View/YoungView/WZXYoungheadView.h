//
//  WZXYoungheadView.h
//  CNT
//
//  Created by 王智鑫 on 2017/12/6.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZXYoungModel.h"

@interface WZXYoungheadView : UIView
// 下拉按钮
@property (nonatomic ,strong)UIButton *selectbtn;
@property (nonatomic ,strong)UIImage *selectImage;
@property (nonatomic ,strong)UIImageView *selectImageView;
// 评分按钮
@property (nonatomic ,strong)UIButton *scorebtn;
@property (nonatomic ,strong)UIImage *scoreImage;
@property (nonatomic ,strong)UIImageView *scoreImageView;
// 时间按钮
@property (nonatomic ,strong)UIButton *timebtn;
@property (nonatomic ,strong)UIImage *timeImage;
@property (nonatomic ,strong)UIImageView *timeImageView;
// 价格按钮
@property (nonatomic ,strong)UIButton *pricebtn;
@property (nonatomic ,strong)UIImage *priceImage;
@property (nonatomic ,strong)UIImageView *priceImageView;
// 横线
@property (nonatomic ,strong)UIView *lightView;
// 大图片
@property (nonatomic ,strong)UIImage *bigImage;
@property (nonatomic ,strong)UIImageView *bigImageView;
// 图片下面的很多字
@property (nonatomic ,strong)UILabel *bigLabel;
// 大横条
@property (nonatomic ,strong)UIView *bigLightView;
//  model附值
@property (nonatomic ,strong)WZXYoungModel *model;
@end
