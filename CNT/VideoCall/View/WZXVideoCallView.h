//
//  WZXVideoCallView.h
//  CNT
//
//  Created by 王智鑫 on 2017/12/23.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZXVideoCallView : UIView

@property (nonatomic ,strong) UIImageView *bigImageView;

@property (nonatomic ,strong)UIImage *headImage;
@property (nonatomic ,strong)UIImageView *headImageView;

@property (nonatomic ,strong)UILabel *nameLabel;
@property (nonatomic ,strong)UILabel *describeLabel;

@property (nonatomic ,strong)UIButton *endButton;
@property (nonatomic ,strong)UILabel *endLabel;

@property (nonatomic ,strong)UIButton *startButton;
@property (nonatomic ,strong)UILabel *startLabel;


@end
