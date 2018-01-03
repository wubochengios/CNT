//
//  WZXYoungSelectClassTableViewCell.m
//  CNT
//
//  Created by 王智鑫 on 2017/12/6.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXYoungSelectClassTableViewCell.h"

@implementation WZXYoungSelectClassTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubView];
    }
    return self;
}
- (void)createSubView {
    //  背景大红
    _bigView = [[UIView alloc] initWithFrame:CGRectMake(15 * IPHONE6_WIDTH, 5  * IPHONE6_HEIGHT, 345 * IPHONE6_WIDTH, 96  * IPHONE6_HEIGHT)];
    _bigView.backgroundColor = [UIColor colorWithRed:249.0f/255.0f green:84.0f/255.0f blue:88.0f/255.0f alpha:1];
    _bigView.layer.cornerRadius = 10 * IPHONE6_HEIGHT;
    [self addSubview:_bigView];
    //  名称
    _titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(13 * IPHONE6_WIDTH, 10  * IPHONE6_HEIGHT, 150 * IPHONE6_WIDTH, 20 * IPHONE6_HEIGHT)];
    _titlelabel.text = @"我爱汉语";
    //_titlelabel.backgroundColor = [UIColor yellowColor];
    _titlelabel.textColor = [UIColor whiteColor];
    _titlelabel.font = [UIFont systemFontOfSize:16 * IPHONE6_WIDTH];
    [_bigView addSubview:_titlelabel];
    //  内容
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(13 * IPHONE6_WIDTH, 33  * IPHONE6_HEIGHT, 319 * IPHONE6_WIDTH, 30 * IPHONE6_HEIGHT)];
    _contentLabel.text = @"我爱韩语课程是充满爱和欢乐的幼儿韩语系统课程，适合对象为幼儿园 小中大班。";
//    _contentLabel.backgroundColor = [UIColor yellowColor];
    _contentLabel.textColor = [UIColor whiteColor];
    _contentLabel.font = [UIFont systemFontOfSize:11 * IPHONE6_WIDTH];
    _contentLabel.numberOfLines = 0;
    [_bigView addSubview:_contentLabel];
    //  横线
    _lightView = [[UIView alloc] initWithFrame:CGRectMake(13 * IPHONE6_WIDTH, 64 * IPHONE6_HEIGHT, KWIDTH, 1 * IPHONE6_WIDTH)];
    _lightView.backgroundColor = [UIColor whiteColor];
    [_bigView addSubview:_lightView];
    //  麦克风图片
    
    //多少豆每分钟label
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(220 * IPHONE6_WIDTH, 75  * IPHONE6_HEIGHT, 150 * IPHONE6_WIDTH, 15  * IPHONE6_HEIGHT)];
    _priceLabel.text = @"1250豆／25分钟";
    _priceLabel.font = [UIFont systemFontOfSize:13 * IPHONE6_WIDTH];
    _priceLabel.textColor = [UIColor whiteColor];
    [_bigView addSubview:_priceLabel];
}

- (void)setModel:(WZXYoungSelectClassModel *)model {
    
    self.titlelabel.text = model.courseName;    //课程名称
    self.contentLabel.text = model.intro;       //课程介绍
    [_contentLabel sizeToFit];

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
