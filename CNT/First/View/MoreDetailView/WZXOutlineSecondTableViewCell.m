//
//  WZXOutlineSecondTableViewCell.m
//  CNT
//
//  Created by 王智鑫 on 2017/12/10.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXOutlineSecondTableViewCell.h"

@implementation WZXOutlineSecondTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubView];
    }
    return self;
}

- (void)createSubView {
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 * IPHONE6_WIDTH, 15 * IPHONE6_HEIGHT, 150 * IPHONE6_WIDTH, 20 * IPHONE6_HEIGHT)];
    _timeLabel.text = @"授课时间";
    _timeLabel.font = [UIFont systemFontOfSize:15 * IPHONE6_HEIGHT];
    [self addSubview:_timeLabel];
    
//    _contentL = [[UILabel alloc]initWithFrame:CGRectMake(100 * IPHONE6_WIDTH, 15*IPHONE6_HEIGHT, 300 * IPHONE6_WIDTH, 20 * IPHONE6_HEIGHT)];
//    _contentL.textAlignment = NSTextAlignmentRight;
//    _contentL.backgroundColor = [UIColor redColor];
//    _contentL.text = @"sdds";
//    _contentL.font = [UIFont systemFontOfSize:15 * IPHONE6_HEIGHT];
    _contentL = [[UILabel alloc]init];
    [self.contentView addSubview:_contentL];
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(-10);
//        make.width.mas_equalTo(100);
    }];
    _contentL.textAlignment = NSTextAlignmentRight;
//    _contentL.backgroundColor = [UIColor redColor];
    
    
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
