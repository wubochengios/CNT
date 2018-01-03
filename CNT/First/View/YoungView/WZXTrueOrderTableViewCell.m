//
//  WZXTrueOrderTableViewCell.m
//  CNT
//
//  Created by 王智鑫 on 2017/12/12.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXTrueOrderTableViewCell.h"

@implementation WZXTrueOrderTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubView];
    }
    return self;
}

- (void)createSubView {
    _orderLabel = [[UILabel alloc] initWithFrame:CGRectMake(180 * IPHONE6_WIDTH, 12, KWIDTH/2, 20 * IPHONE6_HEIGHT)];
    _orderLabel.text = @"我爱汉语课程(1)";
    _orderLabel.font = [UIFont systemFontOfSize:14 * IPHONE6_HEIGHT];
    _orderLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.orderLabel];
    
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
