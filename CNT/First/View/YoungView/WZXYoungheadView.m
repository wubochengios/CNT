//
//  WZXYoungheadView.m
//  CNT
//
//  Created by 王智鑫 on 2017/12/6.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXYoungheadView.h"

@implementation WZXYoungheadView

- (instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createHeadView];
    }
    return self;
}

- (void)createHeadView {
#pragma mark - 上面四个删选button
//    // 选类的UIbutton
//    _selectbtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _selectbtn.frame = CGRectMake(15 * IPHONE6_WIDTH, 9 * IPHONE6_HEIGHT, 65 * IPHONE6_WIDTH, 15 * IPHONE6_HEIGHT);
//    [_selectbtn setTitle:@"少儿汉语" forState:UIControlStateNormal];
//    [_selectbtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    _selectbtn.titleLabel.font = [UIFont systemFontOfSize:15 * IPHONE6_WIDTH];
//    [self addSubview:_selectbtn];
//
//    _selectImage = [UIImage imageNamed:@"shaoer_jiantou_pressed"];
//    _selectImageView = [[UIImageView alloc] initWithImage:_selectImage];
//    _selectImageView.frame = CGRectMake(90 * IPHONE6_WIDTH, 14 * IPHONE6_HEIGHT, 7 * IPHONE6_WIDTH, 7 * IPHONE6_HEIGHT);
//    [self addSubview:_selectImageView];
//
//    //评分button
//    _scorebtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _scorebtn.frame = CGRectMake(137 * IPHONE6_WIDTH, 9 * IPHONE6_HEIGHT, 35 * IPHONE6_WIDTH, 15 * IPHONE6_HEIGHT);
//    [_scorebtn setTitle:@"评分" forState:UIControlStateNormal];
//    [_scorebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    _scorebtn.titleLabel.font = [UIFont systemFontOfSize:15 * IPHONE6_WIDTH];
//    [self addSubview:_scorebtn];
//
//    _scoreImage = [UIImage imageNamed:@"pingfen_jiantou_pressed"];
//    _scoreImageView = [[UIImageView alloc] initWithImage:_scoreImage];
//    _scoreImageView.frame = CGRectMake(175 * IPHONE6_WIDTH, 9 * IPHONE6_HEIGHT, 7 * IPHONE6_WIDTH, 15 * IPHONE6_HEIGHT);
//    [self addSubview:_scoreImageView];
//
//    // 时间
//    _timebtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _timebtn.frame = CGRectMake(222 * IPHONE6_WIDTH, 9 * IPHONE6_HEIGHT, 35 * IPHONE6_WIDTH, 15 * IPHONE6_HEIGHT);
//    [_timebtn setTitle:@"时间" forState:UIControlStateNormal];
//    [_timebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    _timebtn.titleLabel.font = [UIFont systemFontOfSize:15 * IPHONE6_WIDTH];
//    [self addSubview:_timebtn];
//
//    _timeImage = [UIImage imageNamed:@"pingfen_jiantou_pressed"];
//    _timeImageView = [[UIImageView alloc] initWithImage:_timeImage];
//    _timeImageView.frame = CGRectMake(261 * IPHONE6_WIDTH, 9 * IPHONE6_HEIGHT, 7 * IPHONE6_WIDTH, 15 * IPHONE6_HEIGHT);
//    [self addSubview:_timeImageView];
//
//    // 价格
//    _pricebtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _pricebtn.frame = CGRectMake(307 * IPHONE6_WIDTH, 9 * IPHONE6_HEIGHT, 35 * IPHONE6_WIDTH, 15 * IPHONE6_HEIGHT);
//    [_pricebtn setTitle:@"价格" forState:UIControlStateNormal];
//    [_pricebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    _pricebtn.titleLabel.font = [UIFont systemFontOfSize:15 * IPHONE6_WIDTH];
//    [self addSubview:_pricebtn];
//
//    _priceImage = [UIImage imageNamed:@"pingfen_jiantou_pressed"];
//    _priceImageView = [[UIImageView alloc] initWithImage:_priceImage];
//    _priceImageView.frame = CGRectMake(346 * IPHONE6_WIDTH, 9 * IPHONE6_HEIGHT, 7 * IPHONE6_WIDTH, 15 * IPHONE6_HEIGHT);
//    [self addSubview:_priceImageView];
//
//#pragma mark - 横线
//    _lightView = [[UIView alloc] initWithFrame:CGRectMake(0, 27 * IPHONE6_HEIGHT, KWIDTH, 1)];
//    _lightView.backgroundColor = [UIColor colorWithRed:237.0f/255.0f green:237.0f/255.0f blue:237.0f/255.0f alpha:1];
//    [self addSubview:_lightView];
    
#pragma mark - 大图片
    _bigImage = [UIImage imageNamed:@"banner"];
    _bigImageView = [[UIImageView alloc] initWithImage:_bigImage];
    _bigImageView.frame = CGRectMake(0, 28 * IPHONE6_HEIGHT, KWIDTH, 95 * IPHONE6_HEIGHT);
    [self addSubview:_bigImageView];
    
#pragma mark - 大label
    _bigLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 * IPHONE6_WIDTH, 139 * IPHONE6_HEIGHT, 335 * IPHONE6_WIDTH, 70 * IPHONE6_HEIGHT)];
    _bigLabel.text = @"此课程系列适合 3 ～ 12 岁或者同等水平儿童。英语说结合大量的教学实践，理论研究、线上测试和师生调研，激发学生兴趣，满足了实际交际运用的需求。";
    _bigLabel.textColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1];
    _bigLabel.numberOfLines = 0;
    _bigLabel.font = [UIFont systemFontOfSize:12 * IPHONE6_WIDTH];
    [self addSubview:_bigLabel];
    
#pragma mark - 大横条
    _bigLightView = [[UIView alloc] initWithFrame:CGRectMake(0, 225 * IPHONE6_HEIGHT, KWIDTH, 10 * IPHONE6_HEIGHT)];
    _bigLightView.backgroundColor = [UIColor colorWithRed:241.0f/255.0f green:241.0f/255.0f blue:241.0f/255.0f alpha:1];
    [self addSubview:_bigLightView];
        
}

- (void)setModel:(WZXYoungModel *)model {
    
    self.bigLabel.text = model.presentation;
    
    
}



@end
