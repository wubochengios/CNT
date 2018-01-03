//
//  WZXHomeFourthCollectionViewCell.h
//  CNT
//
//  Created by 王智鑫 on 2017/11/13.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZXSelectSmallClassModel.h"

@interface WZXHomeFourthCollectionViewCell : UICollectionViewCell

@property (nonatomic ,strong)UIImage *bigImage;
@property (nonatomic ,strong)UIImageView *bigImageView;

@property (nonatomic ,strong)UILabel *titleLabel;
@property (nonatomic ,strong)UILabel *classesLabel;
@property (nonatomic ,strong)UILabel *countLabel;

@property (nonatomic ,strong)UILabel *lessonHourLabel;
@property (nonatomic ,strong)UILabel *lessonMoneyLabel;
@property (nonatomic, strong) WZXSelectSmallClassModel *myModel;
@end
