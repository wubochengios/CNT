//
//  WZXHomeThirdCollectionViewCell.m
//  CNT
//
//  Created by 王智鑫 on 2017/11/9.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXHomeThirdCollectionViewCell.h"

@implementation WZXHomeThirdCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createSubView];
    }
    return self;
}

- (void)createSubView {
#pragma mark - 大图
    self.bigImage = [UIImage imageNamed:@"content_icon_tupian_07_pressed"];
    self.bigImageView = [[UIImageView alloc] initWithImage:self.bigImage];
    self.bigImageView.frame = CGRectMake(15, 10 * AUTO_HEIGHT, 125, 85 * AUTO_HEIGHT);
    [self addSubview:self.bigImageView];
    //题目
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(160 * AUTO_WIDTH, 12 * AUTO_HEIGHT, 125 * AUTO_WIDTH, 20 * AUTO_HEIGHT)];
    self.titleLabel.text = @"I Iove Chinese";
    self.titleLabel.font = [UIFont systemFontOfSize:14 * AUTO_HEIGHT];
    [self addSubview:self.titleLabel];
    //类别
    self.classesLabel = [[UILabel alloc] initWithFrame:CGRectMake(163 * AUTO_WIDTH, 40 * AUTO_HEIGHT, 65 * AUTO_WIDTH, 25 * AUTO_HEIGHT)];
    self.classesLabel.layer.cornerRadius = 12 * AUTO_HEIGHT;
    self.classesLabel.textAlignment = NSTextAlignmentCenter;
    self.classesLabel.clipsToBounds = YES;
    self.classesLabel.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:127.0f/255.0f blue:129.0f/255.9f alpha:1];
    self.classesLabel.text =@"幼儿园";
    self.classesLabel.font = [UIFont systemFontOfSize:17 * AUTO_HEIGHT];
    self.classesLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.classesLabel];
    //多少人学习
    self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(163 * AUTO_WIDTH, 78 * AUTO_HEIGHT, 180 * AUTO_WIDTH, 20 * AUTO_HEIGHT)];
    self.countLabel.textColor = [UIColor grayColor];
    self.countLabel.font = [UIFont systemFontOfSize:16 * AUTO_HEIGHT];
    self.countLabel.text = @"1272人正在学";
    [self addSubview:self.countLabel];
    //课时
    self.lessonHourLabel = [[UILabel alloc] initWithFrame:CGRectMake(340 * AUTO_WIDTH, 12 * AUTO_HEIGHT, 70 * AUTO_WIDTH, 20 * AUTO_HEIGHT)];
    self.lessonHourLabel.textColor = [UIColor grayColor];
    self.lessonHourLabel.text = @"120课时";
    self.lessonHourLabel.font = [UIFont systemFontOfSize:15 * AUTO_HEIGHT];
    [self addSubview:self.lessonHourLabel];
    //课时费
    self.lessonMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(350 * AUTO_WIDTH, 77 * AUTO_HEIGHT, 70 * AUTO_WIDTH, 20 * AUTO_HEIGHT)];
    self.lessonMoneyLabel.text = @"¥6000";
    self.lessonMoneyLabel.font = [UIFont systemFontOfSize:15 * AUTO_HEIGHT];
    [self addSubview:self.lessonMoneyLabel];
    
}

- (void)setMyModel:(WZXSelectSmallClassModel *)myModel{
    [self.bigImageView yy_setImageWithURL:[NSURL URLWithString:myModel.courseOutline] placeholder:[UIImage imageNamed:@"content_icon_tupian_07_pressed"]];
    
    self.titleLabel.text = myModel.courseName;
    
    self.classesLabel.text = myModel.suitObject;
    
    self.countLabel.text = [NSString stringWithFormat:@"%@人正在学",@"字段没有"];
    
    self.lessonHourLabel.text = [NSString stringWithFormat:@"%@课时",@"课时字段没有"];
    
    self.lessonMoneyLabel.text = [NSString stringWithFormat:@"¥%@",myModel.price];
}

@end
