//
//  WZXYoungDetailViewController.m
//  CNT
//
//  Created by 王智鑫 on 2017/12/6.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXYoungDetailViewController.h"
#import "WZXYoungDetailView.h"
#import "WZXYoungSelectClassViewController.h"
#import "WZXTeacherDetailModel.h"

@interface WZXYoungDetailViewController ()

@property (nonatomic ,strong)WZXTeacherDetailModel *model;// 数据model

@property (nonatomic ,strong)WZXYoungDetailView *detailView;//  详情View属性

@end

@implementation WZXYoungDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationControllerStyle];
}

#pragma mark -navigationBar 样式
- (void)navigationControllerStyle {
#pragma mark - 请求接口
    [self postWithUrl];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBarTintColor:REDCOLOR];//修改navigationBar颜色
    //  改变NavigationItem.title 颜色
    UIFont *font = [UIFont fontWithName:@"Arial-ItalicMT" size:18 * IPHONE6_WIDTH];
    NSDictionary *dic = @{NSFontAttributeName:font,
                          NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.navigationController.navigationBar.titleTextAttributes = dic;
    self.navigationItem.title = @"详情";
    self.navigationController.navigationBarHidden = NO;
    //  左边返回键
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_jiantou_default"] style:UIBarButtonItemStylePlain target:self action:@selector(returnAction:)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    //  右边返回键
#pragma mark - YoungDetailView
    
    self.detailView = [[WZXYoungDetailView alloc] initWithFrame:CGRectMake(0, 64 * IPHONE6_HEIGHT, KWIDTH, KHEIGHT)];
    //  YoungDetailView - button 预约点击方法
    [self.detailView.orderingBtn addTarget:self action:@selector(orderingAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.detailView];

}

- (void)postWithUrl {
//    _teacherID = @"10";
    NSString *url = [NSString stringWithFormat:@"%@",@"lucyAdmin/appointment/particularTeacher"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:_teacherID forKey:@"teacherId"];
 //   [params setObject:TOKEN forKey:@"token"];//yhy
    [params setObject:@"1" forKey:@"type"];
    [AFTools postWithUrl:url andParameters:params andSuccessBlock:^(id responseObject) {
        if ([[responseObject objectForKey:@"code"]integerValue] == 1) {
            NSMutableDictionary *dataDic = [responseObject objectForKey:@"data"];
            WZXTeacherDetailModel *dataModel = [WZXTeacherDetailModel new];
            [dataModel yy_modelSetWithJSON:dataDic];
            self.model = dataModel;
            self.detailView.model = self.model;
            [self reloadInputViews];

        }
    } andFaileBlock:^(NSError *error) {
        
    }];

}

#pragma mark - 返回
- (void)returnAction:(UIButton *)returnBtn {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - YoungDetailView - button 预约点击方法
- (void)orderingAction:(UIButton *)orderingBtn {
    //  预约并跳转页面
    WZXYoungSelectClassViewController *selectVC = [[WZXYoungSelectClassViewController alloc] init];
    selectVC.teacherID = _teacherID;
    selectVC.selectUrlTag = 1;
    selectVC.typeStr = self.typeStr;
    [self.navigationController pushViewController:selectVC animated:YES];
    
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
