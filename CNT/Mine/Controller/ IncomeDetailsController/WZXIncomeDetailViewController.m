//
//  WZXIncomeDetailViewController.m
//  CNT
//
//  Created by 王智鑫 on 2017/11/17.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXIncomeDetailViewController.h"
#import "WZXIncomeDetailTableViewCell.h"

@interface WZXIncomeDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UITableView *incomeTableView;

@end

@implementation WZXIncomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNavigationBarStyle];
    //  创建tableView
    [self createTableView];
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
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(clickSaveBtn)];
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

#pragma mark - 创建tableView
- (void)createTableView {
    self.incomeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT) style:UITableViewStylePlain];
    self.incomeTableView.backgroundColor = [UIColor whiteColor];
    self.incomeTableView.delegate = self;
    self.incomeTableView.dataSource = self;
    //self.dreamTableView.scrollEnabled = NO;
    [self.view addSubview:self.incomeTableView];
#pragma mark - 注册cell
    [self.incomeTableView registerClass:[WZXIncomeDetailTableViewCell class] forCellReuseIdentifier:@"cell"];
    
}
#pragma mark - 必要的方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WZXIncomeDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    return cell;
}

#pragma mark - 每个section有几个row
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 90 * AUTO_HEIGHT;
}

#pragma mark - header
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 30 * AUTO_HEIGHT;
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30 * IPHONE6_HEIGHT)];
    [headerView setBackgroundColor:[UIColor colorWithRed:241.0f/255.0f green:241.0f/255.0f blue:241.0f/255.0f alpha:1]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 * IPHONE6_WIDTH, 5 * IPHONE6_HEIGHT, 200 * IPHONE6_WIDTH, 20 * IPHONE6_HEIGHT)];
    label.font = [UIFont systemFontOfSize:15.0f * IPHONE6_HEIGHT];  //UILabel的字体大小
    label.textAlignment = NSTextAlignmentLeft;  //文本对齐方式
    label.text = @"本月账单";
    [headerView addSubview:label];
    
    UILabel *monthlabel = [[UILabel alloc] initWithFrame:CGRectMake(280 * IPHONE6_WIDTH, 3 * IPHONE6_HEIGHT, 65 * IPHONE6_WIDTH, 20 * IPHONE6_HEIGHT)];
    monthlabel.font = [UIFont systemFontOfSize:12 * IPHONE6_HEIGHT];  //UILabel的字体大小
    monthlabel.textAlignment = NSTextAlignmentLeft;  //文本对齐方式
    monthlabel.textColor = [UIColor grayColor];
    monthlabel.text = @"查看月账单";
    [headerView addSubview:monthlabel];
    
    UIImage *image = [UIImage imageNamed:@"content_icon_jiantou_default"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(345 * IPHONE6_WIDTH, 8 * IPHONE6_HEIGHT, 5 * IPHONE6_WIDTH, 10 * IPHONE6_HEIGHT);
    [headerView addSubview:imageView];

    return headerView;
}

#pragma mark - cell点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //取消点击至灰效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
