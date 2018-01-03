//
//  WZXClassTimeTableViewCell.m
//  CNT
//
//  Created by 王智鑫 on 2017/11/17.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXClassTimeTableViewCell.h"

@implementation WZXClassTimeTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubView];
    }
    return self;
}

- (void)createSubView {
    //红色
    self.redTitlelabel = [[UILabel alloc] initWithFrame:CGRectMake(20 * IPHONE6_WIDTH, 15, 60 * IPHONE6_WIDTH, 20)];
    self.redTitlelabel.text = @"实用汉语";
    self.redTitlelabel.textColor = [UIColor whiteColor];
    self.redTitlelabel.font = [UIFont systemFontOfSize:12 * IPHONE6_WIDTH];
    self.redTitlelabel.backgroundColor = REDCOLOR;
    self.redTitlelabel.textAlignment = NSTextAlignmentCenter;
    self.redTitlelabel.layer.cornerRadius = 6 * IPHONE6_WIDTH;
    self.redTitlelabel.clipsToBounds = YES;
    [self addSubview:self.redTitlelabel];
    //我爱汉语
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(90 * IPHONE6_WIDTH, 15, 70 * IPHONE6_WIDTH, 20)];
    self.nameLabel.text = @"我爱汉语";
    self.nameLabel.font = [UIFont systemFontOfSize:16 * IPHONE6_WIDTH];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.nameLabel];
    //开课时间
    self.openClassLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 * IPHONE6_WIDTH, 50, 70 * IPHONE6_WIDTH, 20)];
    self.openClassLabel.text = @"开课时间 : ";
    self.openClassLabel.textColor = [UIColor grayColor];
    self.openClassLabel.font = [UIFont systemFontOfSize:13 * IPHONE6_WIDTH];
    self.openClassLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.openClassLabel];
    //开课时间2
    self.openTimelabel = [[UILabel alloc] initWithFrame:CGRectMake(90 * IPHONE6_WIDTH, 50, 200 * IPHONE6_WIDTH, 20)];
    self.openTimelabel.text = @"2017.10.16    6:30";
    self.openTimelabel.textAlignment = NSTextAlignmentLeft;
    self.openTimelabel.textColor = [UIColor grayColor];
    self.openTimelabel.font = [UIFont systemFontOfSize:13 * IPHONE6_WIDTH];
    [self addSubview:self.openTimelabel];
    //1对几
    self.situationLabel = [[UILabel alloc] initWithFrame:CGRectMake(300 * IPHONE6_WIDTH, 15, 60 * IPHONE6_WIDTH, 20)];
    self.situationLabel.textColor = [UIColor grayColor];
    self.situationLabel.text = @"1对1";
    self.situationLabel.textAlignment = NSTextAlignmentCenter;
    self.situationLabel.font = [UIFont systemFontOfSize:13 * IPHONE6_WIDTH];
    [self addSubview:self.situationLabel];
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
