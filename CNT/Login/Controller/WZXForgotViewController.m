//
//  WZXForgotViewController.m
//  CNT
//
//  Created by 王智鑫 on 2017/11/9.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXForgotViewController.h"
#import "WZXForgotView.h"
#import "LoginViewController.h"

@interface WZXForgotViewController ()<UITextFieldDelegate>
/** 邮箱 */
@property (nonatomic ,copy)NSString *emailString;
/** 密码 */
@property (nonatomic ,copy)NSString *passwordString;
/** 确认密码 */
@property (nonatomic ,copy)NSString *confirmPasswordString;
/** 忘记密码View */
@property (nonatomic ,strong)WZXForgotView *forgotView;
/** 获取验证码 */
@property (nonatomic ,copy)NSString *securityString;
@property (nonatomic ,strong)NSString *security;  //验证码
/** 倒计时总时长 */
@property (nonatomic,assign) NSInteger    secondsCountDown;
@property (nonatomic,strong) NSTimer      *countDownTimer;
/** 创建验证码dic */
@property (nonatomic ,strong)NSMutableDictionary *dic;

@end

@implementation WZXForgotViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.forgotView = [[WZXForgotView alloc] init];
    self.forgotView.frame = CGRectMake(0, 0, KWIDTH, KHEIGHT);
    [self.view addSubview:self.forgotView];
#pragma mark - 回收键盘
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];
#pragma mark - 登陆按钮响应事件
    //[loginV.loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchDown];
    [self.forgotView.backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.forgotView.deterMineBtn addTarget:self action:@selector(deterMineAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.forgotView.textGetCodeBtn addTarget:self action:@selector(textGetCodeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
#pragma mark - UItextField代理
    _forgotView.emailTextField.delegate = self;
    _forgotView.passWordTextField.delegate = self;
    _forgotView.confirmPasswordTextField.delegate = self;
    _forgotView.securityTextField.delegate = self;
}
#pragma mark - textField代理方法
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    if ([textField isEqual:self.forgotView.securityTextField]) {
        self.security = _forgotView.securityTextField.text;
        return YES;
    }
    else if ([textField isEqual:self.forgotView.emailTextField]){
        return YES;
    } else if ([textField isEqual:self.forgotView.passWordTextField]) {
        
        self.passwordString = _forgotView.passWordTextField.text;
        return YES;
    }
    else {
        return YES;
    }
}

#pragma mark - textField代理方法
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if ([textField isEqual:self.forgotView.emailTextField]) {
        self.emailString = _forgotView.emailTextField.text;
    }
    else if ([textField isEqual:self.forgotView.passWordTextField]){
        self.passwordString = _forgotView.passWordTextField.text;
    }
    else if ([textField isEqual:self.forgotView.confirmPasswordTextField]){
        self.confirmPasswordString = _forgotView.confirmPasswordTextField.text;
    }
    else if ([textField isEqual:self.forgotView.securityTextField]) {
        self.security = _forgotView.securityTextField.text;
    }
}
#pragma mark - 验证码
- (void)textGetCodeBtnAction:(UIButton *)btn {
    self.dic = [NSMutableDictionary new];
    self.emailString = _forgotView.emailTextField.text;
    NSDictionary *params = @{@"account":self.emailString};
    
    BOOL emilBool= [self validateEmail:self.forgotView.emailTextField.text];
    if (emilBool == NO) {
        NSLog(@"NO");
        [MBProgressHUD showSuccess:@"邮箱格式不正确,验证码发送失败" toView:self.view];
    }else{
    
        if (IsEmptyStr(self.emailString)) {
            [MBProgressHUD showSuccess:@"请填写邮箱地址" toView:self.view];
            return;
        }
        //请求验证码
        [AFTools postWithUrl:Request_Login_sendEamil andParameters:params andSuccessBlock:^(id responseObject) {
            NSLog(@"%@",responseObject);
            if ([[responseObject objectForKey:@"code"]integerValue] == 1) {
                NSMutableDictionary *data = [responseObject objectForKey:@"data"];
                self.securityString = [data objectForKey:@"securityCode"];
                [self startTheTime];
            }
            
        } andFaileBlock:^(NSError *error) {
            
            NSLog(@"%@",error);
        }];
        NSLog(@"Text get code");
    }
}

- (void)startTheTime {
    self.forgotView.textGetCodeBtn.userInteractionEnabled = NO;
    //设置倒计时总时长
    self.secondsCountDown = 60;//60秒倒计时
    //开始倒计时
    self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES]; //启动倒计时后会每秒钟调用一次方法 timeFireMethod
    //设置倒计时显示的时间
    NSString *timeStr = [NSString stringWithFormat:@"(%ld)秒",_secondsCountDown];
    [self.forgotView.textGetCodeBtn setTitle:timeStr forState:UIControlStateNormal];
}

-(void)timeFireMethod{
    //倒计时-1
    _secondsCountDown--;
    //修改倒计时标签现实内容
    NSString *timeStr = [NSString stringWithFormat:@"(%ld)秒",_secondsCountDown];
    [self.forgotView.textGetCodeBtn setTitle:timeStr forState:UIControlStateNormal];    //当倒计时到0时，做需要的操作，比如验证码过期不能提交
    if(_secondsCountDown == 0){
        [self.forgotView.textGetCodeBtn setTitle:@"Text get code" forState:UIControlStateNormal];    //当倒计时到0时，做需要的操作，比如验证码过期不能提交
        self.forgotView.textGetCodeBtn.userInteractionEnabled = YES;
        [ _countDownTimer invalidate];
        _countDownTimer = nil;
    }
}


#pragma mark - 邮箱 - 正则表达式
- (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
    
}

#pragma mark - 修改 确定下一步 按钮
- (void)deterMineAction:(UIButton *)nextBtn{
    // 失去第一响应者
    [_forgotView.emailTextField resignFirstResponder];
    [_forgotView.passWordTextField resignFirstResponder];
    [_forgotView.confirmPasswordTextField resignFirstResponder];
    [_forgotView.securityTextField resignFirstResponder];
    // 获取账号密码
    NSString *email = _forgotView.emailTextField.text;
    NSString *password = _forgotView.passWordTextField.text;
    NSString *confirmPassWord = _forgotView.confirmPasswordTextField.text;
    
    // 获取当前正在输入的textField
    if ( self.security == self.securityString) {
        
        if (IsEmptyStr(email) || IsEmptyStr(password) || IsEmptyStr(confirmPassWord)) {
            [MBProgressHUD showSuccess:@"请填写完整" toView:self.view];
            return;
        }
        else if (password != confirmPassWord) {
            [MBProgressHUD showSuccess:@"两次密码不一致" toView:self.view];
            return;
        }
        NSDictionary *params = @{@"email":_emailString,
                                 @"password":_passwordString,
                                 };
        
        [AFTools postWithUrl:Request_login_forgotPassWord andParameters:params andSuccessBlock:^(id responseObject) {
            NSLog(@"%@",responseObject);
            if ([[responseObject objectForKey:@"code"]integerValue] == 1) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"恭喜您，密码修改成功" preferredStyle:UIAlertControllerStyleAlert];
                [self presentViewController:alert animated:YES completion:^{
                    
                }];
                UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                   [self dismissViewControllerAnimated:YES completion:NULL];
                }];
                [alert addAction:alertAction];

            }else if ([[responseObject objectForKey:@"code"] integerValue] == -1) {
                [MBProgressHUD showSuccess:@"修改失败" toView:self.view];
            }
        } andFaileBlock:^(NSError *error) {
            NSLog(@"%@", error);
        }];
    } else {
        
        [MBProgressHUD showSuccess:@"验证码错误" toView:self.view];
    }
}


#pragma mark - 模态返回
- (void)backAction:(UIButton *)backBtn {
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}
#pragma mark - 回收键盘
-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
