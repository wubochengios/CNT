//
//  WZXSecondCollectionReusableView.m
//  CNT
//
//  Created by 王智鑫 on 2017/11/13.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXSecondCollectionReusableView.h"

@implementation WZXSecondCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createSubView];
    }
    return self;
}

- (void)createSubView {
    
    self.oneByOneLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 * AUTO_WIDTH, 5 * AUTO_HEIGHT, 150 * AUTO_WIDTH, 25 * AUTO_HEIGHT)];
    self.oneByOneLabel.text = @"1对1精品课程";
    self.oneByOneLabel.font = [UIFont systemFontOfSize:20 * AUTO_WIDTH];
    [self addSubview:self.oneByOneLabel];
    
    self.oneByoneLabelSecond = [[UILabel alloc] initWithFrame:CGRectMake(16 * AUTO_WIDTH, 33 * AUTO_HEIGHT, 150 * AUTO_WIDTH, 10 * AUTO_HEIGHT)];
    self.oneByoneLabelSecond.text = @"1.Excellent courses";
    self.oneByoneLabelSecond.textColor = [UIColor grayColor];
    self.oneByoneLabelSecond.font = [UIFont systemFontOfSize:11 * AUTO_WIDTH];
    [self addSubview:self.oneByoneLabelSecond];
    
    
    self.moreCourseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.moreCourseBtn setTitle:@"更多课程" forState:UIControlStateNormal];
    [self.moreCourseBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.moreCourseBtn.frame = CGRectMake(300 * AUTO_WIDTH, 10 * AUTO_HEIGHT, 80 * AUTO_WIDTH, 20 * AUTO_HEIGHT);
    self.moreCourseBtn.titleLabel.font = [UIFont systemFontOfSize:18 * AUTO_HEIGHT];
    [self addSubview:self.moreCourseBtn];
    
    self.moreEnglishLabel = [[UILabel alloc] initWithFrame:CGRectMake(345 * AUTO_WIDTH, 33 * AUTO_HEIGHT, 30 * AUTO_WIDTH, 10 * AUTO_HEIGHT)];
    self.moreEnglishLabel.text = @"More";
    self.moreEnglishLabel.font = [UIFont systemFontOfSize:11 * AUTO_WIDTH];
    self.moreEnglishLabel.textColor = [UIColor grayColor];
    [self addSubview:self.moreEnglishLabel];
    
    self.moreImage = [UIImage imageNamed:@"content_icon_jiantou_pressed"];
    self.moreImageView = [[UIImageView alloc] initWithImage:self.moreImage];
    self.moreImageView.frame = CGRectMake(383 * AUTO_WIDTH, 17 * AUTO_HEIGHT, 15 * AUTO_WIDTH, 15 * AUTO_HEIGHT);
    [self addSubview:self.moreImageView];
}




@end
