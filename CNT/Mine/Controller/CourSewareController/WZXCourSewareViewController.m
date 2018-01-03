//
//  WZXCourSewareViewController.m
//  CNT
//
//  Created by 王智鑫 on 2017/11/15.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXCourSewareViewController.h"
#import "WZXOneByOneViewController.h"
#import "WZXOneByMoreViewController.h"
@interface WZXCourSewareViewController ()<UIScrollViewDelegate>
@property (nonatomic ,strong)UISegmentedControl *segementC;

@property (nonatomic ,strong)UIScrollView *myScrollerView;

@property (nonatomic ,strong)NSArray *titleArray;
@end

@implementation WZXCourSewareViewController

#pragma mark - 即将消失的时候隐藏
- (void)viewWillDisappear:(BOOL)animated
{
    [_segementC setHidden:YES];
}

#pragma mark - 显示的时候出现
- (void)viewWillAppear:(BOOL)animated
{
    [_segementC setHidden:NO];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.navigationItem.title = @"关注";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = REDCOLOR;
    self.titleArray = @[@"1对1",@"1对多"];
    self.segementC = [[UISegmentedControl alloc] initWithItems:self.titleArray];
    _segementC.tintColor = [UIColor whiteColor];
    //    选中的颜色
    [_segementC setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    //    未选中的颜色
    [_segementC setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateNormal];
    self.segementC.frame = CGRectMake(self.view.frame.size.width / 4, 5, self.view.frame.size.width / 2, 34);
    [self.navigationController.navigationBar addSubview:self.segementC];
    
#pragma mark - 给segement添加方法
    self.segementC.selectedSegmentIndex = 0;
    [self.segementC addTarget:self action:@selector(segementAction:) forControlEvents:UIControlEventValueChanged];
    
#pragma mark - 重写左边button返回按键
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStyleDone target:self action:@selector(leftAction:)];
    
#pragma mark - 可以滑动的大的ScrollerView
    self.myScrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.myScrollerView.contentSize = CGSizeMake(self.view.frame.size.width * 2, 0);
    self.myScrollerView.pagingEnabled = YES;
    self.myScrollerView.delegate = self;
    [self.view addSubview:self.myScrollerView];
    
#pragma mark - 添加视图
    WZXOneByOneViewController *oneVC = [[WZXOneByOneViewController alloc] init];
    [self addChildViewController:oneVC];
    [self.myScrollerView addSubview:oneVC.view];
    
    WZXOneByMoreViewController *moreVC = [[WZXOneByMoreViewController alloc] init];
    [self addChildViewController: moreVC];
    CGRect secondSize = moreVC.view.frame;
    secondSize.origin.x = [[UIScreen mainScreen] bounds].size.width;
    moreVC.view.frame = secondSize;
    [self.myScrollerView addSubview:moreVC.view];
    
#pragma mark - 创建导航栏左侧..我
    //修改系统自带的navigationItem的rightBarButtonItem的颜色
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithTitle:@"我😯" style:UIBarButtonItemStylePlain target:self action:@selector(returnAction:)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    
}


#pragma mark - 根据UISegmented选择，来滑动scrollerView
- (void)segementAction:(UISegmentedControl *)segment {
    
    if (segment.selectedSegmentIndex == 0) {
        
        self.myScrollerView.contentOffset = CGPointMake(0, 0);
    }else if (segment.selectedSegmentIndex == 1){
        
        self.myScrollerView.contentOffset = CGPointMake(self.view.frame.size.width, 0);
    }
    
}

#pragma mark - 滑动scrollerView，让UISegmented做是第几个选择
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (self.myScrollerView.contentOffset.x == 0) {
        
        self.segementC.selectedSegmentIndex = 0;
    }else if (self.myScrollerView.contentOffset.x == self.view.frame.size.width) {
        
        self.segementC.selectedSegmentIndex = 1;
    }
}

- (void)leftAction:(UIBarButtonItem *)left {
    
    self.segementC.hidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 返回上一页的的方法
- (void)returnAction:(UIBarButtonItem *)returnBtn {
    
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
