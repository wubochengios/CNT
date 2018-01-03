//
//  WZXYoungSelectTimeViewController.m
//  CNT
//
//  Created by 王智鑫 on 2017/12/6.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXYoungSelectTimeViewController.h"
#import "WZXYoungSelectTimeView.h"
#import "WZXSelectClassDetailViewController.h"
#import "WZXTimeModel.h"
@interface WZXYoungSelectTimeViewController (){
    WZXYoungSelectTimeView *selectTimeView ;
}
@property (nonatomic, strong) NSMutableDictionary  *selectTimeDic;
@end

@implementation WZXYoungSelectTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationControllerStyle];
    [self requestListUrl];
    
    
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
    self.navigationItem.title = @"选择课时";
    self.navigationController.navigationBarHidden = NO;
    //  左边返回键
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_jiantou_default"] style:UIBarButtonItemStylePlain target:self action:@selector(returnAction:)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
#pragma mark - YoungSelectTimelView
    selectTimeView = [[WZXYoungSelectTimeView alloc] initWithFrame:CGRectMake(0, 64 * IPHONE6_HEIGHT, KWIDTH, KHEIGHT)];
    selectTimeView.typeStr = self.typeStr;
    __weak typeof(*&self) weakSelf = self;
    selectTimeView.timeBlock = ^(WZXTimeModel *model, NSString *year, NSString *mouth, NSString *day) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:model forKey:@"model"];
        [dic setValue:year forKey:@"year"];
        [dic setValue:mouth forKey:@"mouth"];
        [dic setObject:day forKey:@"day"];
        if (weakSelf.SelectTimeBlock) {
            weakSelf.SelectTimeBlock(dic);
        }
        weakSelf.selectTimeDic = [NSMutableDictionary dictionaryWithDictionary:dic];

    };
    [selectTimeView.orderingBtn addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectTimeView];
    //  YoungDetailView - button 预约点击方法
    //[selectTimeView.orderingBtn addTarget:self action:@selector(orderingAction:) forControlEvents:UIControlEventTouchUpInside];
}
//1732607
//选择完时间 的确定按钮
- (void)sureAction{
    if (self.selType == selectOneToTWo) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (self.selType == selectOneToOne){
        if (_selectTimeDic == nil) {
            [MBProgressHUD showSuccess:@"请选择时间" toView:self.view];
            return;
        }
    WZXSelectClassDetailViewController *selectClassDetailVC = [[WZXSelectClassDetailViewController alloc] init];
    selectClassDetailVC.courseId = self.courseId;//跳转时候需要传递的参数
        selectClassDetailVC.teacherIdStr = self.teacherIdStr;
        selectClassDetailVC.typeStr = self.typeStr;
        selectClassDetailVC.myDataDic = self.selectTimeDic;
    [self.navigationController pushViewController:selectClassDetailVC animated:YES];
//    AFTools postWithUrl:<#(NSString *)#> andParameters:<#(NSDictionary *)#> andSuccessBlock:<#^(id responseObject)success#> andFaileBlock:<#^(NSError *error)faile#>
    }
}
- (void)setValue:(NSMutableDictionary *)dataDic{
    selectTimeView.myDataDic =dataDic;
}
- (void)requestListUrl{
    NSInteger timeInt = [WSTools getNowTimeStamp];
    NSString *year = [WSTools timeWithTimeStamp:timeInt formet:@"yyyy"];
    NSString *mouth = [WSTools timeWithTimeStamp:timeInt formet:@"MM"];
    NSString *data = [WSTools timeWithTimeStamp:timeInt formet:@"dd"];

    NSDictionary *dic = @{@"teacherId":self.teacherIdStr,
                          @"type":self.typeStr,
                          @"year":year,
                          @"month":mouth,
                          @"date":data,
                          };
    [AFTools postWithUrl:Request_Appointment_TeacherNotTimeList andParameters:dic andSuccessBlock:^(id responseObject) {
        NSLog(@"0521---%@",responseObject);
        
        if ([[responseObject objectForKey:@"code"]integerValue] == 1) {
            NSMutableDictionary *data = [responseObject objectForKey:@"data"];
            [self setValue:data];
        }
    } andFaileBlock:^(NSError *error) {
        
    }];
}
#pragma mark - 返回
- (void)returnAction:(UIButton *)returnBtn {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - YoungSelectTimeView - button 预约点击方法
//- (void)orderingAction:(UIButton *)orderingBtn {
//    //  预约跳转
//    WZXSelectClassDetailViewController *selectClassDetailVC = [[WZXSelectClassDetailViewController alloc] init];
//    selectClassDetailVC.courseId = self.courseId;
//    [self.navigationController pushViewController:selectClassDetailVC animated:YES];
//}

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
