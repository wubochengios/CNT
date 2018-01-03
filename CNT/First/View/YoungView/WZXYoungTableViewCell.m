//
//  WZXYoungTableViewCell.m
//  CNT
//
//  Created by 王智鑫 on 2017/12/6.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXYoungTableViewCell.h"

@implementation WZXYoungTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubView];
    }
    return self;
}

- (void)createSubView {
    
    //  预约老师头像
    _headImage = [UIImage imageNamed:@"content_touxiang_default"];
    _headImageView = [[UIImageView alloc] initWithImage:_headImage];
    _headImageView.frame = CGRectMake(15 * IPHONE6_WIDTH, 7 * IPHONE6_HEIGHT, 50 * IPHONE6_WIDTH, 50 * IPHONE6_HEIGHT);
    _headImageView.layer.cornerRadius = 25 * IPHONE6_WIDTH;
    _headImageView.clipsToBounds = YES;
    [self addSubview:_headImageView];
    
    //  姓名
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(75 * IPHONE6_WIDTH, 16 * IPHONE6_HEIGHT, 80 * IPHONE6_WIDTH, 15 * IPHONE6_HEIGHT)];
    _nameLabel.text = @"王老师";
    _nameLabel.font = [UIFont systemFontOfSize:13 * IPHONE6_WIDTH];
    [self addSubview:_nameLabel];
    
    //  评分
    _scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(158 * IPHONE6_WIDTH, 18 * IPHONE6_HEIGHT, 50 * IPHONE6_WIDTH, 10 * IPHONE6_HEIGHT)];
    _scoreLabel.textColor = [UIColor redColor];
    _scoreLabel.text = @"100.0评分";
    _scoreLabel.font = [UIFont systemFontOfSize:10 * IPHONE6_WIDTH];
    [self addSubview:_scoreLabel];
    
    //  适合程度
    _levelLabel = [[UILabel alloc] initWithFrame:CGRectMake(75 * IPHONE6_WIDTH, 41 * IPHONE6_HEIGHT, 200 * IPHONE6_WIDTH, 10 * IPHONE6_HEIGHT)];
    _levelLabel.text = @"合适中级学者";
    _levelLabel.textColor = [UIColor grayColor];
    _levelLabel.font = [UIFont systemFontOfSize:8 * IPHONE6_WIDTH];
    [self addSubview:_levelLabel];
    
    
    
    //  预约按钮
    _orderingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_orderingBtn setTitle:@"预约" forState:UIControlStateNormal];
    _orderingBtn.titleLabel.font = [UIFont systemFontOfSize:11 * IPHONE6_WIDTH];
    [_orderingBtn.layer setBorderWidth:0.5];//  边框宽度
    _orderingBtn.layer.borderColor=[UIColor grayColor].CGColor;//   边框颜色
    _orderingBtn.layer.cornerRadius = 13 * IPHONE6_HEIGHT;
    _orderingBtn.clipsToBounds = YES;
    _orderingBtn.frame = CGRectMake(300 * IPHONE6_WIDTH, 20 * IPHONE6_HEIGHT, 50 * IPHONE6_WIDTH, 24 * IPHONE6_HEIGHT);
    [_orderingBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:_orderingBtn];
}

- (void)setMyModel:(WZXYoungModel *)myModel{
    [_headImageView yy_setImageWithURL:[NSURL URLWithString:myModel.image] placeholder:placeholderStr];
    _nameLabel.text = myModel.realname;
    _scoreLabel.text = [NSString stringWithFormat:@"%ld分",myModel.grade];
    _levelLabel.text = myModel.presentation;
    
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
