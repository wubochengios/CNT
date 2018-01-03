//
//  WZXClassTimeViewController.m
//  CNT
//
//  Created by 王智鑫 on 2017/11/17.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXClassTimeViewController.h"
#import "CBHeaderChooseViewScrollView.h"
#import "WZXClassTimeTableViewCell.h"


@interface WZXClassTimeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *classTimeTableView;
@end

@implementation WZXClassTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNavigationBarStyle];
    // 滑动日期选择器创建
    [self createSliderControl];
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
    self.navigationItem.title = @"我的课表";
    //改变NavigationItem左侧
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_jiantou_default"] style:UIBarButtonItemStylePlain target:self action:@selector(returnAction:)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    //改变NavigationItem右侧
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"课程安排" style:UIBarButtonItemStylePlain target:self action:@selector(clickSaveBtn)];
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
    self.classTimeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40 * IPHONE6_HEIGHT, KWIDTH, KHEIGHT - 40 * IPHONE6_HEIGHT) style:UITableViewStylePlain];
    self.classTimeTableView.backgroundColor = [UIColor whiteColor];
    self.classTimeTableView.delegate = self;
    self.classTimeTableView.dataSource = self;
    //self.dreamTableView.scrollEnabled = NO;
    [self.view addSubview:self.classTimeTableView];
#pragma mark - 注册cell
    [self.classTimeTableView registerClass:[WZXClassTimeTableViewCell class] forCellReuseIdentifier:@"cell"];
    
}
#pragma mark - 必要的方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WZXClassTimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    return cell;
}

#pragma mark - 每个section有几个row
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5 * IPHONE6_HEIGHT;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 90 * AUTO_HEIGHT;
}

#pragma mark - header
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 45 * AUTO_HEIGHT;
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    [headerView setBackgroundColor:[UIColor colorWithRed:241.0f/255.0f green:241.0f/255.0f blue:241.0f/255.0f alpha:1]];
    
#pragma mark - 给section头添加label显示时间
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, tableView.frame.size.width, 20)];
    label.font = [UIFont systemFontOfSize:15.0f];  //UILabel的字体大小
    label.textAlignment = NSTextAlignmentLeft;  //文本对齐方式
    label.text = @"今天";
    [headerView addSubview:label];
    return headerView;
}

#pragma mark - cell点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //取消点击至灰效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)createSliderControl {
    
    NSArray *array=@[
                     @"10/16～10/22",
                     @"10/23～10/29",
                     @"10/30～11/05",
                     @"11/06～11/12",
                     @"11/13～11/19",
                     @"11/20～11／26",
                     @"11／28～12/02",
                     @"12/03～12/09",
                     @"12/10～12/16"
                     ];
    
    CBHeaderChooseViewScrollView*headerView=[[CBHeaderChooseViewScrollView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, 40)];
    
    [self.view addSubview:headerView];
    
    [headerView setUpTitleArray:array titleColor:nil titleSelectedColor:nil titleFontSize:0];
    
    headerView.btnChooseClickReturn = ^(NSInteger x) {
        
        switch (x) {
            case 0:
                self.view.backgroundColor = [UIColor whiteColor];
                break;
                
            case 1:
                self.view.backgroundColor = [UIColor redColor];
                
                break;
            case 2:
                self.view.backgroundColor = [UIColor blueColor];
                
                break;
            default:
                break;
        }
        NSLog(@"点击了第%ld个按钮",x+1);
    };
    
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
