//
//  WZXTheratingViewController.m
//  CNT
//
//  Created by 王智鑫 on 2017/12/1.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXTheratingViewController.h"
#import "WZXTheratingView.h"
#import "WZXSelectClassViewController.h"

@interface WZXTheratingViewController ()
@property (nonatomic ,strong)WZXTheratingView *theRatingView;
@end

@implementation WZXTheratingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:241.0f/255.0f green:241.0f/255.0f blue:241.0f/255.0f alpha:1];
    [self.navigationController.navigationBar setBarTintColor:REDCOLOR];//修改navigationBar颜色
    //改变NavigationItem.title 颜色
    UIFont *font = [UIFont fontWithName:@"Arial-ItalicMT" size:18 * IPHONE6_WIDTH];
    NSDictionary *dic = @{NSFontAttributeName:font,
                          NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.navigationController.navigationBar.titleTextAttributes = dic;
    self.navigationItem.title = @"外教1对1在线学汉语";
    self.navigationController.navigationBarHidden = NO;
#pragma mark - navigation 左侧返回键
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_jiantou_default"] style:UIBarButtonItemStylePlain target:self action:@selector(returnAction:)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
#pragma mark - 添加ThrratingView
    self.theRatingView = [[WZXTheratingView alloc] initWithFrame:CGRectMake(38 * IPHONE6_WIDTH, 120 * IPHONE6_HEIGHT, 299 * IPHONE6_WIDTH, 500 *IPHONE6_HEIGHT)];
    self.theRatingView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.theRatingView];
    [self.theRatingView.experienceBtn addTarget:self action:@selector(experienceAction:) forControlEvents:UIControlEventTouchUpInside];

    
}

#pragma mark - 返回
- (void)returnAction:(UIButton *)returnBtn {
   // [self.navigationController popViewControllerAnimated:YES];
    //通知
    [[NSNotificationCenter defaultCenter] postNotificationName:LoginSuccessNotification object:@"1"];
}
#pragma mark - 跳转免费体验课
- (void)experienceAction:(UIButton *)btn {
    WZXSelectClassViewController *selectClassVC = [[WZXSelectClassViewController alloc] init];
    [self.navigationController pushViewController:selectClassVC animated:YES];
    NSLog(@"跳转到免费天课选时间");
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
