//
//  WZXVideoCallView.m
//  CNT
//
//  Created by 王智鑫 on 2017/12/23.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXVideoCallView.h"

@implementation WZXVideoCallView

- (instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubView];
    }
    return self;
}

- (void)createSubView {
    /*
     创建背景
     */
    self.bigImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _bigImageView.image = [UIImage imageNamed:@"back"];
    _bigImageView.contentMode = UIViewContentModeScaleAspectFill;
    //[bgImgView setImageToBlur: [UIImage imageNamed:@"huoying.jpg"] blurRadius: completionBlock:nil];
    _bigImageView.userInteractionEnabled = YES;
    [self addSubview:_bigImageView];
    /*
     毛玻璃的样式(枚举)
     UIBlurEffectStyleExtraLight,
     UIBlurEffectStyleLight,
     UIBlurEffectStyleDark
     */
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.alpha = 0.93;
    effectView.frame = CGRectMake(0, 0, _bigImageView.frame.size.width, _bigImageView.frame.size.height);
    [_bigImageView addSubview:effectView];
    
#pragma mark - 头像
    self.headImage = [UIImage imageNamed:@"back"];
    self.headImageView = [[UIImageView alloc] initWithImage:self.headImage];
    self.headImageView.frame = CGRectMake(133 * IPHONE6_WIDTH, 63 * IPHONE6_HEIGHT, 110 * IPHONE6_WIDTH, 110 * IPHONE6_HEIGHT);
    self.headImageView.clipsToBounds = YES;
    self.headImageView.layer.cornerRadius = 60 * AUTO_WIDTH;
    [self addSubview:self.headImageView];
#pragma mark - 名字
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(133 * IPHONE6_WIDTH, 188 * IPHONE6_HEIGHT, 110 * IPHONE6_WIDTH, 35 * IPHONE6_HEIGHT)];
    self.nameLabel.font = [UIFont systemFontOfSize:18 * IPHONE6_WIDTH];
    self.nameLabel.text = @"XXX同学";
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.textColor = [UIColor whiteColor];
    [self addSubview:_nameLabel];
#pragma mark - 描述
    self.describeLabel = [[UILabel alloc] initWithFrame:CGRectMake(123 * IPHONE6_WIDTH, 218 * IPHONE6_HEIGHT, 130 * IPHONE6_WIDTH, 35 * IPHONE6_HEIGHT)];
    self.describeLabel.font = [UIFont systemFontOfSize:14 * IPHONE6_WIDTH];
    self.describeLabel.text = @"邀请您进行视频聊天...";
    self.describeLabel.textAlignment = NSTextAlignmentCenter;
    self.describeLabel.textColor = [UIColor whiteColor];
    [self addSubview:_describeLabel];
#pragma mark - endbutton
    self.endButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.endButton setImage:[UIImage imageNamed:@"con_icon_hangup_default"] forState:UIControlStateNormal];
    self.endButton.frame = CGRectMake(41 * IPHONE6_WIDTH, 535 * IPHONE6_HEIGHT, 70 * IPHONE6_WIDTH, 70 * IPHONE6_HEIGHT);
    self.endButton.layer.cornerRadius = 35 * IPHONE6_WIDTH;
    self.endButton.clipsToBounds = YES;
    [self addSubview:self.endButton];
#pragma mark - endLabel
    self.endLabel = [[UILabel alloc] initWithFrame:CGRectMake(41 * IPHONE6_WIDTH, 615 * IPHONE6_HEIGHT, 70 * IPHONE6_WIDTH, 15 * IPHONE6_HEIGHT)];
    self.endLabel.font = [UIFont systemFontOfSize:14 * IPHONE6_WIDTH];
    self.endLabel.text = @"end";
    self.endLabel.textAlignment = NSTextAlignmentCenter;
    self.endLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.endLabel];
#pragma mark - startbutton
    self.startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.startButton setImage:[UIImage imageNamed:@"con_icon_answer_default"] forState:UIControlStateNormal];
    self.startButton.frame = CGRectMake(265 * IPHONE6_WIDTH, 535 * IPHONE6_HEIGHT, 70 * IPHONE6_WIDTH, 70 * IPHONE6_HEIGHT);
    self.startButton.layer.cornerRadius = 35 * IPHONE6_WIDTH;
    self.startButton.clipsToBounds = YES;
    [self addSubview:self.startButton];
#pragma mark - startLabel
    self.startLabel = [[UILabel alloc] initWithFrame:CGRectMake(265 * IPHONE6_WIDTH, 615 * IPHONE6_HEIGHT, 70 * IPHONE6_WIDTH, 15 * IPHONE6_HEIGHT)];
    self.startLabel.font = [UIFont systemFontOfSize:14 * IPHONE6_WIDTH];
    self.startLabel.text = @"start";
    self.startLabel.textAlignment = NSTextAlignmentCenter;
    self.startLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.startLabel];
}







@end
