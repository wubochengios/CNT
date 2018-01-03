//
//  WZXSelectClassDetailTableViewCell.m
//  CNT
//
//  Created by 王智鑫 on 2017/12/7.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXSelectClassDetailTableViewCell.h"

@implementation WZXSelectClassDetailTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubView];
    }
    return self;
}

- (void)createSubView {
    //  课程列表名称
    _classLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 * IPHONE6_WIDTH, 15 * IPHONE6_HEIGHT, 150 * IPHONE6_WIDTH, 20 * IPHONE6_HEIGHT)];
    _classLabel.text = @"我爱汉语课程（1）";
    _classLabel.font = [UIFont systemFontOfSize:15 * IPHONE6_HEIGHT];
    [self addSubview:_classLabel];
    
    //  选择课程的click图片
    _clickImage = [UIImage imageNamed:@"con_check_default"];
//    _clickImage = [UIImage imageNamed:@"con_check_pressed"];
    _clickImageView = [[UIImageView alloc] initWithImage:_clickImage];
    _clickImageView.frame = CGRectMake(340 * IPHONE6_WIDTH, 15 *IPHONE6_HEIGHT, 20 * IPHONE6_WIDTH, 20 * IPHONE6_HEIGHT);
    [self addSubview:_clickImageView];
    
}

- (void)setModel:(WZXSelectSmallClassModel *)model {
    
    self.classLabel.text = model.courseName;
}

- (void)setSelectChangeColor:(BOOL)select{
    if (select == YES) {
        _clickImageView.image = [UIImage imageNamed:@"con_check_pressed"];
    }else{
        _clickImageView.image = [UIImage imageNamed:@"con_check_default"];
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
