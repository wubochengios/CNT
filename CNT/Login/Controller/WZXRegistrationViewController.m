//
//  WZXRegistrationViewController.m
//  CNT
//
//  Created by 王智鑫 on 2017/11/9.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXRegistrationViewController.h"
#import "WZXRegistrationView.h"
#import "WZXRegistrationPreViewController.h"

@interface WZXRegistrationViewController ()

// 注册页面
@property (nonatomic, strong) WZXRegistrationView *registrationV;
// @{email: security} 要注册的邮箱和验证码一一对应
@property (nonatomic, strong) NSMutableDictionary *esDic;
// 邮箱
@property (nonatomic, copy) NSString *emailStr;
// 验证码
@property (nonatomic, copy) NSString *securityStr;
// 密码
@property (nonatomic, copy) NSString *passwordStr;
// 倒计时总时长
@property (nonatomic, assign) NSInteger secondsCountDown;
@property (nonatomic, strong) NSTimer *countDownTimer;

@end

@implementation WZXRegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.registrationV = [[WZXRegistrationView alloc] init];
    self.registrationV.frame = CGRectMake(0, 0, KWIDTH, KHEIGHT);
    [self.view addSubview:self.registrationV];
    
    // 回收键盘
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];
    
    [self.registrationV.backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    // 获取验证码
    [self.registrationV.textGetCodeBtn addTarget:self action:@selector(textGetCodeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.registrationV.nextBtn addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark - 获取验证码
- (void)textGetCodeBtnAction:(UIButton *)btn {
    // 校验邮箱格式
    if (![WSTools checkEmail:self.emailStr]) {
        [MBProgressHUD showError:@"邮箱格式不正确"];
        return;
    }
    
    // 请求成功之后开始倒计时
    [self startTheTime];
    
    NSDictionary *params = @{@"account": self.emailStr};
    // 请求验证码
    [AFTools postWithUrl:Request_Login_sendEamil andParameters:params andSuccessBlock:^(id responseObject) {
        NSLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"code"] integerValue] == 1) {
            NSMutableDictionary *data = [responseObject objectForKey:@"data"];
            NSString *securityCode = [data objectForKey:@"securityCode"];
            // 将邮箱与验证码绑定
            self.esDic[self.emailStr] = securityCode;
        }
    } andFaileBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)startTheTime {
    self.registrationV.textGetCodeBtn.userInteractionEnabled = NO;
    // 设置倒计时总时长 60秒
    self.secondsCountDown = 60;
    // 开始倒计时
    self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
    // 设置倒计时显示的时间
    NSString *timeStr = [NSString stringWithFormat:@"(%ld)秒", _secondsCountDown];
    [self.registrationV.textGetCodeBtn setTitle:timeStr forState:UIControlStateNormal];
}

- (void)timeFireMethod{
    // 倒计时-1
    _secondsCountDown--;
    // 修改倒计时标签现实内容
    NSString *timeStr = [NSString stringWithFormat:@"(%ld)秒", _secondsCountDown];
    [self.registrationV.textGetCodeBtn setTitle:timeStr forState:UIControlStateNormal];
    // 当倒计时到0时，做需要的操作，比如验证码过期不能提交
    if(_secondsCountDown == 0) {
        [self.registrationV.textGetCodeBtn setTitle:@"Text get code" forState:UIControlStateNormal];
        self.registrationV.textGetCodeBtn.userInteractionEnabled = YES;
        [ _countDownTimer invalidate];
    }
}

#pragma mark - 下一步
- (void)nextAction:(UIButton *)nextBtn{
    [self.view endEditing:YES];
    
    if (self.securityStr.length > 0 && [self.securityStr isEqualToString: self.esDic[self.emailStr]]) {
        if (self.passwordStr.length > 0) {
            //等后台接口
            //                NSDictionary *dic = @{@"account":_email};
            //                [AFTools postWithUrl:Request_Login_sendEamil andParameters:dic andSuccessBlock:^(id responseObject) {
            //
            //
            //                } andFaileBlock:^(NSError *error) {
            //
            //                }];
            WZXRegistrationPreViewController *preVC = [[WZXRegistrationPreViewController alloc] init];
            preVC.passWord = self.passwordStr;
            preVC.email = self.emailStr;
            [self.navigationController pushViewController:preVC animated:YES];
        } else {
            [MBProgressHUD showError:@"请填写密码"];
        }
    } else {
        [MBProgressHUD showError:@"验证码或邮箱错误"];
    }
}

#pragma mark - 回收键盘
- (void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer {
    [self.view endEditing:YES];
}

#pragma mark 返回
- (void)backAction:(UIButton *)backBtn {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - getter / setter
- (NSMutableDictionary *)esDic {
    if (!_esDic) {
        _esDic = [NSMutableDictionary dictionary];
    }
    return _esDic;
}
- (NSString *)emailStr {
    return self.registrationV.emailTextField.text;
}
- (NSString *)securityStr {
    return self.registrationV.securityTextField.text;
}
- (NSString *)passwordStr {
    return self.registrationV.passWordTextField.text;
}

@end

