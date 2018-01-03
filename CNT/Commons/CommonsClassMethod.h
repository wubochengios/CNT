//
//  CommonsClassMethod.h
//  CNT
//
//  Created by YHY on 2017/12/11.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^LoginSuccessBackBlock)(void);
@interface CommonsClassMethod : NSObject
@property (nonatomic,copy) LoginSuccessBackBlock loginSuccessBackBlock;


/** 跳转到登陆页面去登陆 */
+ (void)pushLoginViewControllerToLoginWithController:(UIViewController *)controller successBlock:(LoginSuccessBackBlock)block;
/**一去不复返-到首页*/
+ (void)pushLoginViewController;
@end
