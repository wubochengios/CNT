//
//  BasicNavigationController.m
//  CNT
//
//  Created by mac on 2017/12/11.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "BasicNavigationController.h"

@interface BasicNavigationController ()<UINavigationControllerDelegate>

@end

@implementation BasicNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [navigationController.navigationBar setBarTintColor:REDCOLOR];
    viewController.view.backgroundColor = [UIColor whiteColor];
    
    // 改变navigationItem.title 样式
    UIFont *font = [UIFont fontWithName:@"Arial-ItalicMT" size:18];
    navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:font, NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    // 改变左侧navigationItem
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_jiantou_default"] style:UIBarButtonItemStylePlain target:self action:@selector(returnAction:)];
    viewController.navigationItem.leftBarButtonItem = leftBarItem;
    viewController.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    // 回收键盘
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [viewController.view addGestureRecognizer:singleTap];
}

- (void)returnAction:(UIButton *)returnBtn {
    [self popViewControllerAnimated:YES];
}

#pragma mark - 回收键盘
- (void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer {
    [self.view endEditing:YES];
}

@end
