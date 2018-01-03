//
//  WZXBindingEmailView.m
//  CNT
//
//  Created by 王智鑫 on 2017/12/23.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXBindingEmailView.h"

@implementation WZXBindingEmailView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubView];
    }
    return self;
}

- (void)createSubView {
    /*
     **
     *** 邮箱下面的View
     */
    _firstView = [[UIView alloc] initWithFrame:CGRectMake(15 * IPHONE6_WIDTH, 20 * IPHONE6_HEIGHT, 345 * IPHONE6_WIDTH, 44 * IPHONE6_HEIGHT)];
    _firstView.layer.cornerRadius = 5 * IPHONE6_WIDTH;
    _firstView.clipsToBounds = YES;
    _firstView.layer.borderWidth = 1;
    _firstView.layer.borderColor = [[UIColor colorWithRed:231.0f/255.0f green:231.0f/255.0f blue:231.0f/255.0f alpha:1] CGColor];
    [self addSubview:_firstView];
    /*
     邮箱账号 */
    _emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(23 * IPHONE6_WIDTH, 16 * IPHONE6_HEIGHT, 60 * IPHONE6_WIDTH, 12 * IPHONE6_HEIGHT)];
    _emailLabel.text = @"邮箱账号";
    _emailLabel.font = [UIFont systemFontOfSize:14 * IPHONE6_WIDTH];
    [_firstView addSubview:_emailLabel];
    /*
     邮箱竖线 */
    _firsVerticalBarView = [[UIView alloc] initWithFrame:CGRectMake(93 * IPHONE6_WIDTH, 10 * IPHONE6_HEIGHT, 1 * IPHONE6_WIDTH, 24 * IPHONE6_HEIGHT)];
    _firsVerticalBarView.backgroundColor = [UIColor colorWithRed:231.0f/255.0f green:231.0f/255.0f blue:231.0f/255.0f alpha:1];
    [_firstView addSubview:_firsVerticalBarView];
    /*
     邮箱textField */
    _emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(113 * IPHONE6_WIDTH,15 * IPHONE6_HEIGHT, 200 * IPHONE6_WIDTH, 14 * IPHONE6_HEIGHT)];
    _emailTextField.clearButtonMode = UITextFieldViewModeWhileEditing;//编辑出x
    _emailTextField.placeholder = @"Please enter your mailbox";
    _emailTextField.font = [UIFont systemFontOfSize:12];
    [_emailTextField setValue:[UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _emailTextField.textColor = [UIColor blackColor];
    [_firstView addSubview:_emailTextField];
    
    
    /*
     **
     *** 验证码下面的View
     */
    _secondView = [[UIView alloc] initWithFrame:CGRectMake(15 * IPHONE6_WIDTH, 74 * IPHONE6_HEIGHT, 345 * IPHONE6_WIDTH, 44 * IPHONE6_HEIGHT)];
    _secondView.layer.cornerRadius = 5 * IPHONE6_WIDTH;
    _secondView.clipsToBounds = YES;
    _secondView.layer.borderWidth = 1;
    _secondView.layer.borderColor = [[UIColor colorWithRed:231.0f/255.0f green:231.0f/255.0f blue:231.0f/255.0f alpha:1] CGColor];
    [self addSubview:_secondView];
    /*
     验证码textField */
    _codeTextField = [[UITextField alloc] initWithFrame:CGRectMake(23 * IPHONE6_WIDTH,15 * IPHONE6_HEIGHT, 210 * IPHONE6_WIDTH, 14 * IPHONE6_HEIGHT)];
    _codeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;//编辑出x
    _codeTextField.placeholder = @"Please enter the verification code";
    _codeTextField.font = [UIFont systemFontOfSize:13];
    [_codeTextField setValue:[UIColor colorWithRed:210.0f/255.0f green:212.0f/255.0f blue:212.0f/255.0f alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _codeTextField.textColor = [UIColor blackColor];
    [_secondView addSubview:_codeTextField];
    /*
     竖线View */
    _secondVerticalBarView = [[UIView alloc] initWithFrame:CGRectMake(243 * IPHONE6_WIDTH, 10 * IPHONE6_HEIGHT, 1 * IPHONE6_WIDTH, 24 * IPHONE6_HEIGHT)];
    _secondVerticalBarView.backgroundColor = [UIColor colorWithRed:231.0f/255.0f green:231.0f/255.0f blue:231.0f/255.0f alpha:1];
    [_secondView addSubview:_secondVerticalBarView];
    /*
     获取验证码button */
    self.codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.codeButton.frame = CGRectMake(253 * IPHONE6_WIDTH, 2 * IPHONE6_HEIGHT, 85 * IPHONE6_WIDTH, 40 * IPHONE6_HEIGHT);
    [self.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.codeButton setTitleColor:REDCOLOR forState:UIControlStateNormal];
    self.codeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.codeButton.layer.cornerRadius = 5 * IPHONE6_HEIGHT;
    self.codeButton.clipsToBounds = YES;
    [_secondView addSubview:self.codeButton];
    /*
     完成按钮 */
    /* 创建推出登录button **/
    self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextBtn.frame = CGRectMake(50 * IPHONE6_WIDTH, KHEIGHT * 0.5, 275 * IPHONE6_WIDTH, 50 * IPHONE6_HEIGHT);
    self.nextBtn.backgroundColor = REDCOLOR;
    self.nextBtn.layer.cornerRadius = 22.5 * IPHONE6_WIDTH;
    [self.nextBtn setTitle:@"完成" forState:UIControlStateNormal];
    [self addSubview:self.nextBtn];
    
}





@end
