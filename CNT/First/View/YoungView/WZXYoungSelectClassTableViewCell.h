//
//  WZXYoungSelectClassTableViewCell.h
//  CNT
//
//  Created by 王智鑫 on 2017/12/6.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZXYoungSelectClassModel.h"

@interface WZXYoungSelectClassTableViewCell : UITableViewCell
//  大 View
@property (nonatomic ,strong)UIView *bigView;
//  大标题
@property (nonatomic ,strong)UILabel *titlelabel;
//  内容
@property (nonatomic ,strong)UILabel *contentLabel;
//  横线
@property (nonatomic ,strong)UIView *lightView;
//  麦克风图片
@property (nonatomic ,strong)UIImage *micImage;
@property (nonatomic ,strong)UIImageView *micImageView;
//  价格
@property (nonatomic ,strong)UILabel *priceLabel;
//  model
@property (nonatomic ,strong)WZXYoungSelectClassModel *model;


@end
