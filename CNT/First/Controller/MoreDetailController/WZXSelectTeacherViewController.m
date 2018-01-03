//
//  WZXSelectTeacherViewController.m
//  CNT
//
//  Created by YHY on 2017/12/11.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXSelectTeacherViewController.h"
#import "WZXYoungTableViewCell.h"

@interface WZXSelectTeacherViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *dataListArray;

@end

@implementation WZXSelectTeacherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataListArray = [NSMutableArray array];
    self.page = 1;
    // Do any additional setup after loading the view from its nib.
    [self navigationControllerStyle];
    [self requestList];
    [self.tableView registerClass:[WZXYoungTableViewCell class] forCellReuseIdentifier:@"WZXYoungTableViewCell"];

    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [self.tableView.mj_header beginRefreshing];
    
}
- (void)loadMoreData{
    self.page ++;
    [self requestList];
}
- (void)loadNewData{
    self.page = 1;
    [self requestList];
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
    self.navigationItem.title = @"选择老师";
    self.navigationController.navigationBarHidden = NO;
    //  左边返回键
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_jiantou_default"] style:UIBarButtonItemStylePlain target:self action:@selector(returnAction:)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
}
#pragma mark - 数据请求
- (void)requestList{
    NSString *urlString = [NSString stringWithFormat:@"%@",Request_Appointment_TeacherList];
    NSDictionary *dic = @{@"type":self.typeStr,
                          @"categoryId":@(self.categoryIdInt),
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
            
            [weakSelf.tableView reloadData];
        }
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        
    } andFaileBlock:^(NSError *error) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WZXYoungTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WZXYoungTableViewCell"];
    cell.myModel = _dataListArray[indexPath.row];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataListArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64 * IPHONE6_HEIGHT;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WZXYoungModel *model = _dataListArray[indexPath.row];
    [self.navigationController popViewControllerAnimated:YES];
    if (_selectTeacherBlock) {
        _selectTeacherBlock(model);
    }
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


