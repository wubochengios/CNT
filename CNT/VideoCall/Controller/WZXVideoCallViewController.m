//
//  WZXVideoCallViewController.m
//  CNT
//
//  Created by 王智鑫 on 2017/12/23.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXVideoCallViewController.h"
#import "WZXVideoCallView.h"

@interface WZXVideoCallViewController ()

@end

@implementation WZXVideoCallViewController

//利用生命周期设置是否隐藏 navigationBar
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    /** 调用VideoCallView创建方法*/
    [self createVideoCallView];
}

- (void)createVideoCallView {
    WZXVideoCallView *videoCallView = [[WZXVideoCallView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT)];
    [self.view addSubview:videoCallView];
    [videoCallView.endButton addTarget:self action:@selector(endAction:) forControlEvents:UIControlEventTouchUpInside];
    [videoCallView.startButton addTarget:self action:@selector(startAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)endAction:(UIButton *)endBtn {
    
    [MBProgressHUD showSuccess:@"结束通话" toView:self.view];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)startAction:(UIButton *)startbtn {
    
    [MBProgressHUD showSuccess:@"接听通话" toView:self.view];
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
