//
//  WZXSetViewController.m
//  CNT
//
//  Created by 王智鑫 on 2017/11/14.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXSetViewController.h"
#import "WZXSetTableViewCell.h"
#import "UIImageView+WebCache.h"


@interface WZXSetViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *setTableView;
@property (nonatomic ,strong) UIButton *outLogin;
@property (nonatomic ,assign)float cacheSize;
@end

@implementation WZXSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatTableView];
#pragma mark - navigation 左侧返回键
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_jiantou_default"] style:UIBarButtonItemStylePlain target:self action:@selector(returnAction:)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
}
#pragma mark - navigation 左侧返回键点击时间
- (void)returnAction:(UIButton *)returnBtn {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 创建tableView
- (void)creatTableView{
    
    self.setTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT * 0.6) style:UITableViewStylePlain];
    self.setTableView.delegate = self;
    self.setTableView.dataSource = self;
    self.setTableView.scrollEnabled = NO;
    [self.view addSubview:self.setTableView];
    
#pragma mark - 注册cell
    [self.setTableView registerClass:[WZXSetTableViewCell class] forCellReuseIdentifier:@"setCell"];
    /* 创建推出登录button **/
    self.outLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    self.outLogin.frame = CGRectMake(20 * IPHONE6_WIDTH, KHEIGHT * 0.65, 335 * IPHONE6_WIDTH, 50 * IPHONE6_HEIGHT);
    self.outLogin.backgroundColor = REDCOLOR;
    self.outLogin.layer.cornerRadius = 10 * IPHONE6_WIDTH;
    [self.outLogin setTitle:@"退出登录" forState:UIControlStateNormal];
    [self.outLogin addTarget:self action:@selector(outLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.outLogin];
}

#pragma mark - 退出登录
- (void)outLoginAction:(UIButton *)outLoginBtn {
    
    NSLog(@"退出登录");
    [WSTools removeInfoObject:TokenKey];
    //第二种:直接跳到登入,但登入后会直接跳到首页
    [CommonsClassMethod pushLoginViewController];
}

#pragma mark - 必要的方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WZXSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setCell"];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    /* 我的界面里的title数组 */
    NSArray *titleArray = [NSArray arrayWithObjects:@"个人资料",@"设置密码",@"设置提醒",@"意见反馈",@"关于华说",@"清除缓存",@"检查更新",nil];

    if (indexPath.row == 0) {
        
        cell.textLabel.text = [titleArray objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }else if(indexPath.row == 1) {
        
        cell.textLabel.text = [titleArray objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }else if (indexPath.row == 2) {
        
        cell.textLabel.text = [titleArray objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }else if (indexPath.row == 3) {
        
        cell.textLabel.text = [titleArray objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }else if (indexPath.row == 4) {
        
        cell.textLabel.text = [titleArray objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }else if (indexPath.row == 5) {
        
        cell.textLabel.text = [titleArray objectAtIndex:indexPath.row];
        /* cell里的label */
        UILabel *hardWareLabel = [[UILabel alloc] initWithFrame:CGRectMake(250 * AUTO_WIDTH, 10 * AUTO_HEIGHT, 135 * AUTO_WIDTH, 30 * AUTO_HEIGHT)];
        hardWareLabel.font = [UIFont systemFontOfSize:14];
        hardWareLabel.text = [NSString stringWithFormat:@"%.2fMB",_cacheSize];
        hardWareLabel.textColor = [UIColor grayColor];
        hardWareLabel.textAlignment = NSTextAlignmentRight;
        [cell addSubview:hardWareLabel];
        
    }else if (indexPath.row == 6) {
        
        cell.textLabel.text = [titleArray objectAtIndex:indexPath.row];
        /* cell里的label */
        UILabel *hardWareLabel = [[UILabel alloc] initWithFrame:CGRectMake(250 * AUTO_WIDTH, 10 * AUTO_HEIGHT, 135 * AUTO_WIDTH, 30 * AUTO_HEIGHT)];
        hardWareLabel.font = [UIFont systemFontOfSize:14];
        hardWareLabel.text = @"1.0.00";
        hardWareLabel.textColor = [UIColor grayColor];
        hardWareLabel.textAlignment = NSTextAlignmentRight;
        [cell addSubview:hardWareLabel];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44 * IPHONE6_HEIGHT;
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
    
    if (indexPath.row == 5) {
        
#pragma mark - 清除缓存 - 创建UIAlertController
        
        NSUInteger size = [[SDImageCache sharedImageCache] getSize];
        self.cacheSize = size / 1024.0 / 1024.0;
        //提示框
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"缓存:%.2fMB",self.cacheSize] preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertC animated:YES completion:^{
            
            
        }];
        
        //创建确认按钮
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //图片缓存清理
            //[[SDImageCache sharedImageCache] cleanDisk];
            [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                
                
            }];
            
            NSLog(@"缓存大小为%.2f",self.cacheSize);
            //[[SDImageCache sharedImageCache]clearDisk];
            [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                
                
            }];
            
        }];
        //将按钮放在提示框上
        [alertC addAction:action];
        
        //创建取消按钮
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
        }];
        [alertC addAction:action2];
    }
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
