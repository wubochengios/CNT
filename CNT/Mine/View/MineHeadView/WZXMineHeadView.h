//
//  WZXMineHeadView.h
//  CNT
//
//  Created by 王智鑫 on 2017/11/14.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WZXMineHeaderViewDelegate <NSObject>

- (void)HeaderViewLogonAgora:(NSString *)roomId;

- (void)HeaderViewLonOutAgora;



@end


typedef NS_ENUM (NSInteger, RoleName) {
    
    RoleNameStudent = 1,//学生
    RoleNameTeacher//老师
};

@interface WZXMineHeadView : UIView
- (instancetype) initWithRoleName:(RoleName)role;

@property (nonatomic ,strong)UIImage *headImage;
@property (nonatomic ,strong)UIImageView *headImageView;//yhy 修改
@property (nonatomic ,strong)UILabel *nameLabel;
@property (nonatomic ,strong)UILabel *appraisaLabel;

@property (nonatomic ,strong)UILabel *classLabelFirst;
@property (nonatomic ,strong)UILabel *classLabelSecond;
@property (nonatomic ,strong)UILabel *speakLabelFirst;
@property (nonatomic ,strong)UILabel *speakLabelSecond;
@property (nonatomic ,strong)UILabel *weekLabelFirst;
@property (nonatomic ,strong)UILabel *weekLabelSeconds;

@property (nonatomic ,strong)UIImage *iconImage;
@property (nonatomic ,strong)UIImageView *iconImageView;

@property (nonatomic ,strong) UIButton *presonalbigBtn;//盖住头像的大btn

@property (nonatomic ,strong) UIButton *onLineBtn;//在线
@property (nonatomic ,strong) UIButton *offLineBtn;//离线

@property (nonatomic ,weak)id <WZXMineHeaderViewDelegate>delegate;

@end
