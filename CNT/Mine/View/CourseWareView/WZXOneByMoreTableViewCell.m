//
//  WZXOneByMoreTableViewCell.m
//  CNT
//
//  Created by 王智鑫 on 2017/11/15.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXOneByMoreTableViewCell.h"

@implementation WZXOneByMoreTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self createSubView];
    }
    return self;
}

- (void)createSubView {
    
    self.bigImage = [UIImage imageNamed:@"content_icon_tupian_04_pressed"];
    self.bigImageView = [[UIImageView alloc] initWithImage:self.bigImage];
    self.bigImageView.frame = CGRectMake(20 * IPHONE6_WIDTH, 25 * IPHONE6_HEIGHT, 335 * IPHONE6_WIDTH, 90 * IPHONE6_HEIGHT);
    self.bigImageView.backgroundColor = [UIColor redColor];
    [self addSubview:self.bigImageView];
    
    self.classLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 * IPHONE6_WIDTH, 80 * IPHONE6_HEIGHT, 335 * IPHONE6_WIDTH, 30 * IPHONE6_HEIGHT)];
    self.classLabel.text = @"麻痹的还看不起病～！！！！";
    self.classLabel.font = [UIFont systemFontOfSize:14 * IPHONE6_WIDTH];
    self.classLabel.textAlignment = NSTextAlignmentCenter;
    self.classLabel.textColor = [UIColor whiteColor];
    self.classLabel.backgroundColor = [UIColor colorWithRed:178.0f/255.0f green:178.0f/255.0f blue:178.0f/255.0f alpha:0.5];
    [self addSubview:self.classLabel];
    
    
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
