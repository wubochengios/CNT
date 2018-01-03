//
//  WZXIncomeDetailTableViewCell.m
//  CNT
//
//  Created by 王智鑫 on 2017/11/17.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXIncomeDetailTableViewCell.h"

@implementation WZXIncomeDetailTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubView];
    }
    return self;
}

- (void)createSubView {
    //我爱汉语
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 * IPHONE6_WIDTH, 15 * IPHONE6_HEIGHT, 70 * IPHONE6_WIDTH, 20 * IPHONE6_HEIGHT)];
    self.nameLabel.text = @"我爱汉语";
    self.nameLabel.font = [UIFont systemFontOfSize:16 * IPHONE6_WIDTH];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.nameLabel];
    //时间
    self.timelabel = [[UILabel alloc] initWithFrame:CGRectMake(20 * IPHONE6_WIDTH, 50 * IPHONE6_HEIGHT, 200 * IPHONE6_WIDTH, 20 * IPHONE6_HEIGHT)];
    self.timelabel.text = @"2017.10.16    6:30";
    self.timelabel.textAlignment = NSTextAlignmentLeft;
    self.timelabel.textColor = [UIColor grayColor];
    self.timelabel.font = [UIFont systemFontOfSize:13 * IPHONE6_WIDTH];
    [self addSubview:self.timelabel];
    //1对几
    self.situationLabel = [[UILabel alloc] initWithFrame:CGRectMake(300 * IPHONE6_WIDTH, 15 * IPHONE6_HEIGHT, 50 * IPHONE6_WIDTH, 20 * IPHONE6_HEIGHT)];
    self.situationLabel.textColor = [UIColor whiteColor];
    self.situationLabel.font = [UIFont systemFontOfSize:13 * IPHONE6_WIDTH];
    self.situationLabel.backgroundColor = REDCOLOR;
    self.situationLabel.layer.cornerRadius = 10 * IPHONE6_WIDTH;
    self.situationLabel.clipsToBounds = YES;
    self.situationLabel.text = @"1对1";
    self.situationLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.situationLabel];
    //钱
    self.moneylabel = [[UILabel alloc] initWithFrame:CGRectMake(300 * IPHONE6_WIDTH, 50 * IPHONE6_HEIGHT, 50 * IPHONE6_WIDTH, 20 * IPHONE6_HEIGHT)];
    self.moneylabel.font = [UIFont systemFontOfSize:15 * IPHONE6_WIDTH];
    self.moneylabel.text = @"+300";
    self.moneylabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.moneylabel];
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
