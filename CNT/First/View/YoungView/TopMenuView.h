//
//  TopMenuView.h
//  text
//
//  Created by YHY on 2017/11/7.
//  Copyright © 2017年 mac. All rights reserved.
// 头部筛选 全部身份+全部班级 +课时

#import <UIKit/UIKit.h>
#import "WZXYoungModel.h"



@interface downMenuCell : UITableViewCell

@property (nonatomic) UIImageView  *selectImageView;

@property (nonatomic) BOOL  isSelected;

@end

@interface TopMenuView : UIView

@property (nonatomic) UIButton  *tempButton;

/*!@brief 二维数组，存放每个Button对应下的TableView数据。。 */
@property (nonatomic) NSMutableArray *menuDataArray;
//传数据-点击结果
//@property (nonatomic, copy) void(^handleSelectDataBlock) (ClassManageListModel *model);

@property (nonatomic, copy) void(^handleSelectBlock) (WZXYoungModel *model);

//@property (nonatomic, copy) void(^group_idBlock)(ClassManageListModel *model);
/**升序传值*/
@property (nonatomic, strong) void(^lesson_sortBlock)(NSInteger selectInt,NSString *object);

- (instancetype)initWithFrame:(CGRect)frame menuTitleArray:(NSArray *)titleArray;
//页面刷新
//- (void)reloadView;
@end
