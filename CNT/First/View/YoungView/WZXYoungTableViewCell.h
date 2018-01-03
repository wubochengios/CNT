//
//  WZXYoungTableViewCell.h
//  CNT
//
//  Created by 王智鑫 on 2017/12/6.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZXYoungModel.h"
@interface WZXYoungTableViewCell : UITableViewCell
//  头像
@property (nonatomic ,strong)UIImage *headImage;
@property (nonatomic ,strong)UIImageView *headImageView;
//  姓名
@property (nonatomic ,strong)UILabel *nameLabel;
//  评分
@property (nonatomic ,strong)UILabel *scoreLabel;
//  水平
@property (nonatomic ,strong)UILabel *levelLabel;
//  预约button
@property (nonatomic ,strong)UIButton *orderingBtn;
@property (nonatomic, strong) WZXYoungModel *myModel;

@end
