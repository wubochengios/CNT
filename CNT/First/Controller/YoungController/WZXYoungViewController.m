//
//  WZXYoungViewController.m
//  CNT
//
//  Created by 王智鑫 on 2017/12/6.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXYoungViewController.h"
#import "WZXYoungTableViewCell.h"
#import "WZXYoungheadView.h"
#import "WZXYoungDetailViewController.h"
#import "WZXYoungModel.h"
#import "TopMenuView.h"

@interface WZXYoungViewController ()<UITableViewDelegate,UITableViewDataSource>{
    WZXYoungheadView *headView;
}

@property (nonatomic ,strong)UITableView *youngTableView;
@property (nonatomic ,strong)WZXYoungModel  *myModel;
@property (nonatomic, strong) TopMenuView *topMenuView;
@property (nonatomic, assign)NSInteger  sort;
@property (nonatomic, assign)NSInteger selectCategoryId;
@property (nonatomic, strong) NSMutableArray *dataListArray;
@property (nonatomic, assign) NSInteger page;
@end

@implementation WZXYoungViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataListArray = [NSMutableArray array];

    _selectCategoryId = self.cateoryID;
    self.sort = 1;//1是默认随机排
    _myModel = [WZXYoungModel new];
    for (WZXYoungModel *model in _myDataArray) {
        if (model.categoryId == (long)self.cateoryID) {
            _myModel = model;
        }
    }
    
    [self creatTableView];              //tableView 方法调用
    [self navigationControllerStyle];   //navigation 样式方法调用
    
    //筛选
    _topMenuView = [[TopMenuView alloc]initWithFrame:CGRectMake(0, 64, KWIDTH, 40) menuTitleArray:@[_myModel.categoryName,@"评分",@"时间",@"价格"]];
    _topMenuView.menuDataArray = _myDataArray;
    _topMenuView.layer.borderWidth = 0.5;
    [self.view addSubview:_topMenuView];
    _topMenuView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    __weak typeof(self)weakSelf = self;
    _topMenuView.handleSelectBlock = ^(WZXYoungModel *model) {
        NSLog(@"%@",model);
        weakSelf.selectCategoryId = model.categoryId;
        [weakSelf.youngTableView.mj_header beginRefreshing];
        //给头视图赋值
        [weakSelf setHeadView:model];
    };
    //返回字段生序是1
    _topMenuView.lesson_sortBlock = ^(NSInteger selectInt, NSString *object) {
        /*
         1是默认随机排
         2表示按老师的评分升序排序
         3是按老师的评分降序排序
         4是按时间升序排序
         5是按时间降序排序
         */
        NSLog(@"%ld--------%@",selectInt,object);
        //生序是1
        if ([object isEqualToString:@"评分"]) {
            if (selectInt == 1) {
                weakSelf.sort = 2;
            }else{
                weakSelf.sort = 3;
            }
        }else if ([object isEqualToString:@"时间"]){
            if (selectInt == 1) {
                weakSelf.sort = 4;
            }else{
                weakSelf.sort = 5;
            }
        }
        [weakSelf.youngTableView.mj_header beginRefreshing];

    };

    //yhy
   self.youngTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    self.youngTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [self.youngTableView.mj_header beginRefreshing];

}
- (void)loadMoreData{
    self.page ++;
    [self requestList];
}
- (void)loadNewData{
    self.page = 1;
    [self requestList];
}
#pragma mark - 数据请求
- (void)requestList{
    NSString *urlString = [NSString stringWithFormat:@"%@",Request_Appointment_TeacherList];
    NSString *sortStr = [NSString stringWithFormat:@"%ld",self.sort];
    NSDictionary *dic = @{@"type":self.type,
                          @"sort":sortStr,
                          @"categoryId":@(self.selectCategoryId),
                          @"page":@(self.page),
                          };
    
    __weak typeof(self)weakSelf = self;
    [AFTools postWithUrl:urlString andParameters:dic andSuccessBlock:^(id responseObject) {
        NSLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"code"]integerValue] == 1) {
            NSDictionary *dataDic = [responseObject objectForKey:@"data"];
            NSMutableArray *dataArr = [dataDic objectForKey:@"list"];
            if (_page == 1) {
                [weakSelf.dataListArray removeAllObjects];
            }
            NSMutableArray *array = [NSMutableArray array];
            for (NSMutableDictionary *dataDic in dataArr) {
                WZXYoungModel *model = [WZXYoungModel new];
                [model yy_modelSetWithJSON:dataDic];
                [array addObject:model];
            }
            [weakSelf.dataListArray addObjectsFromArray:array];

            [weakSelf.youngTableView reloadData];
        }
        [weakSelf.youngTableView.mj_header endRefreshing];
        [weakSelf.youngTableView.mj_footer endRefreshing];
        
    } andFaileBlock:^(NSError *error) {
        [weakSelf.youngTableView.mj_header endRefreshing];
        [weakSelf.youngTableView.mj_footer endRefreshing];
    }];
}
#pragma mark -navigationBar 样式
- (void)navigationControllerStyle {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBarTintColor:REDCOLOR];//修改navigationBar颜色
    //改变NavigationItem.title 颜色
    UIFont *font = [UIFont fontWithName:@"Arial-ItalicMT" size:18 * IPHONE6_WIDTH];
    NSDictionary *dic = @{NSFontAttributeName:font,
                          NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.navigationController.navigationBar.titleTextAttributes = dic;
    self.navigationItem.title = @"选课中心";
    self.navigationController.navigationBarHidden = NO;
    //左边返回键
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_jiantou_default"] style:UIBarButtonItemStylePlain target:self action:@selector(returnAction:)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
}

#pragma mark - 创建tableView
- (void)creatTableView{
    //yhy 修改frame
    self.youngTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 86 * IPHONE6_HEIGHT, KWIDTH, KHEIGHT - 106 * IPHONE6_HEIGHT) style:UITableViewStylePlain];
    self.youngTableView.delegate = self;
    self.youngTableView.dataSource = self;
    [self.view addSubview:self.youngTableView];
    
#pragma mark - 头视图初始化
    headView = [[WZXYoungheadView alloc] initWithFrame:CGRectMake(0, 64 * IPHONE6_HEIGHT, KWIDTH, 235 * IPHONE6_HEIGHT)];
    /** 下拉菜单按钮 */
    headView.model = _myModel;
    _youngTableView.tableHeaderView = headView;
}
- (void)setHeadView:(WZXYoungModel*)model{
    headView.model = model;
}

#pragma mark - 必要的方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", [indexPath section], [indexPath row]];
    WZXYoungTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[WZXYoungTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    WZXYoungModel *model = _dataListArray[indexPath.row];
    cell.myModel = model;
    return cell;
}

#pragma mark - 每个section有几个row
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataListArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 64;
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
    //  点击跳转详情界面
    WZXYoungDetailViewController *detailVC = [[WZXYoungDetailViewController alloc] init];
    WZXYoungModel *model = _dataListArray[indexPath.row];
    detailVC.teacherID = [NSString stringWithFormat:@"%ld",model.tId];
    detailVC.typeStr = self.type;
    [self.navigationController pushViewController:detailVC animated:YES];

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
