//
//  WZXRegistrationView.m
//  CNT
//
//  Created by 王智鑫 on 2017/11/9.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXRegistrationView.h"

@implementation WZXRegistrationView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createSubView];
    }
    return self;
}


- (void)createSubView {
    
#pragma mark - 背景图片
    self.backImage = [UIImage imageNamed:@"bg_img"];
    self.backImageView = [[UIImageView alloc] initWithImage:self.backImage];
    self.backImageView.frame = CGRectMake(0, 0, KWIDTH, KHEIGHT);
    [self addSubview:self.backImageView];
    
#pragma mark - 账号
    self.emailView = [[UIView alloc] initWithFrame:CGRectMake(39 * IPHONE6_WIDTH, 190 * IPHONE6_HEIGHT, 297 * IPHONE6_WIDTH, 50 * IPHONE6_HEIGHT)];
    self.emailView.backgroundColor = [UIColor colorWithRed:255.0f/255.9f green:91.0f/255 blue:95.0f/255 alpha:0.46];
    self.emailView.layer.cornerRadius = 5 * IPHONE6_WIDTH;
    self.emailView.clipsToBounds = YES;
    [self addSubview:self.emailView];
    //邮箱图标
    self.emailImage = [UIImage imageNamed:@"mail_icon_pressed"];
    self.emailImageView = [[UIImageView alloc] initWithImage:self.emailImage];
    self.emailImageView.frame = CGRectMake(17 * IPHONE6_WIDTH, 17 * IPHONE6_HEIGHT, 20 * IPHONE6_WIDTH, 15 * IPHONE6_HEIGHT);
    [self.emailView addSubview:self.emailImageView];
    //账号输入textfield
    self.emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(57 * IPHONE6_WIDTH, 17 * IPHONE6_HEIGHT, 220 * IPHONE6_WIDTH, 15 * IPHONE6_HEIGHT)];
    self.emailTextField.clearButtonMode = UITextFieldViewModeWhileEditing;//编辑出x
    self.emailTextField.placeholder = @"E-mail address";
    self.emailTextField.textColor = [UIColor whiteColor];
    [self.emailView addSubview:self.emailTextField];
    
#pragma mark - security
    self.securityView = [[UIView alloc] initWithFrame:CGRectMake(39 * IPHONE6_WIDTH, 255 * IPHONE6_HEIGHT, 165 * IPHONE6_WIDTH, 50 * IPHONE6_HEIGHT)];
    self.securityView.backgroundColor = [UIColor colorWithRed:255.0f/255.9f green:91.0f/255 blue:95.0f/255 alpha:0.46];
    self.securityView.layer.cornerRadius = 5 * IPHONE6_HEIGHT;
    self.securityView.clipsToBounds = YES;
    [self addSubview:self.securityView];
    //security
    self.securityImage = [UIImage imageNamed:@"suo_icon-pressed"];
    self.securityImageView = [[UIImageView alloc] initWithImage:self.securityImage];
    self.securityImageView.frame = CGRectMake(17 * IPHONE6_WIDTH, 13 * IPHONE6_HEIGHT, 20 * IPHONE6_WIDTH, 25 * IPHONE6_HEIGHT);
    [self.securityView addSubview:self.securityImageView];
    //输入securitytextfield
    self.securityTextField = [[UITextField alloc] initWithFrame:CGRectMake(57 * IPHONE6_WIDTH, 17 * IPHONE6_HEIGHT, 100 * IPHONE6_WIDTH, 15 * IPHONE6_HEIGHT)];
    self.securityTextField.clearButtonMode = UITextFieldViewModeWhileEditing;//编辑出x
    self.securityTextField.placeholder = @"Security code";
    self.securityTextField.textColor = [UIColor whiteColor];
    [self.securityView addSubview:self.securityTextField];
    //Text get btn
    self.textGetCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.textGetCodeBtn.frame = CGRectMake(211 * IPHONE6_WIDTH, 255 * IPHONE6_HEIGHT, 125 * IPHONE6_WIDTH, 50 * IPHONE6_HEIGHT);
    [self.textGetCodeBtn setTitle:@"Text get code" forState:UIControlStateNormal];
    self.textGetCodeBtn.backgroundColor = [UIColor colorWithRed:255.0f/255.9f green:91.0f/255 blue:95.0f/255 alpha:0.91];
    self.textGetCodeBtn.layer.cornerRadius = 5 * IPHONE6_HEIGHT;
    self.textGetCodeBtn.clipsToBounds = YES;
    [self addSubview:self.textGetCodeBtn];
    
#pragma mark - 密码
    self.passWordView = [[UIView alloc] initWithFrame:CGRectMake(39 * IPHONE6_WIDTH, 320 * IPHONE6_HEIGHT, 297 * IPHONE6_WIDTH, 50 * IPHONE6_HEIGHT)];
    self.passWordView.backgroundColor = [UIColor colorWithRed:255.0f/255.9f green:91.0f/255 blue:95.0f/255 alpha:0.46];
    self.passWordView.layer.cornerRadius = 5;
    self.passWordView.clipsToBounds = YES;
    [self addSubview:self.passWordView];
    //密码图标
    self.passWordImage = [UIImage imageNamed:@"icon_yaoshi_pressed"];
    self.passWordImageView = [[UIImageView alloc] initWithImage:self.passWordImage];
    self.passWordImageView.frame = CGRectMake(17 * IPHONE6_WIDTH, 13 * IPHONE6_HEIGHT, 20 * IPHONE6_WIDTH, 20 * IPHONE6_HEIGHT);
    [self.passWordView addSubview:self.passWordImageView];
    //密码输入textfield
    self.passWordTextField = [[UITextField alloc] initWithFrame:CGRectMake(57 * IPHONE6_WIDTH, 17 * IPHONE6_HEIGHT, 220 * IPHONE6_WIDTH, 15 * IPHONE6_HEIGHT)];
    self.passWordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;//编辑出x
    self.passWordTextField.placeholder = @"Please enter your password";
    self.passWordTextField.textColor = [UIColor whiteColor];
    self.passWordTextField.secureTextEntry = YES;
    [self.passWordView addSubview:self.passWordTextField];
    
#pragma mark - Next
    self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextBtn.frame = CGRectMake(39 * IPHONE6_WIDTH, 463 * IPHONE6_HEIGHT, 297 * IPHONE6_WIDTH, 50 * IPHONE6_HEIGHT);
    self.nextBtn.backgroundColor = [UIColor colorWithRed:255.0f/255.9f green:91.0f/255 blue:95.0f/255 alpha:1];
    [self.nextBtn setTitle:@"Next" forState:UIControlStateNormal];
    self.nextBtn.layer.cornerRadius = 5;
    self.nextBtn.clipsToBounds = YES;
    [self addSubview:self.nextBtn];
    
#pragma mark - 返回键子
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(20 * IPHONE6_WIDTH, 25 * IPHONE6_HEIGHT, 60 * IPHONE6_WIDTH, 16 * IPHONE6_HEIGHT);
    self.backBtn.titleLabel.font = [UIFont systemFontOfSize:13 * IPHONE6_WIDTH];
    [self.backBtn setTitle:@"Return" forState:UIControlStateNormal];
    [self.backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.backBtn.layer.cornerRadius = 8 * IPHONE6_HEIGHT;
    self.backBtn.clipsToBounds = YES;
    self.backBtn.backgroundColor = [UIColor colorWithRed:255.0f/255.9f green:91.0f/255 blue:95.0f/255 alpha:0.46];
    [self addSubview:self.backBtn];
    
    
}











@end
