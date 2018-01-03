//
//  WZXRechargeViewController.m
//  CNT
//
//  Created by 王智鑫 on 2017/11/21.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXRechargeViewController.h"
#import "WZXRechargeView.h"
@interface WZXRechargeViewController ()

@property (nonatomic ,strong)WZXRechargeView *rechargeV;

@end

@implementation WZXRechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
#pragma mark - rechargeView 初始化
    self.rechargeV = [[WZXRechargeView alloc] initWithFrame:CGRectMake(0, 0, IPHONE6_WIDTH, IPHONE6_HEIGHT)];
    [self.view addSubview:self.rechargeV];
    [self createNavigationBarStyle];
}

#pragma mark - NavigationBar
- (void)createNavigationBarStyle {
    //改变NavigationItem.title 颜色
    UIFont *font = [UIFont fontWithName:@"Arial-ItalicMT" size:18];
    NSDictionary *dic = @{NSFontAttributeName:font,
                          NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.navigationController.navigationBar.titleTextAttributes =dic;
    self.navigationItem.title = @"收入详情";
    //改变NavigationItem左侧
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_jiantou_default"] style:UIBarButtonItemStylePlain target:self action:@selector(returnAction:)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    //改变NavigationItem右侧
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"充值记录" style:UIBarButtonItemStylePlain target:self action:@selector(clickSaveBtn)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    

    
}

#pragma mark - navigation 左侧返回键点击
- (void)returnAction:(UIButton *)returnBtn {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - navigation 右侧课程安排点击
- (void)clickSaveBtn {
    NSLog(@"保存");
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
