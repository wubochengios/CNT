//
//  WZXMyClassTableViewCell.m
//  CNT
//
//  Created by 王智鑫 on 2017/12/11.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXMyClassTableViewCell.h"

@implementation WZXMyClassTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubView];
        self.backgroundColor = [UIColor colorWithRed:241.0f/255.0f green:241.0f/255.0f blue:241.0f/255.0f alpha:1];
    }
    return self;
}

- (void)createSubView {
    //  背景
    _backView = [[UIView alloc] initWithFrame:CGRectMake(15 * IPHONE6_WIDTH, 10 * IPHONE6_HEIGHT, 345 * IPHONE6_WIDTH, 100 * IPHONE6_HEIGHT)];
    _backView.backgroundColor = [UIColor whiteColor];
    _backView.layer.cornerRadius = 8 * IPHONE6_WIDTH;
    _backView.layer.masksToBounds = YES;
    [self addSubview:_backView];
    // 左边的图片
    _leftImage = [UIImage imageNamed:@"banner2"];
    _leftImageView = [[UIImageView alloc] initWithImage:self.leftImage];
    _leftImageView.frame = CGRectMake(15 * IPHONE6_WIDTH, 10 * IPHONE6_HEIGHT, 100 * IPHONE6_WIDTH, 80 * IPHONE6_HEIGHT);
    _leftImageView.layer.cornerRadius = 4 * IPHONE6_WIDTH;
    _leftImageView.layer.masksToBounds = YES;
    [self.backView addSubview:self.leftImageView];
    //  titleLabel
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(118 * IPHONE6_WIDTH, 10 * IPHONE6_HEIGHT, 200 * IPHONE6_WIDTH, 15 * IPHONE6_HEIGHT)];
    _titleLabel.text = @"初中／高中汉语(1)";
    _titleLabel.font = [UIFont systemFontOfSize:13 * IPHONE6_WIDTH];
    [self.backView addSubview:_titleLabel];
    //  开课时间
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(118 * IPHONE6_WIDTH, 40 * IPHONE6_HEIGHT, 200 * IPHONE6_WIDTH, 15 * IPHONE6_HEIGHT)];
    _timeLabel.text = @"开课时间2017.10.1 10.30";
    _timeLabel.font = [UIFont systemFontOfSize:13 * IPHONE6_WIDTH];
    _timeLabel.textColor = [UIColor lightGrayColor];
    [self.backView addSubview:self.timeLabel];
    //  头像
    _headImage = [UIImage imageNamed:@"wang_touxiang_pressed"];
    _headImageView = [[UIImageView alloc] initWithImage:self.headImage];
    _headImageView.frame = CGRectMake(118 * IPHONE6_WIDTH, 60 * IPHONE6_HEIGHT, 30 * IPHONE6_WIDTH, 30 * IPHONE6_HEIGHT);
    _headImageView.layer.cornerRadius = 15 * IPHONE6_WIDTH;
    _headImageView.layer.masksToBounds = YES;
    [self.backView addSubview:_headImageView];
    //  老师姓名
    _teacherNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(155 * IPHONE6_WIDTH, 70 * IPHONE6_HEIGHT, 40 * IPHONE6_WIDTH, 15 * IPHONE6_HEIGHT)];
    _teacherNameLabel.text = @"王老师";
    _teacherNameLabel.font = [UIFont systemFontOfSize:13 * IPHONE6_WIDTH];
    [self.backView addSubview:self.teacherNameLabel];
    //  课程button
    _lessonButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_lessonButton setTitle:@"未上课程" forState:UIControlStateNormal];
    _lessonButton.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:88.0f/255.0f blue:95.0f/255.0f alpha:1];
    _lessonButton.frame = CGRectMake(275 * IPHONE6_WIDTH, 73 * IPHONE6_HEIGHT, 60 * IPHONE6_WIDTH, 20 * IPHONE6_HEIGHT);
    _lessonButton.layer.cornerRadius = 5 * IPHONE6_WIDTH;
    _lessonButton.layer.masksToBounds = YES;
    _lessonButton.titleLabel.font = [UIFont systemFontOfSize:12 * IPHONE6_WIDTH];
    [self.backView addSubview:self.lessonButton];
        
    
}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
