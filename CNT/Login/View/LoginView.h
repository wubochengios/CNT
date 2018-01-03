//
//  LoginView.h
//  CNT
//
//  Created by 王智鑫 on 2017/11/8.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIView
//背景
@property (nonatomic ,strong)UIImage *backImage;
@property (nonatomic ,strong)UIImageView *backImageView;

//账号邮箱
@property (nonatomic ,strong)UIView *emailView;
@property (nonatomic ,strong)UIImage *emailImage;
@property (nonatomic ,strong)UIImageView *emailImageView;
@property (nonatomic ,strong)UITextField *emailTextField;

//密码
@property (nonatomic ,strong)UIView *passWordView;
@property (nonatomic ,strong)UIImage *passWordImage;
@property (nonatomic ,strong)UIImageView *passWordImageView;
@property (nonatomic ,strong)UITextField *passWordTextField;

//登录按钮
@property (nonatomic ,strong)UIButton *loginBtn;
//Jump FaceBook and Twitter
@property (nonatomic ,strong)UIView *faceView;
@property (nonatomic ,strong)UIImage *faceImage;
@property (nonatomic ,strong)UIImageView *faceImageView;
@property (nonatomic ,strong)UILabel *faceLabel;
@property (nonatomic ,strong)UIButton *faceBtn;
//and Twitter
@property (nonatomic ,strong)UIView *twitterView;
@property (nonatomic ,strong)UIImage *twitterImage;
@property (nonatomic ,strong)UIImageView *twitterImageView;
@property (nonatomic ,strong)UILabel *twitterLabel;
@property (nonatomic ,strong)UIButton *twitterBtn;
//and vChat
@property (nonatomic ,strong)UIView *vChatView;
@property (nonatomic ,strong)UIImage *vChatImage;
@property (nonatomic ,strong)UIImageView *vChatImageView;
@property (nonatomic ,strong)UILabel *vChatLabel;
@property (nonatomic ,strong)UIButton *vChatBtn;
//忘记密码
@property (nonatomic ,strong)UIButton *forgotBtn;
//New here
@property (nonatomic ,strong)UIButton *firsrHereBtn;
@property (nonatomic ,strong)UIView *lightView;

@end
