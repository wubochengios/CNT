//
//  WZXYoungSelectClassViewController.m
//  CNT
//
//  Created by 王智鑫 on 2017/12/6.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXYoungSelectClassViewController.h"
#import "WZXYoungSelectClassTableViewCell.h"
#import "WZXYoungSelectTimeViewController.h"
#import "WZXYoungSelectClassModel.h"
#import "WZXSelectClassDetailViewController.h"
#import "WZXMoreClassDetailViewController.h"

@interface WZXYoungSelectClassViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *selectClassTableView;
@property (nonatomic ,assign)NSInteger pageNum;              //分页
@property (nonatomic,strong) NSMutableArray *mydataModelArray; //model 数组
@end

@implementation WZXYoungSelectClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _mydataModelArray = [NSMutableArray new]; //model数组初始化
    [self navigationControllerStyle];
#pragma mark - 请求接口
    if (self.selectUrlTag == 1) {
        [self postWithUrl];
    }else if (self.selectUrlTag == 2) {
        [self postWithOneByOneOrOneByMoreUrl];
    }
    [self creatTableView];
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
    self.navigationItem.title = @"选择课程";
    self.navigationController.navigationBarHidden = NO;
    //  左边返回键
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_jiantou_default"] style:UIBarButtonItemStylePlain target:self action:@selector(returnAction:)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    //  右边返回键
}

#pragma mark - 创建tableView
- (void)creatTableView{
    self.selectClassTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT) style:UITableViewStylePlain];
    self.selectClassTableView.delegate = self;
    self.selectClassTableView.dataSource = self;
    self.selectClassTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.selectClassTableView];
    
#pragma mark - 注册cell
    [self.selectClassTableView registerClass:[WZXYoungSelectClassTableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)postWithUrl{
    _pageNum = 1;
    NSString *url = [NSString stringWithFormat:@"%@",@"lucyAdmin/appointment/chooseCourse"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:self.teacherID forKey:@"teacherId"];
    [params setObject:@(_pageNum) forKey:@"page"];
    [AFTools postWithUrl:url andParameters:params andSuccessBlock:^(id responseObject) {
        NSLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"code"]integerValue] == 1) {
            NSMutableDictionary *dataDic = [responseObject objectForKey:@"data"];
            NSMutableArray *dataArray = [dataDic objectForKey:@"list"];
            for (NSMutableDictionary *dataDic in dataArray) {
                WZXYoungSelectClassModel *model = [WZXYoungSelectClassModel new];
                [model yy_modelSetWithJSON:dataDic];
                [self.mydataModelArray addObject:model];
            }
            [self.selectClassTableView reloadData];
        }
        
    } andFaileBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)postWithOneByOneOrOneByMoreUrl{
    _pageNum = 1;
    NSString *url = [NSString stringWithFormat:@"%@",@"lucyAdmin/appointment/commCourse"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@(_pageNum) forKey:@"page"];
    [AFTools postWithUrl:url andParameters:params andSuccessBlock:^(id responseObject) {
        NSLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"code"]integerValue] == 1) {
            NSMutableDictionary *dataDic = [responseObject objectForKey:@"data"];
            NSMutableArray *dataArray = [dataDic objectForKey:@"list"];
            for (NSMutableDictionary *dataDic in dataArray) {
                WZXYoungSelectClassModel *model = [WZXYoungSelectClassModel new];
                [model yy_modelSetWithJSON:dataDic];
                [self.mydataModelArray addObject:model];
            }
            [self.selectClassTableView reloadData];
        }
        
    } andFaileBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

#pragma mark - 必要的方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WZXYoungSelectClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = [self.mydataModelArray objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - 每个section有几个row
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.mydataModelArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 106 * IPHONE6_HEIGHT;
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
    //yhy修改
    WZXYoungSelectClassModel *model = _mydataModelArray[indexPath.row];

    //  取消点击至灰效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selectUrlTag == 1) {
        //  点击跳转详情界面
        WZXYoungSelectTimeViewController *timeVC = [[WZXYoungSelectTimeViewController alloc] init];
        timeVC.teacherIdStr = self.teacherID;//yhy
        timeVC.selType = selectOneToOne;
        timeVC.courseId = model.courseId;
        timeVC.typeStr = self.typeStr;
        [self.navigationController pushViewController:timeVC animated:YES];
    }else if (self.selectUrlTag == 2) {
        WZXMoreClassDetailViewController *moreVC = [[WZXMoreClassDetailViewController alloc] init];
        moreVC.courseIdInt = model.courseId;
        moreVC.typeStr = self.typeStr;
        moreVC.categoryIdInt = model.categoryId;
        [self.navigationController pushViewController:moreVC animated:YES];
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
