//
//  WZXBindingEmailView.h
//  CNT
//
//  Created by 王智鑫 on 2017/12/23.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZXBindingEmailView : UIView
/*
 ** 绑定邮箱
 */
@property (nonatomic ,strong)UIView *firstView;
@property (nonatomic ,strong)UILabel *emailLabel;
@property (nonatomic ,strong)UIView *firsVerticalBarView;
@property (nonatomic ,strong)UITextField *emailTextField;
/*
 ** 验证码
 */
@property (nonatomic ,strong)UIView *secondView;
@property (nonatomic ,strong)UITextField *codeTextField;
@property (nonatomic ,strong)UIView *secondVerticalBarView;
@property (nonatomic ,strong)UIButton *codeButton;
/*
 ** 确定
 */
@property (nonatomic ,strong)UIButton *nextBtn;

@end
