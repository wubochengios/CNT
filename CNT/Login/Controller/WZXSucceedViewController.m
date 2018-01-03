//
//  WZXSucceedViewController.m
//  CNT
//
//  Created by 王智鑫 on 2017/11/9.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXSucceedViewController.h"
#import "WZXSucceedView.h"

@interface WZXSucceedViewController ()

//Return
@property (nonatomic ,strong)UIButton *backBtn;

@end

@implementation WZXSucceedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    WZXSucceedView *succeedV = [[WZXSucceedView alloc] init];
    succeedV.frame = CGRectMake(0, 0, KWIDTH, KHEIGHT);
    [self.view addSubview:succeedV];
    
#pragma mark - 返回键子
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(10, 35, 60, 16);
    self.backBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.backBtn setTitle:@"Return" forState:UIControlStateNormal];
    [self.backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.backBtn.layer.cornerRadius = 8;
    self.backBtn.clipsToBounds = YES;
    self.backBtn.backgroundColor = [UIColor colorWithRed:255.0f/255.9f green:91.0f/255 blue:95.0f/255 alpha:0.46];
    [self.backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.backBtn];

}
#pragma mark - 模态返回
- (void)backAction:(UIButton *)backBtn {
    
    [self dismissViewControllerAnimated:YES completion:NULL];
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
