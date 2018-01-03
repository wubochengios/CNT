//
//  WZXSelectTableViewCell.h
//  CNT
//
//  Created by 王智鑫 on 2017/12/2.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZXSelectClassModel.h"

@interface WZXSelectTableViewCell : UITableViewCell

@property (nonatomic ,strong)UIImage *clockImage;
@property (nonatomic ,strong)UIImageView *clockImageView;

@property (nonatomic ,strong)UILabel *firsClockLabel;
@property (nonatomic ,strong)UILabel *secondClockLabel;
@property (nonatomic ,strong)UILabel *endLabel;

@property (nonatomic ,strong)UIButton *orderingBtn;

@property (nonatomic,strong) UIButton *selectedBtn;


@property (nonatomic ,strong)WZXSelectClassModel *myModel;


@property (nonatomic, copy) void(^myBlock)();

- (void)setSelectColor:(BOOL)selectBool;
@end
