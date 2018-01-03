//
//  WZXRegistrationPreViewController.h
//  CNT
//
//  Created by 王智鑫 on 2017/11/28.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZXRegistrationPreViewController : UIViewController

// 第三方登陆不需要传密码
@property (nonatomic, copy) NSString *passWord;
@property (nonatomic, copy) NSString *email;
@end
