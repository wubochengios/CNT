//
//  WZXTheratingView.m
//  CNT
//
//  Created by 王智鑫 on 2017/12/1.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXTheratingView.h"

@implementation WZXTheratingView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createSubView];
    }
    return self;
}

- (void)createSubView {
    //大图片
    self.bigImage = [UIImage imageNamed:@"img_02"];
    self.bigImageView = [[UIImageView alloc] initWithImage:_bigImage];
    self.bigImageView.frame = CGRectMake(0, 0, self.frame.size.width, 250 * IPHONE6_HEIGHT);
    [self addSubview:self.bigImageView];
    //第一个label
    self.firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(60 * IPHONE6_WIDTH, 270 * IPHONE6_HEIGHT, 179 *IPHONE6_WIDTH, 20 * IPHONE6_HEIGHT)];
    self.firstLabel.font = [UIFont systemFontOfSize:16 * IPHONE6_WIDTH];
    self.firstLabel.text = @"汉语水平外教1对1测试课";
    [self addSubview:self.firstLabel];
    //第二个label
    self.secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(58.5 * IPHONE6_WIDTH, 290 * IPHONE6_HEIGHT, 185 * IPHONE6_WIDTH, 10 * IPHONE6_HEIGHT)];
    self.secondLabel.font = [UIFont systemFontOfSize:8 * IPHONE6_WIDTH];
    self.secondLabel.text = @"chinese level foreign teachers 1 to 1 text class";
    [self addSubview:self.secondLabel];
    //第三个label
    self.thirdLabel = [[UILabel alloc] initWithFrame:CGRectMake(80 * IPHONE6_WIDTH, 320 * IPHONE6_HEIGHT, 145 * IPHONE6_WIDTH, 15 * IPHONE6_HEIGHT)];
    self.thirdLabel.font = [UIFont systemFontOfSize:12 * IPHONE6_WIDTH];
    self.thirdLabel.textColor = [UIColor colorWithRed:251.0f/255.0f green:171.0f/255.0f blue:74.0f/255.0f alpha:1];
    self.thirdLabel.textAlignment = NSTextAlignmentCenter;
    self.thirdLabel.text = @"获得专业水平评估报告";
    [self addSubview:self.thirdLabel];
    //第四个lebel
    self.forthLabel = [[UILabel alloc] initWithFrame:CGRectMake(65 * IPHONE6_WIDTH, 335 * IPHONE6_HEIGHT, 175 * IPHONE6_WIDTH, 10 * IPHONE6_HEIGHT)];
    self.forthLabel.textAlignment = NSTextAlignmentCenter;
    self.forthLabel.font = [UIFont systemFontOfSize:8 * IPHONE6_WIDTH];
    self.forthLabel.text = @"obtain professional level evaluation report";
    [self addSubview:self.forthLabel];
    //免费体验的btn
    self.experienceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.experienceBtn.frame = CGRectMake(25 * IPHONE6_WIDTH, 360 * IPHONE6_HEIGHT, 249 * IPHONE6_WIDTH, 55 * IPHONE6_HEIGHT);
    self.experienceBtn.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:91.0f/255.0f blue:95.0f/255.0f alpha:1];
    [self.experienceBtn setTitle:@"免费体验" forState:UIControlStateNormal];
    self.experienceBtn.layer.cornerRadius = 10 * IPHONE6_WIDTH;
    self.experienceBtn.clipsToBounds = YES;
    [self addSubview:self.experienceBtn];
    //第五个label
    self.fifthLabel = [[UILabel alloc] initWithFrame:CGRectMake(99 * IPHONE6_WIDTH, 430 * IPHONE6_HEIGHT, 101 * IPHONE6_WIDTH, 10 * IPHONE6_HEIGHT)];
    self.fifthLabel.textColor = [UIColor colorWithRed:199.0f/255.0f green:199.0f/255.0f blue:199.0f/255.0f alpha:1];
    self.fifthLabel.textAlignment = NSTextAlignmentCenter;
    self.fifthLabel.font = [UIFont systemFontOfSize:10 * IPHONE6_WIDTH];
    self.fifthLabel.text = @"12746838人已测评";
    [self addSubview:self.fifthLabel];
}










@end
