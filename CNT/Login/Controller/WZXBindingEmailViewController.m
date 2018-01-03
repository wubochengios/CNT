//
//  WZXBindingEmailViewController.m
//  CNT
//
//  Created by 王智鑫 on 2017/12/23.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXBindingEmailViewController.h"
#import "WZXBindingEmailView.h"
#import "WZXRegistrationPreViewController.h"

@interface WZXBindingEmailViewController ()

@property (nonatomic, strong) WZXBindingEmailView *bindingEmailView;
// @{email: security} 要注册的邮箱和验证码一一对应
@property (nonatomic, strong) NSMutableDictionary *esDic;
// 邮箱
@property (nonatomic, copy) NSString *emailStr;
// 验证码
@property (nonatomic, copy) NSString *securityStr;
@property (nonatomic, assign) NSInteger secondsCountDown; // 倒计时总时长
@property (nonatomic, strong) NSTimer *countDownTimer;

@end

@implementation WZXBindingEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"绑定邮箱";
    [self createSubView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)createSubView {
    _bindingEmailView = [[WZXBindingEmailView alloc] initWithFrame:CGRectMake(0, 64, KWIDTH, KHEIGHT)];
    [self.view addSubview:_bindingEmailView];
    [_bindingEmailView.codeButton addTarget:self action:@selector(codeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bindingEmailView.nextBtn addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 获取验证码
- (void)codeBtnAction:(UIButton *)codeBtn {
    // 校验邮箱格式
    if (![WSTools checkEmail:self.emailStr]) {
        [MBProgressHUD showError:@"邮箱格式不正确"];
        return;
    }
    
    // 请求成功之后开始倒计时
    [self startTheTime];
    
    NSDictionary *params = @{@"account":self.emailStr};
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
    self.bindingEmailView.codeButton.userInteractionEnabled = NO;
    // 设置倒计时总时长 60秒
    self.secondsCountDown = 60;
    // 开始倒计时
    self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
    // 设置倒计时显示的时间
    NSString *timeStr = [NSString stringWithFormat:@"(%ld)秒", _secondsCountDown];
    [self.bindingEmailView.codeButton setTitle:timeStr forState:UIControlStateNormal];
}

- (void)timeFireMethod{
    // 倒计时-1
    _secondsCountDown--;
    // 修改倒计时标签现实内容
    NSString *timeStr = [NSString stringWithFormat:@"(%ld)秒", _secondsCountDown];
    [self.bindingEmailView.codeButton setTitle:timeStr forState:UIControlStateNormal];
    // 当倒计时到0时，做需要的操作，比如验证码过期不能提交
    if(_secondsCountDown == 0){
        [self.bindingEmailView.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.bindingEmailView.codeButton.userInteractionEnabled = YES;
        [ _countDownTimer invalidate];
    }
}

#pragma mark - 完成按钮触发事件
- (void)nextAction:(UIButton *)nextBtn {
    [self.view endEditing:YES];
    if (self.securityStr.length > 0 && [self.securityStr isEqualToString: self.esDic[self.emailStr]]) {
        WZXRegistrationPreViewController *preVC = [[WZXRegistrationPreViewController alloc] init];
        preVC.email = self.emailStr;
        [self.navigationController pushViewController:preVC animated:YES];
    } else {
        [MBProgressHUD showError:@"验证码或邮箱错误"];
    }
}

#pragma mark - getter / setter
- (NSMutableDictionary *)esDic {
    if (!_esDic) {
        _esDic = [NSMutableDictionary dictionary];
    }
    return _esDic;
}
- (NSString *)emailStr {
    return self.bindingEmailView.emailTextField.text;
}
- (NSString *)securityStr {
    return self.bindingEmailView.codeTextField.text;
}
@end
