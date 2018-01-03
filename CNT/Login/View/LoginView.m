//
//  LoginView.m
//  CNT
//
//  Created by 王智鑫 on 2017/11/8.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView
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
    self.emailView = [[UIView alloc] initWithFrame:CGRectMake(39 * IPHONE6_WIDTH, 185 * IPHONE6_HEIGHT, 297 * IPHONE6_WIDTH, 50 * IPHONE6_HEIGHT)];
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
    
#pragma mark - 密码
    self.passWordView = [[UIView alloc] initWithFrame:CGRectMake(39 * IPHONE6_WIDTH, 245 * IPHONE6_HEIGHT, 297 * IPHONE6_WIDTH, 50 * IPHONE6_HEIGHT)];
    self.passWordView.backgroundColor = [UIColor colorWithRed:255.0f/255.9f green:91.0f/255 blue:95.0f/255 alpha:0.46];
    self.passWordView.layer.cornerRadius = 5 * IPHONE6_WIDTH;
    self.passWordView.clipsToBounds = YES;
    [self addSubview:self.passWordView];
    //密码图标
    self.passWordImage = [UIImage imageNamed:@"suo_icon-pressed"];
    self.passWordImageView = [[UIImageView alloc] initWithImage:self.passWordImage];
    self.passWordImageView.frame = CGRectMake(17 * IPHONE6_WIDTH, 13 * IPHONE6_HEIGHT, 20 * IPHONE6_WIDTH, 25 * IPHONE6_HEIGHT);
    [self.passWordView addSubview:self.passWordImageView];
    //密码输入textfield
    self.passWordTextField = [[UITextField alloc] initWithFrame:CGRectMake(57 * IPHONE6_WIDTH, 17 * IPHONE6_HEIGHT, 220 * IPHONE6_WIDTH, 15 * IPHONE6_HEIGHT)];
    self.passWordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;//编辑出x
    self.passWordTextField.placeholder = @"Pass word";
    self.passWordTextField.textColor = [UIColor whiteColor];
    self.passWordTextField.secureTextEntry = YES;
    [self.passWordView addSubview:self.passWordTextField];
    
#pragma mark - 登入按钮
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.frame = CGRectMake(39 * IPHONE6_WIDTH, 305 * IPHONE6_HEIGHT, 297 * IPHONE6_WIDTH, 50 * IPHONE6_HEIGHT);
    self.loginBtn.backgroundColor = [UIColor colorWithRed:255.0f/255.9f green:91.0f/255 blue:95.0f/255 alpha:1];
    [self.loginBtn setTitle:@"login" forState:UIControlStateNormal];
    self.loginBtn.layer.cornerRadius = 5 * IPHONE6_WIDTH;
    self.loginBtn.clipsToBounds = YES;
    [self addSubview:self.loginBtn];
    
#pragma mark - Facebook 登录
    self.faceView = [[UIView alloc] initWithFrame:CGRectMake(39 * IPHONE6_WIDTH, 403 * IPHONE6_HEIGHT, 297 * IPHONE6_WIDTH, 50 * IPHONE6_HEIGHT)];
    self.faceView.backgroundColor = [UIColor colorWithRed:255.0f/255.9f green:91.0f/255 blue:95.0f/255 alpha:0.81];
    self.faceView.layer.cornerRadius = 5 * IPHONE6_WIDTH;
    self.faceView.clipsToBounds = YES;
    [self addSubview:self.faceView];
    //facebook突破安
    self.faceImage = [UIImage imageNamed:@"Facebook_icon_pressed"];
    self.faceImageView = [[UIImageView alloc] initWithImage:self.faceImage];
    self.faceImageView.frame = CGRectMake(53 * IPHONE6_WIDTH, 13 * IPHONE6_HEIGHT, 10 * IPHONE6_WIDTH, 22 * IPHONE6_HEIGHT);
    [self.faceView addSubview:self.faceImageView];
    //facebook字
    self.faceLabel = [[UILabel alloc] initWithFrame:CGRectMake(81 * IPHONE6_WIDTH, 13 * IPHONE6_HEIGHT, 200 * IPHONE6_WIDTH, 19 * IPHONE6_HEIGHT)];
    self.faceLabel.text = @"Sign in with Facebook";
    self.faceLabel.textColor = [UIColor whiteColor];
    self.faceLabel.font = [UIFont systemFontOfSize:16 * IPHONE6_WIDTH];
    [self.faceView addSubview:self.faceLabel];
    //透明button
    self.faceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.faceBtn.frame = CGRectMake(0, 0, 297 * IPHONE6_WIDTH, 50 * IPHONE6_HEIGHT);
    [self.faceView addSubview:self.faceBtn];
    
#pragma mark - Twitter 登陆
    self.twitterView = [[UIView alloc] initWithFrame:CGRectMake(39 * IPHONE6_WIDTH, 463 * IPHONE6_HEIGHT, 297 * IPHONE6_WIDTH, 50 * IPHONE6_HEIGHT)];
    self.twitterView.backgroundColor = [UIColor colorWithRed:255.0f/255.9f green:91.0f/255 blue:95.0f/255 alpha:0.81];
    self.twitterView.layer.cornerRadius = 5 * IPHONE6_WIDTH;
    self.twitterView.clipsToBounds = YES;
    [self addSubview:self.twitterView];
    //Twitterk图片
    self.twitterImage = [UIImage imageNamed:@"twitter_icon_pressed"];
    self.twitterImageView = [[UIImageView alloc] initWithImage:self.twitterImage];
    self.twitterImageView.frame = CGRectMake(47 * IPHONE6_WIDTH, 13 * IPHONE6_HEIGHT, 25 * IPHONE6_WIDTH, 22 * IPHONE6_HEIGHT);
    [self.twitterView addSubview:self.twitterImageView];
    //Twitter字
    self.twitterLabel = [[UILabel alloc] initWithFrame:CGRectMake(81 * IPHONE6_WIDTH, 13 * IPHONE6_HEIGHT, 200 * IPHONE6_WIDTH, 19 * IPHONE6_HEIGHT)];
    self.twitterLabel.text = @"Sign in with Twitter";
    self.twitterLabel.textColor = [UIColor whiteColor];
    self.twitterLabel.font = [UIFont systemFontOfSize:16 * IPHONE6_WIDTH];
    [self.twitterView addSubview:self.twitterLabel];
    //透明button
    self.twitterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.twitterBtn.frame = CGRectMake(0, 0, 297 * IPHONE6_WIDTH, 50 * IPHONE6_HEIGHT);
    [self.twitterView addSubview:self.twitterBtn];
    
#pragma mark - wechat 登陆
    self.vChatView = [[UIView alloc] initWithFrame:CGRectMake(39 * IPHONE6_WIDTH, 523 * IPHONE6_HEIGHT, 297 * IPHONE6_WIDTH, 50 * IPHONE6_HEIGHT)];
    self.vChatView.backgroundColor = [UIColor colorWithRed:255.0f/255.9f green:91.0f/255 blue:95.0f/255 alpha:0.81];
    self.vChatView.layer.cornerRadius = 5 * IPHONE6_WIDTH;
    self.vChatView.clipsToBounds = YES;
    [self addSubview:self.vChatView];
    //wechat图片
    self.vChatImage = [UIImage imageNamed:@"wechat_icon_default"];
    self.vChatImageView = [[UIImageView alloc] initWithImage:self.vChatImage];
    self.vChatImageView.frame = CGRectMake(47 * IPHONE6_WIDTH, 13 * IPHONE6_HEIGHT, 25 * IPHONE6_WIDTH, 22 * IPHONE6_HEIGHT);
    [self.vChatView addSubview:self.vChatImageView];
    //wechat字
    self.vChatLabel = [[UILabel alloc] initWithFrame:CGRectMake(81 * IPHONE6_WIDTH, 13 * IPHONE6_HEIGHT, 200 * IPHONE6_WIDTH, 19 * IPHONE6_HEIGHT)];
    self.vChatLabel.text = @"Sign in with WeChat";
    self.vChatLabel.textColor = [UIColor whiteColor];
    self.vChatLabel.font = [UIFont systemFontOfSize:16 * IPHONE6_WIDTH];
    [self.vChatView addSubview:self.vChatLabel];
    //透明button
    self.vChatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.vChatBtn.frame = CGRectMake(0, 0, 297 * IPHONE6_WIDTH, 50 * IPHONE6_HEIGHT);
    [self.vChatView addSubview:self.vChatBtn];
    
#pragma mark - forgot
    self.forgotBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.forgotBtn.frame = CGRectMake(22 * IPHONE6_WIDTH, 622 * IPHONE6_HEIGHT, 150 * IPHONE6_WIDTH, 20 * IPHONE6_HEIGHT);
    self.forgotBtn.titleLabel.font = [UIFont systemFontOfSize:14 * IPHONE6_WIDTH];
    [self.forgotBtn setTitle:@"Forgot password" forState:UIControlStateNormal];
    [self.forgotBtn setTitleColor:[UIColor colorWithRed:191.0f/255.0f green:191.0f/255.0f blue:191.0f/255.0f alpha:1] forState:UIControlStateNormal];
    [self addSubview:self.forgotBtn];
    
#pragma mark - New here
    self.firsrHereBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.firsrHereBtn.frame = CGRectMake(190 * IPHONE6_WIDTH, 622 * IPHONE6_HEIGHT, 150 * IPHONE6_WIDTH, 20 * IPHONE6_HEIGHT);
    self.firsrHereBtn.titleLabel.font = [UIFont systemFontOfSize:14 * IPHONE6_WIDTH];
    [self.firsrHereBtn setTitle:@"New here? sign up" forState:UIControlStateNormal];
    [self.firsrHereBtn setTitleColor:[UIColor colorWithRed:191.0f/255.0f green:191.0f/255.0f blue:191.0f/255.0f alpha:1] forState:UIControlStateNormal];
    [self addSubview:self.firsrHereBtn];
    
    self.lightView = [[UIView alloc] initWithFrame:CGRectMake(202 * IPHONE6_WIDTH, 640 * IPHONE6_HEIGHT, 135 * IPHONE6_WIDTH, 1 * IPHONE6_HEIGHT)];
    self.lightView.backgroundColor = [UIColor colorWithRed:191.0f/255.0f green:191.0f/255.0f blue:191.0f/255.0f alpha:1];
    [self addSubview:self.lightView];
}

#pragma mark 上传用户token

- (void)pushDeviceToken {
    
    NSString *tokenString = [WSTools getInfoObject:DeviceToken];
    
    NSDictionary *parameters = @{@"deviceToken":tokenString,@"deviceType":@(2)};
    
    
    [AFTools postWithUrl:Resuest_PushTocken andParameters:parameters andSuccessBlock:^(id responseObject) {
        
        
        
    } andFaileBlock:^(NSError *error) {
        
        
        
    }];
    
    
    
}

@end
