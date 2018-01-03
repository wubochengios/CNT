//
//  WZXHomeSecondCollectionViewCell.m
//  CNT
//
//  Created by 王智鑫 on 2017/11/9.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXHomeSecondCollectionViewCell.h"

@implementation WZXHomeSecondCollectionViewCell

- (instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self createSubView];
    }
    return self;
}

- (void) createSubView {
    
#pragma mark - 今日课程
    self.todaysCourse = [[UILabel alloc] initWithFrame:CGRectMake(15 * AUTO_WIDTH, 5 * AUTO_HEIGHT, 100 * AUTO_WIDTH, 25 * AUTO_HEIGHT)];
    self.todaysCourse.text = @"今日课程";
    self.todaysCourse.font = [UIFont systemFontOfSize:20 * AUTO_HEIGHT];
    [self addSubview:self.todaysCourse];
    self.todaysCourseEnglish = [[UILabel alloc] initWithFrame:CGRectMake(15 * AUTO_WIDTH, 30 * AUTO_HEIGHT, 100 * AUTO_WIDTH, 15 * AUTO_HEIGHT)];
    self.todaysCourseEnglish.text = @"Today's course";
    self.todaysCourseEnglish.textColor = [UIColor grayColor];
    self.todaysCourseEnglish.font = [UIFont systemFontOfSize:11 * AUTO_HEIGHT];
    [self addSubview:self.todaysCourseEnglish];
    
#pragma mark - moreLesson
    self.moreCourseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.moreCourseBtn setTitle:@"更多课程" forState:UIControlStateNormal];
    [self.moreCourseBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.moreCourseBtn.frame = CGRectMake(300 * AUTO_WIDTH, 10 * AUTO_HEIGHT, 80 * AUTO_WIDTH, 20 * AUTO_HEIGHT);
    self.moreCourseBtn.titleLabel.font = [UIFont systemFontOfSize:18 * AUTO_HEIGHT];
    [self addSubview:self.moreCourseBtn];
    
    self.moreEnglishLabel = [[UILabel alloc] initWithFrame:CGRectMake(345 * AUTO_WIDTH, 33 * AUTO_HEIGHT, 30 * AUTO_WIDTH, 10 * AUTO_HEIGHT)];
    self.moreEnglishLabel.text = @"More";
    self.moreEnglishLabel.font = [UIFont systemFontOfSize:11 * AUTO_HEIGHT];
    self.moreEnglishLabel.textColor = [UIColor grayColor];
    [self addSubview:self.moreEnglishLabel];
    
    self.moreImage = [UIImage imageNamed:@"content_icon_jiantou_pressed"];
    self.moreImageView = [[UIImageView alloc] initWithImage:self.moreImage];
    self.moreImageView.frame = CGRectMake(383 * AUTO_WIDTH, 17 * AUTO_HEIGHT, 15 * AUTO_WIDTH, 15 * AUTO_HEIGHT);
    [self addSubview:self.moreImageView];
    
#pragma mark - 课程图片
    self.firstImage = [UIImage imageNamed:@"lesson"];
    self.firstImageView = [[UIImageView alloc] initWithImage:self.firstImage];
    self.firstImageView.frame = CGRectMake(15 * AUTO_WIDTH, 50 * AUTO_HEIGHT, 192 * AUTO_WIDTH, 150 * AUTO_HEIGHT);
    [self addSubview:self.firstImageView];
    
    self.secondImage = [UIImage imageNamed:@"lessonsecond"];
    self.secondImageView = [[UIImageView alloc] initWithImage:self.secondImage];
    self.secondImageView.frame = CGRectMake(207 * AUTO_WIDTH, 50 * AUTO_HEIGHT, 192 * AUTO_WIDTH, 75 * AUTO_HEIGHT);
    [self addSubview:self.secondImageView];
    
    self.thirdImage = [UIImage imageNamed:@"lessonthird"];
    self.thirdImageView = [[UIImageView alloc] initWithImage:self.thirdImage];
    self.thirdImageView.frame = CGRectMake(207 * AUTO_WIDTH, 125 * AUTO_HEIGHT, 192 * AUTO_WIDTH, 75 * AUTO_HEIGHT);
    [self addSubview:self.thirdImageView];
    
#pragma mark -  label
    self.firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 * AUTO_WIDTH, 205 * AUTO_HEIGHT, 195 * AUTO_WIDTH, 40 * AUTO_HEIGHT)];
    self.firstLabel.font = [UIFont systemFontOfSize:13 * AUTO_HEIGHT];
    self.firstLabel.text = @"Chinese thought decryption + Chinese thinking culture";
    self.firstLabel.numberOfLines = 0;
    [self addSubview:self.firstLabel];
    
    self.secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(210 * AUTO_WIDTH, 205 * AUTO_HEIGHT, 195 * AUTO_WIDTH, 40 * AUTO_HEIGHT)];
    self.secondLabel.font = [UIFont systemFontOfSize:13 * AUTO_HEIGHT];
    self.secondLabel.text = @"Miss liu:a lesson to learn pinyin and pronunciation thoughiy";
    self.secondLabel.numberOfLines = 0;
    [self addSubview:self.secondLabel];
    
#pragma mark - 头像first
    self.headImage = [UIImage imageNamed:@"content_icon_touxiang_01_default"];
    self.headImageView = [[UIImageView alloc] initWithImage:self.headImage];
    self.headImageView.frame = CGRectMake(17 * AUTO_WIDTH, 250 * AUTO_HEIGHT, 40 * AUTO_WIDTH, 40 * AUTO_HEIGHT);
    self.headImageView.layer.cornerRadius = 20 * AUTO_HEIGHT;
    [self addSubview:self.headImageView];
    
    self.nameLabelFirst = [[UILabel alloc] initWithFrame:CGRectMake(65 * AUTO_WIDTH, 258 * AUTO_HEIGHT, 50 * AUTO_WIDTH, 20 * AUTO_HEIGHT)];
    self.nameLabelFirst.text = @"王老师";
    self.nameLabelFirst.font = [UIFont systemFontOfSize:14 * AUTO_HEIGHT];
    [self addSubview:self.nameLabelFirst];
    
    self.detailsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.detailsBtn setImage:[UIImage imageNamed:@"content_icon_xiangqing_default"] forState:UIControlStateNormal];
    self.detailsBtn.frame = CGRectMake(120 * AUTO_WIDTH, 253 * AUTO_HEIGHT, 60 * AUTO_WIDTH, 30 * AUTO_HEIGHT);
//    [self.detailsBtn addTarget:self action:@selector(detailsBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.detailsBtn];
    
#pragma mark - 头像second
    
    self.headImageSecond = [UIImage imageNamed:@"content_icon_touxiang_02_default"];
    self.headImageViewSecond = [[UIImageView alloc] initWithImage:self.headImageSecond];
    self.headImageViewSecond.frame = CGRectMake(209 * AUTO_WIDTH, 250 * AUTO_HEIGHT, 40 * AUTO_WIDTH, 40 * AUTO_HEIGHT);
    self.headImageViewSecond.layer.cornerRadius = 20 * AUTO_HEIGHT;
    [self addSubview:self.headImageViewSecond];
    
    self.nameLabelSecond = [[UILabel alloc] initWithFrame:CGRectMake(257 * AUTO_WIDTH, 258 * AUTO_HEIGHT, 60 * AUTO_WIDTH, 20 * AUTO_HEIGHT)];
    self.nameLabelSecond.text = @"MissLiu";
    self.nameLabelSecond.font = [UIFont systemFontOfSize:14 * AUTO_HEIGHT];
    [self addSubview:self.nameLabelSecond];
    
    self.detailsBtnSecond = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.detailsBtnSecond setImage:[UIImage imageNamed:@"content_icon_xiangqing_default"] forState:UIControlStateNormal];
    self.detailsBtnSecond.frame = CGRectMake(312 * AUTO_WIDTH, 253 * AUTO_HEIGHT, 60 * AUTO_WIDTH, 30 * AUTO_HEIGHT);
//    [self.detailsBtnSecond addTarget:self action:@selector(detailsBtnActionSecond:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.detailsBtnSecond];
       
}

- (void)setMyModel:(WZXTeacherDetailModel *)myModel{
    [self.headImageView yy_setImageWithURL:[NSURL URLWithString:myModel.image] placeholder:[UIImage imageNamed:@"content_icon_touxiang_01_default"]];
    self.nameLabelFirst.text = myModel.realname;
    
    
}
-(void)setMySecondTeacherModel:(WZXTeacherDetailModel *)mySecondTeacherModel{
    [self.headImageViewSecond yy_setImageWithURL:[NSURL URLWithString:mySecondTeacherModel.image] placeholder:[UIImage imageNamed:@"content_icon_touxiang_02_default"]];
    self.nameLabelSecond.text = mySecondTeacherModel.realname;
}
//- (void)detailsBtnAction:(UIButton *)btn {
//    if (_HomeSecondBlock) {
//        _HomeSecondBlock(self.myModel);
//    }
//    
//}
//
//- (void)detailsBtnActionSecond:(UIButton *)btn {
//    if (_HomeSecondBlock) {
//        _HomeSecondBlock(self.mySecondTeacherModel);
//    }
//    
//}


@end
