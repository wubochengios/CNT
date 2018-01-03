//
//  WZXMyClassViewController.m
//  CNT
//
//  Created by 王智鑫 on 2017/12/11.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXMyClassViewController.h"
#import "WZXMyClassView.h"
#import "WZXMyClassTableViewCell.h"

@interface WZXMyClassViewController ()<UITableViewDelegate ,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *myClassTableView;
@end

@implementation WZXMyClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    [self navigationControllerStyle];
#pragma mark - myClassView 加载
    WZXMyClassView *myClassV = [[WZXMyClassView alloc] initWithFrame:CGRectMake(0, 64 * IPHONE6_HEIGHT, KWIDTH, 50 * IPHONE6_HEIGHT)];
    [self.view addSubview:myClassV];
    
}

#pragma mark -navigationBar 样式
- (void)navigationControllerStyle {
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBarTintColor:REDCOLOR];//修改navigationBar颜色
    //  改变NavigationItem.title 颜色
    UIFont *font = [UIFont fontWithName:@"Arial-ItalicMT" size:18 * IPHONE6_WIDTH];
    NSDictionary *dic = @{NSFontAttributeName:font,
                          NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.navigationController.navigationBar.titleTextAttributes = dic;
    self.navigationItem.title = @"课时查询";
    self.navigationController.navigationBarHidden = NO;
    //  左边返回键
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_jiantou_default"] style:UIBarButtonItemStylePlain target:self action:@selector(returnAction:)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
#pragma mark - 注册cell
    [self.myClassTableView registerClass:[WZXMyClassTableViewCell class] forCellReuseIdentifier:@"cell"];
}
#pragma mark - 创建tableView
- (void)createTableView {
    self.myClassTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 114 * IPHONE6_HEIGHT, KWIDTH, KHEIGHT - 114 * IPHONE6_HEIGHT) style:UITableViewStylePlain];
    self.myClassTableView.delegate = self;
    self.myClassTableView.dataSource = self;
   // self.myClassTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.myClassTableView];
}

#pragma mark - 必要的方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WZXMyClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    return cell;
   
}
#pragma mark - 每个section有几个row
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 120 * IPHONE6_HEIGHT;
}

#pragma mark - header
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.5;
}

#pragma mark - footer
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //  取消点击至灰效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - 返回
- (void)returnAction:(UIButton *)returnBtn {
    [self.navigationController popViewControllerAnimated:YES];
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
