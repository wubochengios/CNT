//
//  WZXYoungDetailView.h
//  CNT
//
//  Created by 王智鑫 on 2017/12/6.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZXTeacherDetailModel.h"

@interface WZXYoungDetailView : UIView

//  头像
@property (nonatomic ,strong) UIImage *headImage;
@property (nonatomic ,strong)UIImageView *headImageView;
//  姓名
@property (nonatomic ,strong)UILabel *nameLabel;
// 横线
@property (nonatomic ,strong)UIView *lightView;
//  教学评分文字
@property (nonatomic ,strong)UILabel *scoreFirstLabel;
@property (nonatomic ,strong)UILabel *scoreSecondLabel;
//  上课形式文字
@property (nonatomic ,strong)UILabel *lessonFirstLabel;
@property (nonatomic ,strong)UILabel *lessonSecondLabel;
//  适合人群文字
@property (nonatomic ,strong)UILabel *crowdFirstLabel;
@property (nonatomic ,strong)UILabel *crowdSecondLabel;
//  课程价格文字
@property (nonatomic ,strong)UILabel *priceFirstLabel;
@property (nonatomic ,strong)UILabel *priceSecondLabel;
//  自我介绍
@property (nonatomic ,strong)UILabel *selfintroductionFirstLabel;
@property (nonatomic ,strong)UILabel *selfintroductionSecondLabel;
//  华说评语
@property (nonatomic ,strong)UILabel *commentsFirstLabel;
@property (nonatomic ,strong)UILabel *commentsSecondLabel;
//  预约btn
@property (nonatomic ,strong)UIButton *orderingBtn;
//  model
@property (nonatomic ,strong)WZXTeacherDetailModel *model;










@end
