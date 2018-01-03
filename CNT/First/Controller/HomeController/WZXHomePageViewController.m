//
//  WZXHomePageViewController.m
//  CNT
//
//  Created by 王智鑫 on 2017/11/8.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXHomePageViewController.h"
#import "WZXHomeFirstCollectionViewCell.h"
#import "WZXHomeSecondCollectionViewCell.h"
#import "WZXHomeThirdCollectionViewCell.h"
#import "WZXHomeCollectionReusableView.h"
#import "WZXSecondCollectionReusableView.h"
#import "WZXHomeFourthCollectionViewCell.h"
#import "WZXThirdCollectionReusableView.h"
#import "AppDelegate.h"
#import "WZXYoungViewController.h"
#import "WZXYoungSelectClassViewController.h"//选择课程（大课）
#import "WZXTeacherDetailModel.h"
#import "WZXSelectSmallClassModel.h"
#import "WZXYoungDetailViewController.h"
#import "WZXMoreClassDetailViewController.h"

@interface WZXHomePageViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

//collectView
@property (nonatomic, retain)UICollectionView *collectionView;
//第一个model的总数组
@property (nonatomic, retain)NSMutableArray *firstArray;
//第二个model的总数组
@property (nonatomic, retain)NSMutableArray *secondArray;
//第三个model的总数组
@property (nonatomic, retain)NSMutableArray *thirdArray;
//存轮播图数据的数组
@property (nonatomic ,retain)NSMutableArray *loopsArray;
//存轮播图 图片的数组
@property (nonatomic ,retain)NSMutableArray *loopsPicArray;
//存轮播图Title的数组
@property (nonatomic ,retain)NSMutableArray *loopsTitleArray;
//传课标识
@property (nonatomic ,copy)NSString *type;


@property (nonatomic ,retain)WZXHomeCollectionReusableView *headView;
@property (nonatomic ,retain)WZXSecondCollectionReusableView *thirdHeadView;
@property (nonatomic ,retain)WZXThirdCollectionReusableView *fourthHeadView;


@property (nonatomic, strong) NSMutableArray *oneToManyCourseDataArray;
@property (nonatomic, strong) NSMutableArray *oneToOneCourseDataArray;
@property (nonatomic, strong) NSMutableArray *todayTeacherDataArray;

@end

@implementation WZXHomePageViewController

#pragma mark - 返回显示tablebar
- (void)showTabBar

{
    if (self.tabBarController.tabBar.hidden == NO)
    {
        return;
    }
    UIView *contentView;
    if ([[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]])
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    else
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height - self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self showTabBar];
    [self getListUrl];
    self.navigationItem.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
#pragma mark 各种数组初始化
    self.firstArray = [NSMutableArray array];
    self.secondArray = [NSMutableArray array];
    self.loopsPicArray = [NSMutableArray array];
    self.loopsTitleArray = [NSMutableArray array];
    
#pragma mark 调用加载各种方法
    [self createCollectionView];
    [self getDataWithURL];   
    //轮播图
    _mydataModelArray = [NSMutableArray array];
   _mydataModelArray = [self postWithTitleUrl];
}
#pragma mark - 请求主页数据
- (void)getListUrl{
    
    _oneToManyCourseDataArray = [NSMutableArray array];
    _oneToOneCourseDataArray = [NSMutableArray array];
    _todayTeacherDataArray = [NSMutableArray array];
    
    [AFTools postWithUrl:Request_Course_Find_Home andParameters:nil andSuccessBlock:^(id responseObject) {
        
        NSLog(@"1992/05/21%@",responseObject);
        
        if ([[responseObject objectForKey:@"status"] intValue] == 0) {
            NSMutableDictionary *responseObjectDic = [responseObject objectForKey:@"data"];
            NSMutableArray *oneToManyCourseArray = [responseObjectDic objectForKey:@"oneToManyCourse"];
            NSMutableArray *todayTeacherArray = [responseObjectDic objectForKey:@"todayTeacher"];
            NSMutableArray *oneToOneCourseArray = [responseObjectDic objectForKey:@"oneToOneCourse"];
            

            for (NSMutableDictionary *dic in todayTeacherArray) {
               WZXTeacherDetailModel *model = [[WZXTeacherDetailModel alloc]init];
                [model yy_modelSetWithJSON:dic];
                [_todayTeacherDataArray addObject:model];
            }
            for (NSMutableDictionary *dic in oneToOneCourseArray) {
                WZXSelectSmallClassModel *model = [[WZXSelectSmallClassModel alloc]init];
                [model yy_modelSetWithJSON:dic];
                [_oneToOneCourseDataArray addObject:model];
            }
            for (NSMutableDictionary *dic in oneToManyCourseArray) {
                WZXSelectSmallClassModel *model = [[WZXSelectSmallClassModel alloc]init];
                [model yy_modelSetWithJSON:dic];
                [_oneToManyCourseDataArray addObject:model];
            }
            [_collectionView reloadData];
        }
    } andFaileBlock:^(NSError *error) {
        
    }];
}

#pragma mark - 隐藏NavigatonBar
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];

}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

#pragma mark - 创建collectionView
- (void)createCollectionView
{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    //*************          去掉collectionView cell 之间的黑线
    flow.minimumLineSpacing = 0;
    flow.minimumInteritemSpacing = 0;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, -24, KWIDTH, KHEIGHT+20) collectionViewLayout:flow];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.940 alpha:1.000];
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];
    //    flow.headerReferenceSize = CGSizeMake(SCREEN.size.width, 200);
    
#pragma mark 注册头部区域
    [self.collectionView registerClass:[WZXHomeCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.collectionView registerClass:[WZXSecondCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"thirdheader"];
    [self.collectionView registerClass:[WZXThirdCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"fourthheader"];
    
#pragma mark 注册两种cell
    [self.collectionView registerClass:[WZXHomeFirstCollectionViewCell class] forCellWithReuseIdentifier:@"firstCell"];
    [self.collectionView registerClass:[WZXHomeSecondCollectionViewCell class] forCellWithReuseIdentifier:@"secondCell"];
    [self.collectionView registerClass:[WZXHomeThirdCollectionViewCell class] forCellWithReuseIdentifier:@"thirdCell"];
    [self.collectionView registerClass:[WZXHomeFourthCollectionViewCell class] forCellWithReuseIdentifier:@"fourthCell"];
    
#pragma mark - 

}

- (void)getDataWithURL
{
    [_loopsTitleArray addObject:@"姚旭是个胖子！！！！"];
    [_loopsTitleArray addObject:@"周桐是只小老虎！！！"];
    [_loopsTitleArray addObject:@"阿鑫最帅！！！！！！"];
    [_loopsPicArray addObject:@"banner1"];
    [_loopsPicArray addObject:@"banner2"];
    [_loopsPicArray addObject:@"banner3"];
}


#pragma mark - 定义的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        WZXHomeFirstCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"firstCell" forIndexPath:indexPath];
        /** cell中的button - 点击事件 **/
        [cell.youngBtn addTarget:self action:@selector(youngBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.adultBtn addTarget:self action:@selector(adultBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
        return cell;
        
    }else if (indexPath.section == 1){
        WZXHomeSecondCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"secondCell" forIndexPath:indexPath];
        [cell.moreCourseBtn addTarget:self action:@selector(MoreLessonAction:) forControlEvents:UIControlEventTouchUpInside];

        if (_todayTeacherDataArray.count >= 1) {
        cell.myModel = _todayTeacherDataArray[0];
        cell.mySecondTeacherModel  = _todayTeacherDataArray[1];
        [cell.detailsBtn addTarget:self action:@selector(detailsBtnActionSecond) forControlEvents:UIControlEventTouchUpInside];
        [cell.detailsBtnSecond addTarget:self action:@selector(detailsBtnAction) forControlEvents:UIControlEventTouchUpInside];
        }

        return cell;
    }else if (indexPath.section == 2){
        //一对一
        WZXHomeThirdCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"thirdCell" forIndexPath:indexPath];
        WZXSelectSmallClassModel *model = _oneToOneCourseDataArray[indexPath.row];
        cell.myModel = model;
        return cell;
    }else {
        //一对多
        WZXHomeFourthCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"fourthCell" forIndexPath:indexPath];
        WZXSelectSmallClassModel *model = _oneToManyCourseDataArray[indexPath.row];
        cell.myModel = model;
        return cell;
    }
    
}
#pragma mark - 首页两个老师详情
- (void)detailsBtnActionSecond{
    WZXTeacherDetailModel *model = _todayTeacherDataArray[0];
    WZXYoungDetailViewController *youngVC = [[WZXYoungDetailViewController alloc] init];
    youngVC.teacherID = [NSString stringWithFormat:@"%ld",model.tId];
    youngVC.typeStr = @"1";
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:youngVC animated:YES];
    NSLog(@"%ld-----------%@",model.tId,model.realname);
}
- (void)detailsBtnAction{
    WZXTeacherDetailModel *model = _todayTeacherDataArray[1];
    WZXYoungDetailViewController *youngVC = [[WZXYoungDetailViewController alloc] init];
    youngVC.teacherID = [NSString stringWithFormat:@"%ld",model.tId];
    youngVC.typeStr = @"1";
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:youngVC animated:YES];
    NSLog(@"%ld-----------%@",model.tId,model.realname);

}
#pragma mark - 点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   if (indexPath.section == 2){
       WZXSelectSmallClassModel *model = _oneToOneCourseDataArray[indexPath.row];
       WZXMoreClassDetailViewController *moreDetailVC = [[WZXMoreClassDetailViewController alloc] init];
       moreDetailVC.courseIdInt = model.courseId;
       moreDetailVC.categoryIdInt = model.categoryId;
       moreDetailVC.typeStr = @"1";
       self.hidesBottomBarWhenPushed = YES;
       [self.navigationController pushViewController:moreDetailVC animated:YES];
       NSLog(@"1对1课程ID ===== %ld",model.courseId);
   }else if (indexPath.section == 3){
       WZXSelectSmallClassModel *model = _oneToManyCourseDataArray[indexPath.row];
       WZXMoreClassDetailViewController *moreDetailVC = [[WZXMoreClassDetailViewController alloc] init];
       moreDetailVC.courseIdInt = model.courseId;
       moreDetailVC.categoryIdInt = model.categoryId;
       moreDetailVC.typeStr = @"2";
       self.hidesBottomBarWhenPushed = YES;
       NSLog(@"1对多课程ID ***** %ld",model.courseId);
       [self.navigationController pushViewController:moreDetailVC animated:YES];

   }

}

#pragma mark - 设置collectionView的头部区域
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            self.headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
            [self getluboPicturesWithPicArray:_loopsPicArray andTitleArray:_loopsTitleArray];
            
            return self.headView;
        }else if (indexPath.section == 2){
            
            self.thirdHeadView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"thirdheader" forIndexPath:indexPath];
            [self.thirdHeadView.moreCourseBtn addTarget:self action:@selector(MoreLessonTwoAction:) forControlEvents:UIControlEventTouchUpInside];
            
            return self.thirdHeadView;
        }else if (indexPath.section == 3){
            
            self.fourthHeadView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"fourthheader" forIndexPath:indexPath];
            [self.fourthHeadView.moreCourseBtn addTarget:self action:@selector(MoreLessonActionThird:) forControlEvents:UIControlEventTouchUpInside];
            return self.fourthHeadView;
        }
    } else
    {
        return nil;
    }
    return nil;
}

#pragma mark - 设置每个分区头部区域的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(KWIDTH, 255 * AUTO_HEIGHT);
    }else if (section == 2){
        return CGSizeMake(KWIDTH, 43 * AUTO_HEIGHT);
    }else if (section == 3){
        return CGSizeMake(KWIDTH, 43 * AUTO_HEIGHT);
    }else {
        return CGSizeZero;
    }
}

#pragma mark - 设置分为几个区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}

#pragma mark - 设置每个区cell个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 1;
    }else if (section == 2){
        return _oneToOneCourseDataArray.count;
    }
    else {
        return _oneToManyCourseDataArray.count;
    }
}

#pragma mark - 设置每个区的cell大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return CGSizeMake(KWIDTH , 90 * AUTO_HEIGHT);
    }if (indexPath.section == 1){
        
        return CGSizeMake(KWIDTH , 295 * AUTO_HEIGHT);
    }else {
        return CGSizeMake(KWIDTH, 110 * AUTO_HEIGHT);
    }
}

#pragma mark - 设置距离四边的边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 2 && section == 3) {

        return UIEdgeInsetsMake(0 * AUTO_WIDTH , 0 * AUTO_HEIGHT, 0 * AUTO_WIDTH , 0 * AUTO_HEIGHT );
    }else{
    return UIEdgeInsetsMake(1 * AUTO_WIDTH , 5 * AUTO_HEIGHT, 5 * AUTO_WIDTH , 5 * AUTO_HEIGHT );
    }
}
#pragma mark - 设置轮播图
- (void)getluboPicturesWithPicArray:(NSArray *)picArray andTitleArray:(NSArray *)titleArray
{
    SDCycleScrollView *loopsView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250 * AUTO_HEIGHT)];
    loopsView.imageURLStringsGroup = picArray;
    loopsView.titlesGroup = titleArray;
    loopsView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    [self.headView addSubview:loopsView];
    
}


#pragma mark - 置顶按键,实现方法
- (void)buttonAction:(UIButton *)btn
{
    [self.collectionView setContentOffset:CGPointMake(0, -46) animated:YES];
}


#pragma mark - firstCell中的button点击事件
- (void)youngBtnAction:(UIButton *)youngBtn {
              //请求类别接
//    self.type = @"1";
    WZXYoungViewController *youngVC = [[WZXYoungViewController alloc] init];
    youngVC.hidesBottomBarWhenPushed = YES;
    //跳转选课中心界面并且传 type 1是一对一
    youngVC.type = @"1";
    youngVC.myDataArray = _mydataModelArray;
    youngVC.cateoryID = 1003;
    [self.navigationController pushViewController:youngVC animated:YES];
}
- (void)adultBtnAction:(UIButton *)adultBtn {
    //跳转选课中心界面并且传 type 1是一对一
//    self.type = @"1";
    WZXYoungViewController *youngVC = [[WZXYoungViewController alloc] init];
    youngVC.hidesBottomBarWhenPushed = YES;
    youngVC.type = @"1";
    youngVC.myDataArray = _mydataModelArray;
    youngVC.cateoryID = 1004;
    [self.navigationController pushViewController:youngVC animated:YES];
}
#pragma mark - secondCell中的button点击事件
- (void)MoreLessonAction:(UIButton *)btn {
    //跳转选课中心界面并且传 type 1是一对一
//    self.type = @"1";
    WZXYoungViewController *youngVC = [[WZXYoungViewController alloc] init];
    youngVC.hidesBottomBarWhenPushed = YES;
    youngVC.type = @"1";
    youngVC.myDataArray = _mydataModelArray;
    youngVC.cateoryID = 1003;
    [self.navigationController pushViewController:youngVC animated:YES];
}

#pragma mark - 请求接口
- (NSMutableArray *)postWithTitleUrl {
    
    NSString *urlString = [NSString stringWithFormat:@"%@",@"lucyAdmin/appointment/courseType"];
    NSMutableArray *array = [NSMutableArray array];
    [AFTools postWithUrl:urlString andParameters:nil andSuccessBlock:^(id responseObject) {
        NSLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"code"]integerValue] == 1) {
            NSMutableArray *dataArray = [responseObject objectForKey:@"data"];
            for (NSMutableDictionary *dataDic in dataArray) {
                WZXYoungModel *model = [WZXYoungModel new];
                [model yy_modelSetWithJSON:dataDic];
//                self.youngModel = model;
            //    [_mydataModelArray addObject:model];
                [array addObject:model];
//                NSLog(@"~~~~~~%@",self.youngModel.categoryName);
//                NSLog(@"~~~~~~%@",self.youngModel.presentation);
            }
        }
    } andFaileBlock:^(NSError *error) {
        
    }];
    return array;
}

#pragma mark - secton头部更多按钮点击事件
- (void)MoreLessonTwoAction:(UIButton *)btn {
    WZXYoungSelectClassViewController *selectClassVC = [[WZXYoungSelectClassViewController alloc] init];
    selectClassVC.hidesBottomBarWhenPushed = YES;
    selectClassVC.selectUrlTag = 2;//选择是那个button跳转课程，请求哪个接口
    selectClassVC.typeStr = @"1";
    [self.navigationController pushViewController:selectClassVC animated:YES];
}

- (void)MoreLessonActionThird:(UIButton *)btn {
    WZXYoungSelectClassViewController *selectClassVC = [[WZXYoungSelectClassViewController alloc] init];
    selectClassVC.hidesBottomBarWhenPushed = YES;
    selectClassVC.typeStr = @"2";
    selectClassVC.selectUrlTag = 2;//选择是那个button跳转课程，请求哪个接口
    [self.navigationController pushViewController:selectClassVC animated:YES];    
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
