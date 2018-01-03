//
//  WZXSelectClassDetailViewController.m
//  CNT
//
//  Created by 王智鑫 on 2017/12/7.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXSelectClassDetailViewController.h"
#import "WZXSelectClassDetailTableViewCell.h"
#import "WZXSelectSmallClassModel.h"
#import "WZXTureOrderViewController.h"
#import "WZXSelectSmallClassModel.h"

@interface WZXSelectClassDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *selectClassTableView;
@property (nonatomic ,strong)UIButton *serviceButton;   //客服button
@property (nonatomic ,strong)UIButton *orderButton;     //预约button
@property (nonatomic ,assign)NSInteger page;              //分页
@property (nonatomic,strong) NSMutableArray *mydataModelArray; //model 数组
@property (nonatomic, strong) NSMutableArray *didSelectArray;
@end

@implementation WZXSelectClassDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    _mydataModelArray = [NSMutableArray new]; //model数组初始化
    [self navigationControllerStyle];
    [self postWithUrl];     //请求接口
    [self creatTableView];
    [self createButton];
    _didSelectArray = [NSMutableArray array];
    self.selectClassTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    self.selectClassTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [self.selectClassTableView.mj_header beginRefreshing];
    
}
- (void)loadMoreData{
    self.page ++;
    [self postWithUrl];
}
- (void)loadNewData{
    self.page = 1;
    [self postWithUrl];
}

#pragma mark - Create Button
- (void)createButton {
    self.serviceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.serviceButton.backgroundColor = [UIColor whiteColor];
    [self.serviceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.serviceButton.frame = CGRectMake(0, 617 * IPHONE6_WIDTH, KWIDTH/2, 50 * IPHONE6_WIDTH);
    [self.serviceButton setImage:[UIImage imageNamed:@"tab_cust_default"] forState:UIControlStateNormal];
    [self.serviceButton setTitle:@"咨询客服" forState:UIControlStateNormal];
    [self.serviceButton addTarget:self action:@selector(serviceButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.serviceButton];
    
    self.orderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.orderButton.backgroundColor = REDCOLOR;
    self.orderButton.frame = CGRectMake(KWIDTH/2, 617 * IPHONE6_WIDTH, KWIDTH/2, 50 * IPHONE6_WIDTH);
    [self.orderButton setTitle:@"立即预约" forState:UIControlStateNormal];
    [self.orderButton addTarget:self action:@selector(orderButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.orderButton];
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
    self.navigationItem.title = @"选择课程";
    self.navigationController.navigationBarHidden = NO;
    //  左边返回键
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_jiantou_default"] style:UIBarButtonItemStylePlain target:self action:@selector(returnAction:)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
}
#pragma mark -获取列表Url
- (void)postWithUrl {
    NSString *url = [NSString stringWithFormat:@"%@",@"lucyAdmin/appointment/chooseCourseSon"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@(self.page) forKey:@"page"];
    [params setObject:[NSString stringWithFormat:@"%ld",_courseId] forKey:@"courseId"];
    [AFTools postWithUrl:url andParameters:params andSuccessBlock:^(id responseObject) {

        if ([[responseObject objectForKey:@"code"]integerValue] == 1) {
            if (self.page == 1) {
                [self.mydataModelArray removeAllObjects];
            }
            NSMutableDictionary *dataDic = [responseObject objectForKey:@"data"];
            NSMutableArray *dataArray = [dataDic objectForKey:@"list"];
            NSMutableArray *array = [NSMutableArray array];
            for (NSMutableDictionary *dataDic in dataArray) {
                WZXSelectSmallClassModel *model = [WZXSelectSmallClassModel new];
                [model yy_modelSetWithJSON:dataDic];
                [array addObject:model];
            }
            [self.mydataModelArray addObjectsFromArray:array];
            [self.selectClassTableView reloadData];
        }else{
            [MBProgressHUD showSuccess:[responseObject objectForKey:@"message"] toView:self.view];
        }
        [self.selectClassTableView.mj_header endRefreshing];
        [self.selectClassTableView.mj_footer endRefreshing];
    } andFaileBlock:^(NSError *error) {
        NSLog(@"%@",error);
        [self.selectClassTableView.mj_header endRefreshing];
        [self.selectClassTableView.mj_footer endRefreshing];
    }];
    
}

#pragma mark - 创建tableView
- (void)creatTableView{
    self.selectClassTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT) style:UITableViewStylePlain];
    self.selectClassTableView.delegate = self;
    self.selectClassTableView.dataSource = self;
    [self.view addSubview:self.selectClassTableView];
    
#pragma mark - 注册cell
    [self.selectClassTableView registerClass:[WZXSelectClassDetailTableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - 必要的方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WZXSelectClassDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    WZXSelectSmallClassModel *mymodel = [self.mydataModelArray objectAtIndex:indexPath.row];
    cell.model = mymodel;
    if ([_didSelectArray containsObject:mymodel] ) {
        [cell setSelectChangeColor:YES];
    }else{
        [cell setSelectChangeColor:NO];
        
    }
    return cell;
}

#pragma mark - 每个section有几个row
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _mydataModelArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
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
    WZXSelectSmallClassModel *model = self.mydataModelArray[indexPath.row];
    [_didSelectArray removeAllObjects];
    if ([_didSelectArray isEqual:model]) {
        
    }else{
        [_didSelectArray addObject:model];
    }
    [_selectClassTableView reloadData];
}

#pragma mark - 返回
- (void)returnAction:(UIButton *)returnBtn {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 客服and预约 button点击方法
- (void)serviceButtonAction:(UIButton *)serviceButton {
    
    
}

- (void)orderButtonAction:(UIButton *)orderButton {
    if (self.didSelectArray.count == 0) {
        [MBProgressHUD showSuccess:@"请选择课程" toView:self.view];
        return;
    }
    WZXTureOrderViewController *tureVC = [[WZXTureOrderViewController alloc] init];
    WZXSelectSmallClassModel *model = self.didSelectArray[0];
    tureVC.teacherIdStr = self.teacherIdStr;
    tureVC.typeStr =self.typeStr;
    tureVC.courseId = self.courseId;
    tureVC.myDataDic = self.myDataDic;
    tureVC.presentModel = model;
    [self.navigationController pushViewController:tureVC animated:YES];
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
