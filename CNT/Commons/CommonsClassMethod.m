//
//  CommonsClassMethod.m
//  CNT
//
//  Created by YHY on 2017/12/11.
//  Copyright © 2017年 王智鑫. All rights reserved.
//
/** 一些共用的类方法 */
#import "CommonsClassMethod.h"
#import "LoginViewController.h"
#import "BasicNavigationController.h"

@implementation CommonsClassMethod

static CommonsClassMethod *shareClassMethod = nil;
+ (CommonsClassMethod *)shareClassMethod{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareClassMethod = [[CommonsClassMethod alloc]init];
    });
    return shareClassMethod;
}

#pragma mark - 跳转到登陆页面去登陆
/** 跳转到登陆页面去登陆登入成功后会返回当前页面 */
+ (void)pushLoginViewControllerToLoginWithController:(UIViewController *)controller successBlock:(LoginSuccessBackBlock)block{
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    BasicNavigationController *navi = [[BasicNavigationController alloc]initWithRootViewController:loginVC];
    [controller presentViewController:navi animated:YES completion:nil];
    if (block) {
        [CommonsClassMethod shareClassMethod].loginSuccessBackBlock = block;
    }
}
/**一去不复返*/
+ (void)pushLoginViewController{
    [[NSNotificationCenter defaultCenter] postNotificationName:LoginSuccessNotification object:@"1"];

    LoginViewController *loginVC = [[LoginViewController alloc] init];
    BasicNavigationController *navi = [[BasicNavigationController alloc]initWithRootViewController:loginVC];
    [navi popToRootViewControllerAnimated:YES];
     [UIApplication sharedApplication].keyWindow.rootViewController = navi;
    
}
@end
