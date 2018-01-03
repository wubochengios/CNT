//
//  WZXMoreClassDetailViewController.m
//  CNT
//
//  Created by 王智鑫 on 2017/12/9.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXMoreClassDetailViewController.h"
#import "WZXMoreImageView.h"
#import "WZXMoreFirstViewController.h"
#import "WZXMoreSecondViewController.h"
//cell头文件
#import "WZXOutlineFirstTableViewCell.h"
#import "WZXOutlineSecondTableViewCell.h"
#import "WZXOutlineThirdTableViewCell.h"
#import "WZXInformationTableViewCell.h"
#import "WZXSelectTeacherViewController.h"
#import "WZXCourseMessageModel.h"
#import "WZXSelectSmallClassModel.h"
#import "WZXYoungSelectTimeViewController.h"
#import "WZXTimeModel.h"
#import "WZXTureOrderViewController.h"

@interface WZXMoreClassDetailViewController ()<UITableViewDelegate ,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *classDetailTableView;
/**切换按钮传真*/
@property (nonatomic ,assign)NSInteger buttonTypeInt;
@property (nonatomic, strong) WZXCourseMessageModel *dataModel;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong)NSMutableArray *didSeletArray;
@property (nonatomic, assign)NSInteger pageNum;
@property (nonatomic, strong)NSMutableArray *mydataModelArray;

@property (nonatomic,strong)NSString *teacherIdStr;

@property (nonatomic,strong)NSMutableDictionary *selectTimeDic;//全局赋值
@property (nonatomic,strong)WZXYoungModel *teacherModel;
@end

@implementation WZXMoreClassDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _didSeletArray = [NSMutableArray array];
    _mydataModelArray = [NSMutableArray array];
    _pageNum = 1;
    _buttonTypeInt = 1;
    [self createTableView];
    [self bottomView];
    [self navigationControllerStyle];
    [self requestUrl:1];
    //添加图片试图
    WZXMoreImageView *moreImageView = [[WZXMoreImageView alloc] initWithFrame:CGRectMake(0, 64 * IPHONE6_HEIGHT, KWIDTH, 160 * IPHONE6_HEIGHT)];
    [moreImageView.classInformation addTarget:self action:@selector(information:) forControlEvents:UIControlEventTouchUpInside];
    [moreImageView.classOutline addTarget:self action:@selector(outLine:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:moreImageView];
    

}
- (void)loadMoreData{
    [self.classDetailTableView.mj_header endRefreshing];
    if (_buttonTypeInt == 2) {
        self.pageNum ++;
        [self requestUrl:2];
    }
}
- (void)loadNewData{
    if (_buttonTypeInt == 2) {
        self.pageNum = 1;
        [self requestUrl:2];
    }
}

#pragma mark - action
//课程信息
- (void)information:(UIButton *)but{
    [self.classDetailTableView.mj_footer setHidden:YES];
    [self.classDetailTableView.mj_header setHidden:YES];

    _buttonTypeInt = 1;
    [self requestUrl:_buttonTypeInt];
}
//课程大纲
- (void)outLine:(UIButton *)but{
    
    [self.classDetailTableView.mj_footer setHidden:NO];
    [self.classDetailTableView.mj_header setHidden:NO];
    
    self.classDetailTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
//    [self.classDetailTableView.mj_header beginRefreshing];
    
    self.classDetailTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    //
    [self loadNewData];

    _buttonTypeInt = 2;
    [self requestUrl:_buttonTypeInt];
}
- (void)requestUrl:(NSInteger)typeButton{
    if (typeButton == 1) {
        //默认token已经传
        __weak typeof(self)weakSelf = self;
        NSDictionary *dic = @{@"courseId":@(self.courseIdInt)};
        [AFTools postWithUrl:Request_Appointment_CourseMessage andParameters:dic andSuccessBlock:^(id responseObject) {
            weakSelf.dataModel = [[WZXCourseMessageModel alloc]init];
            if ([[responseObject objectForKey:@"code"]integerValue] == 1) {
                NSMutableDictionary *dataDic = [responseObject objectForKey:@"data"];
                [weakSelf.dataModel yy_modelSetWithJSON:dataDic];
            }
            [self.classDetailTableView reloadData];
            [weakSelf.classDetailTableView.mj_header endRefreshing];
            [weakSelf.classDetailTableView.mj_footer endRefreshing];
        } andFaileBlock:^(NSError *error) {
            [weakSelf.classDetailTableView.mj_header endRefreshing];
            [weakSelf.classDetailTableView.mj_footer endRefreshing];
            
        }];
        return;
    }else if (typeButton == 2){
        __weak typeof(self)weakSelf = self;
        NSString *url = [NSString stringWithFormat:@"%@",@"lucyAdmin/appointment/chooseCourseSon"];
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:@(_pageNum) forKey:@"page"];
        [params setObject:[NSString stringWithFormat:@"%ld",self.courseIdInt] forKey:@"courseId"];
        [AFTools postWithUrl:url andParameters:params andSuccessBlock:^(id responseObject) {
            NSLog(@"2121212121212%@",responseObject);
            
            if ([[responseObject objectForKey:@"code"]integerValue] == 1) {
                if (weakSelf.pageNum == 1) {
                    [weakSelf.mydataModelArray removeAllObjects];
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
            }else if ([[responseObject objectForKey:@"code"]integerValue] == 10002){
                [MBProgressHUD showSuccess:[responseObject objectForKey:@"message"] toView:self.view];
//                [self.classDetailTableView reloadData];
                
            }
            

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                // 刷新表格
                [self.classDetailTableView reloadData];

                // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
                [weakSelf.classDetailTableView.mj_footer endRefreshing];
                [weakSelf.classDetailTableView.mj_header endRefreshing];
            });
           
//            [weakSelf.classDetailTableView.mj_footer endRefreshing];
            [self.classDetailTableView reloadData];
        } andFaileBlock:^(NSError *error) {
            [weakSelf.classDetailTableView.mj_header endRefreshing];
            [weakSelf.classDetailTableView.mj_footer endRefreshing];
        }];
        return;
    }
}
- (CGFloat)getText:(NSString *)str{
    //根据label文字获取CGRect
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    //set the line break mode
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attrDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              [UIFont systemFontOfSize:12 * IPHONE6_HEIGHT],
                              NSFontAttributeName,
                              paragraphStyle,
                              NSParagraphStyleAttributeName,
                              nil];
    CGRect lblRect = [str boundingRectWithSize:(CGSize){KWIDTH - 15*2 * IPHONE6_WIDTH, MAXFLOAT}
                                       options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                    attributes:attrDict
                                       context:nil];
    CGFloat h = lblRect.size.height;
    return h;
}
#pragma mark - 返回
- (void)returnAction:(UIButton *)returnBtn {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)createTableView {
    self.classDetailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (160 + 64) * IPHONE6_HEIGHT, KWIDTH, KHEIGHT - (160 + 64) * IPHONE6_HEIGHT - 98/2 * IPHONE6_HEIGHT) style:UITableViewStylePlain];
    self.classDetailTableView.delegate = self;
    self.classDetailTableView.dataSource = self;
    self.classDetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.classDetailTableView];
    
#pragma mark - 注册cell
    [self.classDetailTableView registerClass:[WZXOutlineFirstTableViewCell class] forCellReuseIdentifier:@"firstCell"];
    [self.classDetailTableView registerClass:[WZXOutlineSecondTableViewCell class] forCellReuseIdentifier:@"secondCell"];
    [self.classDetailTableView registerClass:[WZXOutlineThirdTableViewCell class] forCellReuseIdentifier:@"thirdCell"];
    [self.classDetailTableView registerClass:[WZXInformationTableViewCell class] forCellReuseIdentifier:@"WZXInformationTableViewCell"];
    
    
}
- (void)bottomView{
    _leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, KHEIGHT- 98/2 * IPHONE6_HEIGHT, KWIDTH/2, 100/2)];
    _leftButton.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_leftButton];
    [_leftButton setImage:[UIImage imageNamed:@"tabbar_icon_me_selected"] forState:UIControlStateNormal];
    [_leftButton setTitle:@"咨询客服" forState:UIControlStateNormal];
    //button标题的偏移量，这个偏移量是相对于图片的
    _leftButton.titleEdgeInsets = UIEdgeInsetsMake(0, 15 * IPHONE6_WIDTH, 0, 0);
    //设置button正常状态下的标题颜色
    [_leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //设置button高亮状态下的标题颜色
    [_leftButton setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
    _leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    
    _rightButton = [[UIButton alloc]initWithFrame:CGRectMake(KWIDTH/2, KHEIGHT- 98/2 * IPHONE6_HEIGHT, KWIDTH/2, 100/2)];
    _rightButton.backgroundColor =REDCOLOR;
    [self.view addSubview:_rightButton];
    [_rightButton setTitle:@"课程选择" forState:UIControlStateNormal];
    //button标题的偏移量，这个偏移量是相对于图片的
    //设置button正常状态下的标题颜色
    [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_rightButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - Action
- (void)leftAction{
    NSLog(@"咨询客服");
}
//课程选择
- (void)rightAction{
    //token
    if (self.teacherIdStr.length == 0) {
        [MBProgressHUD showSuccess:@"请先选择老师" toView:self.view];
        return;
    }
    if (_selectTimeDic == nil) {
        [MBProgressHUD showSuccess:@"请选择授课时间" toView:self.view];
        return;
    }
    if (_didSeletArray == nil || [_didSeletArray count] == 0) {
        //请先选择小课,或当前老师没有小课
        [MBProgressHUD showSuccess:@"选择小课才可以课程选择" toView:self.view];
        return;
    }
    WZXSelectSmallClassModel *model =  _didSeletArray[0];
    
    WZXTimeModel *timemodel = [_selectTimeDic objectForKey:@"model"];
    if (timemodel.time.length == 0) {
        [MBProgressHUD showSuccess:@"请选择授课时间" toView:self.view];
        return;

    }
    WZXTureOrderViewController *VC = [[WZXTureOrderViewController alloc]init];
    VC.teacherIdStr = self.teacherIdStr;
    VC.typeStr = self.typeStr;
    VC.courseId = self.courseIdInt;
    VC.myDataDic =  _selectTimeDic;
    VC.presentModel = model;
    [self.navigationController pushViewController:VC animated:YES];

    
    
}
#pragma mark - 必要的方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        WZXOutlineFirstTableViewCell *firstCell = [tableView dequeueReusableCellWithIdentifier:@"firstCell" forIndexPath:indexPath];
        firstCell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        if (_teacherModel != nil) {
            [firstCell.headImageView yy_setImageWithURL:[NSURL URLWithString:_teacherModel.image] placeholder:placeholderStr];
            firstCell.selectLabel.text = _teacherModel.realname;
        }
        return firstCell;
    }
    if (_buttonTypeInt == 1) {
        
        if (indexPath.section != 0) {
            
            WZXInformationTableViewCell *contentCell = [tableView dequeueReusableCellWithIdentifier:@"WZXInformationTableViewCell" forIndexPath:indexPath];
            if (indexPath.section == 1) {
                contentCell.titlelabel.text = @"课程简介";
                contentCell.contentStr = _dataModel.intro;
            }else if (indexPath.section == 2){
                contentCell.titlelabel.text = @"课程安排";
                contentCell.contentStr = _dataModel.courseplan;
            }else if (indexPath.section == 3){
                contentCell.titlelabel.text = @"适合对象";
                contentCell.contentStr = _dataModel.suitObject;
            }else if (indexPath.section == 4){
                contentCell.titlelabel.text = @"教学目标";
                contentCell.contentStr = _dataModel.objective;
            }
            return contentCell;
        }
    }
    
    else{
        
        if (indexPath.section == 1) {
            WZXOutlineSecondTableViewCell *secondCell = [tableView dequeueReusableCellWithIdentifier:@"secondCell" forIndexPath:indexPath];
            secondCell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            if (_selectTimeDic != nil) {
                
                NSString *yearStr = [_selectTimeDic objectForKey:@"year"];
                NSString *mouth = [_selectTimeDic objectForKey:@"mouth"];
                NSString *day = [_selectTimeDic objectForKey:@"day"];
                WZXTimeModel *timemodel = [_selectTimeDic objectForKey:@"model"];
                NSString *weakStr =  [self getDateYear:yearStr Mouth:mouth Day:day];
                secondCell.contentL.text = [NSString stringWithFormat:@"%@(%@)%@",day,weakStr,timemodel.time];
                
            }
            return secondCell;
        } else if(indexPath.section == 2){
            WZXOutlineThirdTableViewCell *thirdCell = [tableView dequeueReusableCellWithIdentifier:@"thirdCell" forIndexPath:indexPath];
            WZXSelectSmallClassModel *model =  _mydataModelArray[indexPath.row ];
            thirdCell.myModel = model;
            if ([_didSeletArray containsObject:model] ) {
                [thirdCell setSelectChangeColor:YES];
            }else{
                [thirdCell setSelectChangeColor:NO];
                
            }
            return thirdCell;
        }
        
    }
    return nil;
    
    //        WZXInformationTableViewCell *informationCell = [tableView dequeueReusableCellWithIdentifier:@"thirdCell" forIndexPath:indexPath];
    //        return informationCell;
}
- (NSString *)getDateYear:(NSString *)year Mouth:(NSString *)mouth Day:(NSString *)day{
    NSString* timeStr = [NSString stringWithFormat:@"%@-%@-%@",year,mouth,day];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"]; // ----------设置你想要的格式,hh与      HH的区别:分别表示12小时制,24小时制
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:timeStr]; //------------将字符串按formatter转成nsdate
   NSString *weakStr =  [self weekdayStringFromDate:date];
//    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
//    NSString *nowtimeStr = [formatter stringFromDate:datenow];//----------将nsdate按formatter格式转成nsstring
    return weakStr;
}
- (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"Sunday", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

#pragma mark - 每个section有几个row
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_buttonTypeInt == 2) {
        if (section == 0) {
            return 1;
        } else if (section == 1) {
            return 1;
        } else if (section == 2){
            return _mydataModelArray.count;//可变
        }
    }else{
        return 1;
    }
    return 0;
    
}
#pragma mark - 设置分为几个区

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_buttonTypeInt == 1) {
        return 5;
    }else{
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //return 160;
    if (_buttonTypeInt == 2) {
        return 44 * IPHONE6_HEIGHT;
    }else{
        if (indexPath.section == 0) {
            return 44 * IPHONE6_HEIGHT;
        }else{
            if (indexPath.section == 1) {
                CGFloat h =  [self getText:_dataModel.intro];
                return h + (60/2 + 1 + 32/2 + 10) * IPHONE6_HEIGHT;
            }else if (indexPath.section == 2){
                CGFloat f =[self getText:_dataModel.courseplan];
                return f + (60/2 + 1 + 32/2 + 10) * IPHONE6_HEIGHT;
            }else if (indexPath.section == 3){
                CGFloat h = [self getText:_dataModel.suitObject];
                return h + (60/2 + 1 + 32/2 + 10) * IPHONE6_HEIGHT;
            }else if (indexPath.section == 4){
                CGFloat h = [self getText:_dataModel.objective];
                return h + (60/2 + 1 + 32/2 + 10) * IPHONE6_HEIGHT;
            }
        }
    }
    return 0;
}
-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 10 * IPHONE6_HEIGHT)];
    headerView.backgroundColor = [UIColor colorWithRed:241.0f/255.0f green:241.0f/255.0f blue:241.0f/255.0f alpha:1];
    return headerView;
}

#pragma mark - header
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (_buttonTypeInt == 2) {
        return 0.5;
    }else{
        if (section == 0) {
            return 0.1;
        }else{
            return 10;
        }
    }
}

#pragma mark - footer
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //  取消点击至灰效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        WZXSelectTeacherViewController *selectVC = [[WZXSelectTeacherViewController alloc]init];
        selectVC.typeStr = self.typeStr;
        selectVC.categoryIdInt = self.categoryIdInt;
        __weak typeof(self)weakSelf = self;
        selectVC.selectTeacherBlock = ^(WZXYoungModel *model) {
            
            weakSelf.teacherModel = model;
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
            weakSelf.teacherIdStr = [NSString stringWithFormat:@"%ld",model.tId];
        };
        [self.navigationController pushViewController:selectVC animated:YES];
    }
        
        //课程信息
        if (_buttonTypeInt == 1) {
            
        }
    else{
        if (indexPath.section == 1) {
            if (self.teacherIdStr.length == 0) {
                [MBProgressHUD showSuccess:@"请先选择授课老师" toView:self.view];
                //因为下一页面需要穿老师id，不选择老师，没有办法请求下页面数据
                return;
            }
            WZXYoungSelectTimeViewController *selectTimeVC = [[WZXYoungSelectTimeViewController alloc]init];
            selectTimeVC.selType = selectOneToTWo;
            selectTimeVC.courseId = self.courseIdInt;
            selectTimeVC.typeStr = self.typeStr;
            selectTimeVC.teacherIdStr = self.teacherIdStr;
            selectTimeVC.SelectTimeBlock = ^(NSMutableDictionary *dic) {
                NSLog(@"%@",dic);
                _selectTimeDic = [NSMutableDictionary dictionaryWithDictionary:dic];
                [_classDetailTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
            };
            [self.navigationController pushViewController:selectTimeVC animated:YES];
            
        }
        if (indexPath.section == 2) {
            WZXSelectSmallClassModel *model =  _mydataModelArray[indexPath.row];
            [_didSeletArray removeAllObjects];
            if ([_didSeletArray isEqual:model]) {
                
            }else{
                [_didSeletArray addObject:model];
            }
            [_classDetailTableView reloadData];
        }
    }
    
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
    self.navigationItem.title = @"课程详情";
    self.navigationController.navigationBarHidden = NO;
    //  左边返回键
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_jiantou_default"] style:UIBarButtonItemStylePlain target:self action:@selector(returnAction:)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    
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
