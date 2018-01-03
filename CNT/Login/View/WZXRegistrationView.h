//
//  WZXRegistrationView.h
//  CNT
//
//  Created by 王智鑫 on 2017/11/9.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZXRegistrationView : UIView

//背景
@property (nonatomic ,strong)UIImage *backImage;
@property (nonatomic ,strong)UIImageView *backImageView;

//账号邮箱
@property (nonatomic ,strong)UIView *emailView;
@property (nonatomic ,strong)UIImage *emailImage;
@property (nonatomic ,strong)UIImageView *emailImageView;
@property (nonatomic ,strong)UITextField *emailTextField;

//Security code
@property (nonatomic ,strong)UIView *securityView;
@property (nonatomic ,strong)UIImage *securityImage;
@property (nonatomic ,strong)UIImageView *securityImageView;
@property (nonatomic ,strong)UITextField *securityTextField;
//Text get code
@property (nonatomic ,strong)UIButton *textGetCodeBtn;


//密码
@property (nonatomic ,strong)UIView *passWordView;
@property (nonatomic ,strong)UIImage *passWordImage;
@property (nonatomic ,strong)UIImageView *passWordImageView;
@property (nonatomic ,strong)UITextField *passWordTextField;

//Nest
@property (nonatomic ,strong)UIButton *nextBtn;

//Return
@property (nonatomic ,strong)UIButton *backBtn;

@end
