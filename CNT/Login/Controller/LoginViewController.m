//
//  LoginViewController.m
//  CNT
//
//  Created by 王智鑫 on 2017/11/8.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "WZXRegistrationViewController.h"
#import "WZXForgotViewController.h"
#import "ApiClient_AFNetworking.h"
#import "WZXBindingEmailViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <TwitterKit/TwitterKit.h>

@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) LoginView *loginV;
/// 邮箱
@property (nonatomic, copy) NSString *emailString;
/// 密码
@property (nonatomic, copy) NSString *passwordString;
/// 登录方式
@property (nonatomic, assign) NSInteger loginwayNum;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _loginV = [[LoginView alloc] init];
    _loginV.frame = CGRectMake(0, 0, KWIDTH, KHEIGHT);
    [self.view addSubview:_loginV];
    
#pragma mark - 回收键盘
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];
    
#pragma mark - 登陆按钮响应事件
    [_loginV.loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchDown];
    [_loginV.firsrHereBtn addTarget:self action:@selector(firstAction:) forControlEvents:UIControlEventTouchUpInside];
    [_loginV.forgotBtn addTarget:self action:@selector(forgotAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // 三方登陆
    [self.loginV.faceBtn addTarget:self action:@selector(faceAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginV.twitterBtn addTarget:self action:@selector(twitterAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginV.vChatBtn addTarget:self action:@selector(wechatAction:) forControlEvents:UIControlEventTouchUpInside];
    
#pragma mark - UItextField代理
    _loginV.emailTextField.delegate = self;
    _loginV.passWordTextField.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark 三方登陆

// 微信登录
- (void)wechatAction:(UIButton *)wechatBtn {
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
               if (state == SSDKResponseStateSuccess) {
                   NSLog(@"%@",user.credential);
                   NSLog(@"uid=%@",user.uid);
                   NSLog(@"token=%@",user.credential.token);
                   NSLog(@"nickname=%@",user.nickname);
                   // wu todo: 将sdk返回的uid以及平台 给后台判断是否存在该用户，不存在则走绑定邮箱页面 存在则直接算登陆成功
                   WZXBindingEmailViewController *bindingEmailVC = [[WZXBindingEmailViewController alloc] init];
                   bindingEmailVC.hidesBottomBarWhenPushed = YES;
                   [self.navigationController pushViewController:bindingEmailVC animated:YES];
               } else {
                   NSLog(@"%@",error);
               }
           }];
}

//faceBook登录
- (void)faceAction:(UIButton *)faceBtn {
    
    [ShareSDK getUserInfo:SSDKPlatformTypeFacebook
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
             
         }
         
         else
         {
             NSLog(@"%@",error);
         }
         
     }];
    
    NSLog(@"face透明btn。。。");
}

//twitter登录
- (void)twitterAction:(UIButton *)faceBtn {
    
    NSLog(@"twitter透明btn。。。");
    [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession * _Nullable session, NSError * _Nullable error) {
        
        if(session){
            NSLog(@"%@已登录",session.userName);
            
        }  else  {
            NSLog(@"error:%@",error.localizedDescription);
            
        }
        
    }];
}


#pragma mark - textField代理方法
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([textField isEqual:self.loginV.emailTextField]) {
        self.emailString = _loginV.emailTextField.text;
    } else if ([textField isEqual:self.loginV.passWordTextField]){
        self.passwordString = _loginV.passWordTextField.text;
    }
}

#pragma mark - 跳转新用户注册
- (void)firstAction:(UIButton *)newBtn {
    WZXRegistrationViewController *registrationVC = [[WZXRegistrationViewController alloc] init];
    [self.navigationController pushViewController:registrationVC animated:YES];
}

#pragma mark - 忘记密码
- (void)forgotAction:(UIButton *)forgetBtn {
    WZXForgotViewController *forgotVC = [[WZXForgotViewController alloc] init];
    self.modalPresentationStyle = UIModalPresentationPageSheet;
    // 模态跳转
    [self presentViewController:forgotVC animated:YES completion:NULL];
}

#pragma mark - 登录
- (void)loginAction:(UIButton *)btn {
    // 失去第一响应者
    [_loginV.emailTextField resignFirstResponder];
    [_loginV.passWordTextField resignFirstResponder];
    // 登入方式
    self.loginwayNum = 1;
    NSString *email = _loginV.emailTextField.text;
    NSString *password = _loginV.passWordTextField.text;
    if (IsEmptyStr(email) || IsEmptyStr(password)) {
        NSLog(@"填写完整");
        return;
    }
    NSString *urlString = [NSString stringWithFormat:@"%@",@"lucyAdmin/account/login"];
    NSDictionary *params = @{@"email":_emailString,
                             @"password":_passwordString,
                             @"loginway":@(_loginwayNum)
                             };
    
    [AFTools postWithUrl:urlString andParameters:params andSuccessBlock:^(id responseObject) {
        NSLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"code"]integerValue] == 1) {
            NSLog(@"登录成功");
            NSMutableDictionary *data = [responseObject objectForKey:@"data"];
            // 通知
            [[NSNotificationCenter defaultCenter] postNotificationName:LoginSuccessNotification object:@"1"];
            // yhy
            [AppUserModel setUserModelBasicDataWithDict:data];
            // 上传用户Token方法调用
            // [self pushDeviceToken];
        } else if ([[responseObject objectForKey:@"code"] integerValue] == -1) {
            /* 请求失败弹出提示框 */
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户名不存在或密码错误" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alert animated:YES completion:^{
                
            }];
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:alertAction];
        }
    } andFaileBlock:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

#warning 注册调用这个方法 第三方登录成功后调用这个方法
#pragma mark 上传用户token
- (void)pushDeviceToken {
    NSString *tokenString = [WSTools getInfoObject:DeviceToken];
    NSDictionary *parameters = @{@"deviceToken":tokenString,@"deviceType":@(2)};
    [AFTools postWithUrl:Resuest_PushTocken andParameters:parameters andSuccessBlock:^(id responseObject) {
        
    } andFaileBlock:^(NSError *error) {
        
    }];
}

#pragma mark - 回收键盘
-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer {
    [self.view endEditing:YES];
}

@end
