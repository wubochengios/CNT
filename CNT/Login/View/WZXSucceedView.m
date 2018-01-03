//
//  WZXSucceedView.m
//  CNT
//
//  Created by 王智鑫 on 2017/11/9.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXSucceedView.h"

@implementation WZXSucceedView

- (instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createSubView];
    }
    return self;
}

- (void)createSubView {
    //headView红色
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 64)];
    self.headView.backgroundColor = REDCOLOR;
    [self addSubview:self.headView];
    //headView上的字
    self.headLable = [[UILabel alloc] initWithFrame:CGRectMake(165, 30, 95, 30)];
    self.headLable.text = @"注册成功";
    self.headLable.textColor = [UIColor whiteColor];
    self.headLable.font = [UIFont systemFontOfSize:18];
    self.headLable.backgroundColor = [UIColor colorWithRed:255.0f/255.9f green:91.0f/255 blue:95.0f/255 alpha:0.81];
    [self addSubview:self.headLable];
    //圆形图片
    self.tickImage = [UIImage imageNamed:@"icon_cg_pressed"];
    self.tickImageView = [[UIImageView alloc] initWithImage:self.tickImage];
    self.tickImageView.frame = CGRectMake(130, 165, 150, 150);
    self.tickImageView.layer.cornerRadius = 75;
    self.tickImageView.clipsToBounds = YES;
    [self addSubview:self.tickImageView];
    //中文label
    self.englishLabel = [[UILabel alloc] initWithFrame:CGRectMake(95, 355, 240, 30)];
    self.englishLabel.text = @"Register success，welcome to";
    self.englishLabel.textColor = [UIColor colorWithRed:255.0f/255.9f green:91.0f/255 blue:95.0f/255 alpha:0.9];
    [self addSubview:self.englishLabel];
    //中文label
    self.chineselabel = [[UILabel alloc] initWithFrame:CGRectMake(135, 410, 160, 30)];
    self.chineselabel.text = @"注册成功，欢迎使用";
    self.chineselabel.textColor = [UIColor colorWithRed:255.0f/255.9f green:91.0f/255 blue:95.0f/255 alpha:0.9];
    [self addSubview:self.chineselabel];
    //点击进入
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginBtn setTitle:@"Click to enter \n 点击进入" forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(loginBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.loginBtn.backgroundColor = REDCOLOR;
    self.loginBtn.layer.cornerRadius = 10;
    self.loginBtn.clipsToBounds = YES;
    self.loginBtn.frame = CGRectMake(60, 550, 297, 60);
    [self addSubview:self.loginBtn];
    
}

- (void)loginBtnAction:(UIButton *)btn {
    
    //通知
    [[NSNotificationCenter defaultCenter] postNotificationName:LoginSuccessNotification object:@"1"];
    NSLog(@"登录");
}


@end
