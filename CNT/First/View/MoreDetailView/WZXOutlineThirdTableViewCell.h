//
//  WZXOutlineThirdTableViewCell.h
//  CNT
//
//  Created by 王智鑫 on 2017/12/10.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZXSelectSmallClassModel.h"
@interface WZXOutlineThirdTableViewCell : UITableViewCell
//  课程类别
@property (nonatomic ,strong) UILabel *classLabel;
//  点击的图片
@property (nonatomic ,strong) UIImage *clickImage;
//  点击的图片
@property (nonatomic ,strong) UIImageView *clickImageView;

@property (nonatomic ,strong)WZXSelectSmallClassModel *myModel;

- (void)setSelectChangeColor:(BOOL)select;
@end
