//
//  WZXHomeSecondCollectionViewCell.h
//  CNT
//
//  Created by 王智鑫 on 2017/11/9.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZXTeacherDetailModel.h"



@interface WZXHomeSecondCollectionViewCell : UICollectionViewCell


#pragma mark - 今日课程 +
@property (nonatomic ,strong)UILabel *todaysCourse;//今日课程
@property (nonatomic ,strong)UILabel *todaysCourseEnglish;//今日课程英文

#pragma mark - 更多课程 +
@property (nonatomic ,strong)UILabel *MoreCourse;//更多课程
@property (nonatomic ,strong)UILabel *MoreCourseEnglish;//更多课程英文
@property (nonatomic ,strong)UIButton *moreCourseBtn;
@property (nonatomic ,strong)UILabel *moreEnglishLabel;
@property (nonatomic ,strong)UIImage *moreImage;//更多课程图片
@property (nonatomic ,strong)UIImageView *moreImageView;

#pragma mark - 三组图片布局 +
@property (nonatomic ,strong)UIImage *firstImage;
@property (nonatomic ,strong)UIImageView *firstImageView;
@property (nonatomic ,strong)UIImage *secondImage;
@property (nonatomic ,strong)UIImageView *secondImageView;
@property (nonatomic ,strong)UIImage *thirdImage;
@property (nonatomic ,strong)UIImageView *thirdImageView;

#pragma mark - 两个label布局
@property (nonatomic ,strong)UILabel *firstLabel;
@property (nonatomic ,strong)UILabel *secondLabel;

#pragma mark -  两个老师布局
@property (nonatomic ,strong)UIImage *headImage;
@property (nonatomic ,strong)UIImageView *headImageView;
@property (nonatomic ,strong)UILabel *nameLabelFirst;
@property (nonatomic ,strong)UIButton *detailsBtn;

@property (nonatomic ,strong)UIImage *headImageSecond;
@property (nonatomic ,strong)UIImageView *headImageViewSecond;
@property (nonatomic ,strong)UILabel *nameLabelSecond;
@property (nonatomic ,strong)UIButton *detailsBtnSecond;


@property (nonatomic, strong) WZXTeacherDetailModel *myModel;
@property (nonatomic, strong) WZXTeacherDetailModel *mySecondTeacherModel;


//@property (nonatomic, copy) void(^HomeSecondBlock)(WZXTeacherDetailModel *model);
@end
