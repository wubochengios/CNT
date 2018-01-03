//
//  WZXOutlineFirstTableViewCell.m
//  CNT
//
//  Created by 王智鑫 on 2017/12/10.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXOutlineFirstTableViewCell.h"

@implementation WZXOutlineFirstTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubView];
    }
    return self;
}

- (void)createSubView {
    
    _teacherNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 * IPHONE6_WIDTH, 13 * IPHONE6_HEIGHT, 150 * IPHONE6_WIDTH, 20 * IPHONE6_HEIGHT)];
    _teacherNameLabel.text = @"授课老师";
    _teacherNameLabel.font = [UIFont systemFontOfSize:15 * IPHONE6_HEIGHT];
    [self addSubview:_teacherNameLabel];
    
 //   _headImage = [UIImage imageNamed:@"wang_touxiang_pressed"];
    _headImageView = [[UIImageView alloc] initWithImage:_headImage];
    _headImageView.frame = CGRectMake(230 * IPHONE6_WIDTH, 11 * IPHONE6_HEIGHT, 25 * IPHONE6_WIDTH, 25 * IPHONE6_HEIGHT);
    [self addSubview:self.headImageView];
    
    _selectLabel = [[UILabel alloc] initWithFrame:CGRectMake(257* IPHONE6_WIDTH, 13 * IPHONE6_HEIGHT, 80 * IPHONE6_WIDTH, 20 * IPHONE6_HEIGHT)];
    _selectLabel.text = @"选择";
    _selectLabel.textAlignment = NSTextAlignmentRight;
    _selectLabel.font = [UIFont systemFontOfSize:13 * IPHONE6_HEIGHT];
    [self addSubview:self.selectLabel];
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
