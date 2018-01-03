//
//  WZXMyClassTableViewCell.h
//  CNT
//
//  Created by 王智鑫 on 2017/12/11.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZXMyClassTableViewCell : UITableViewCell
//  背景白色View
@property (nonatomic ,strong)UIView *backView;
//  左边图片
@property (nonatomic ,strong)UIImage *leftImage;
@property (nonatomic ,strong)UIImageView *leftImageView;
//  titleLabel
@property (nonatomic ,strong)UILabel *titleLabel;
//  开课时间label
@property (nonatomic ,strong)UILabel *timeLabel;
//  头像
@property (nonatomic ,strong)UIImage *headImage;
@property (nonatomic ,strong)UIImageView *headImageView;
//  老师姓名
@property (nonatomic ,strong)UILabel *teacherNameLabel;
//  lessonBtn
@property (nonatomic ,strong)UIButton *lessonButton;

@end
