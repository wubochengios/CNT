//
//  WZXTureOrderViewController.m
//  CNT
//
//  Created by 王智鑫 on 2017/12/12.
//  Copyright © 2017年 王智鑫. All rights reserved.
//  YHY确认订单

#import "WZXTureOrderViewController.h"
#import "WZXTrueOrderTableViewCell.h"
#import "WZXTimeModel.h"


@interface WZXTureOrderViewController ()<UITableViewDelegate ,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *tureOrderTableView;
@property (nonatomic ,strong)UIButton *orderButton;     //预约button
@property (nonatomic ,strong)UILabel *payLabel;     //支付label
@end

@implementation WZXTureOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationControllerStyle];
    [self createButton];
    [self creatTableView];
    
}
#pragma mark - 网络请求
- (void)requestUrl{
 
    if (_myDataDic == nil || _teacherIdStr.length == 0 || _typeStr.length == 0 || _courseId == nil || _presentModel == nil) {
        return;
    }
    
    NSString *yearStr = [_myDataDic objectForKey:@"year"];
    NSString *mouth = [_myDataDic objectForKey:@"mouth"];
    NSString *day = [_myDataDic objectForKey:@"day"];
    WZXTimeModel *timemodel = [_myDataDic objectForKey:@"model"];
    
    WZXSelectSmallClassModel *model = self.presentModel;
    NSDictionary *dic = @{@"teacherId":self.teacherIdStr,
                          @"courseId":@(model.courseId),
                          @"courseName":model.courseName,
                          @"price":model.price,
                          @"type":@([self.typeStr intValue]),
                          @"year":yearStr,
                          @"month":mouth,
                          @"date":day,
                          @"appointtime":timemodel.time,
                          };
    [AFTools postWithUrl:Request_OrderPayt_ConfirmAnOrder andParameters:dic andSuccessBlock:^(id responseObject) {
        if ([[responseObject objectForKey:@"code"]integerValue] == 1) {
            [MBProgressHUD showSuccess:[responseObject objectForKey:@"message"] toView:self.view];
        }else{
            [MBProgressHUD showSuccess:[responseObject objectForKey:@"message"] toView:self.view];
        }
    } andFaileBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark -navigationBar 样式
- (void)navigationControllerStyle {
    
    self.view.backgroundColor = [UIColor colorWithRed:241.0f/255.0f green:241.0f/255.0f blue:241.0f/255.0f alpha:1];
    [self.navigationController.navigationBar setBarTintColor:REDCOLOR];//修改navigationBar颜色
    //  改变NavigationItem.title 颜色
    UIFont *font = [UIFont fontWithName:@"Arial-ItalicMT" size:18 * IPHONE6_WIDTH];
    NSDictionary *dic = @{NSFontAttributeName:font,
                          NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.navigationController.navigationBar.titleTextAttributes = dic;
    self.navigationItem.title = @"确认订单";
    self.navigationController.navigationBarHidden = NO;
    //  左边返回键
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_jiantou_default"] style:UIBarButtonItemStylePlain target:self action:@selector(returnAction:)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
}

#pragma mark - Create Button
- (void)createButton {
    self.payLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 617 * IPHONE6_HEIGHT, 200 * IPHONE6_WIDTH, 50 * IPHONE6_HEIGHT)];
    self.payLabel.text = [NSString stringWithFormat:@"支付金额：¥%@",self.presentModel.price];
    self.payLabel.textAlignment = NSTextAlignmentCenter;
    self.payLabel.textColor = [UIColor lightGrayColor];
    self.payLabel.font = [UIFont systemFontOfSize:14 * IPHONE6_HEIGHT];
    [self.view addSubview:self.payLabel];
    
    self.orderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.orderButton.backgroundColor = REDCOLOR;
    self.orderButton.frame = CGRectMake(200 * IPHONE6_WIDTH, 617 * IPHONE6_HEIGHT, 175 * IPHONE6_WIDTH, 50 * IPHONE6_HEIGHT);
    [self.orderButton setTitle:@"提交订单" forState:UIControlStateNormal];
    [self.orderButton addTarget:self action:@selector(orderButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.orderButton];
}

#pragma mark - 创建tableView
- (void)creatTableView{
    self.tureOrderTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,  64, KWIDTH, 220 * IPHONE6_HEIGHT) style:UITableViewStylePlain];
    self.tureOrderTableView.delegate = self;
    self.tureOrderTableView.dataSource = self;
    self.tureOrderTableView.scrollEnabled =NO;  //不准滑动
    [self.view addSubview:self.tureOrderTableView];
    
#pragma mark - 注册cell
    [self.tureOrderTableView registerClass:[WZXTrueOrderTableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - 必要的方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WZXTrueOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    //cell.model = [self.mydataModelArray objectAtIndex:indexPath.row];
    NSArray *titleArray = [NSArray arrayWithObjects:@"课程内容",@"服务类型",@"服务方式",@"订单金额",@"单节时长", nil];
    NSString *typeStr;
    NSString *timeStr;
    if ([_typeStr isEqualToString:@"1"]) {
        typeStr = @"1对1";
        timeStr = @"25分钟";
    }else{
        typeStr = @"1对多";
        timeStr = @"45分钟";

    }
    NSArray *leftArray = [NSArray arrayWithObjects:self.presentModel.courseName,typeStr,@"语音",self.presentModel.price,timeStr, nil];
    cell.textLabel.text = [titleArray objectAtIndex:indexPath.row];
    cell.orderLabel.text = [leftArray objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - 每个section有几个row
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44 * IPHONE6_HEIGHT;
}

#pragma mark - header
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 5;
}

#pragma mark - footer
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //  取消点击至灰效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //  点击跳转详情界面
}
#pragma mark - 返回
- (void)returnAction:(UIButton *)returnBtn {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 订单 button点击方法
- (void)orderButtonAction:(UIButton *)orderButton {
    [self requestUrl];
    
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
