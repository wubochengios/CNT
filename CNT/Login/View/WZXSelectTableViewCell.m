//
//  WZXSelectTableViewCell.m
//  CNT
//
//  Created by 王智鑫 on 2017/12/2.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXSelectTableViewCell.h"
@implementation WZXSelectTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self createSubView];
    }
    return self;
}

- (void)createSubView {
    //钟表图片
    _clockImage = [UIImage imageNamed:@"content_icon_jiantou_pressed"];
    _clockImageView = [[UIImageView alloc] initWithImage:_clockImage];
    _clockImageView.frame = CGRectMake(20 * IPHONE6_WIDTH, 8 * IPHONE6_HEIGHT, 12 * IPHONE6_WIDTH, 12 * IPHONE6_HEIGHT);
    [self addSubview:_clockImageView];
    //大时间
    _firsClockLabel = [[UILabel alloc] initWithFrame:CGRectMake(40 * IPHONE6_WIDTH, 7 * IPHONE6_HEIGHT, 45 * IPHONE6_WIDTH, 15)];
    //_firsClockLabel.text = @"15:30";
    _firsClockLabel.font = [UIFont systemFontOfSize:15 * IPHONE6_HEIGHT];
    [self addSubview:_firsClockLabel];
    //小时间
    _secondClockLabel = [[UILabel alloc] initWithFrame:CGRectMake(88 * IPHONE6_WIDTH, 11 * IPHONE6_HEIGHT, 25 * IPHONE6_WIDTH, 15)];
    _secondClockLabel.textColor = [UIColor grayColor];
    _secondClockLabel.font = [UIFont systemFontOfSize:8 * IPHONE6_WIDTH];
    [self addSubview:_secondClockLabel];
    //结束时间
    _endLabel = [[UILabel alloc] initWithFrame:CGRectMake(114 * IPHONE6_WIDTH, 11 * IPHONE6_HEIGHT, 25 * IPHONE6_WIDTH, 15 * IPHONE6_HEIGHT)];
    _endLabel.text = @"结束";
    _endLabel.textColor = [UIColor grayColor];
    _endLabel.font = [UIFont systemFontOfSize:8 * IPHONE6_WIDTH];
    [self addSubview:_endLabel];
    //预约按钮
    _orderingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_orderingBtn setTitle:@"预约" forState:UIControlStateNormal];
    _orderingBtn.titleLabel.font = [UIFont systemFontOfSize:11 * IPHONE6_WIDTH];
    [_orderingBtn addTarget:self action:@selector(orderingAction:) forControlEvents:UIControlEventTouchUpInside];
    //边框宽度
    [_orderingBtn.layer setBorderWidth:0.5];
    _orderingBtn.layer.borderColor=[UIColor grayColor].CGColor;//边框颜色
    _orderingBtn.layer.cornerRadius = 10 * IPHONE6_HEIGHT;
    _orderingBtn.clipsToBounds = YES;
    _orderingBtn.frame = CGRectMake(250 * IPHONE6_WIDTH, 7 * IPHONE6_HEIGHT, 40 * IPHONE6_WIDTH, 19);
    [_orderingBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:_orderingBtn];
    
}
- (void)orderingAction:(UIButton *)sender{



    if (_myBlock) {
        _myBlock();
    }
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
