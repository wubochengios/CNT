//
//  WZXOneByMoreViewController.m
//  CNT
//
//  Created by 王智鑫 on 2017/11/15.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXOneByMoreViewController.h"
#import "WZXOneByMoreTableViewCell.h"

@interface WZXOneByMoreViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UITableView *OneByMoreTableView;

@end

@implementation WZXOneByMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatTableView];
}

#pragma mark - 创建tableView
- (void)creatTableView{
    
    self.OneByMoreTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT * 0.6) style:UITableViewStylePlain];
    self.OneByMoreTableView.delegate = self;
    self.OneByMoreTableView.dataSource = self;
    [self.view addSubview:self.OneByMoreTableView];
    
    
#pragma mark - 注册cell
    [self.OneByMoreTableView registerClass:[WZXOneByMoreTableViewCell class] forCellReuseIdentifier:@"moreCell"];
    
}




#pragma mark - 必要的方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WZXOneByMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"moreCell"];
    
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 140 * IPHONE6_HEIGHT;
}
#pragma mark - 分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
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
