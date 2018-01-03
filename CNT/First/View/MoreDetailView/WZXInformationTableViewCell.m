//
//  WZXInformationTableViewCell.m
//  CNT
//
//  Created by 王智鑫 on 2017/12/10.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXInformationTableViewCell.h"



@implementation WZXInformationTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubView];
    }
    return self;
}

- (void)createSubView {
    self.titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(15 * IPHONE6_WIDTH, 3 *IPHONE6_HEIGHT, KWIDTH - 15*2 * IPHONE6_WIDTH, 30 * IPHONE6_HEIGHT)];
    self.titlelabel.text = @"ssssss";
    self.titlelabel.font = [UIFont systemFontOfSize:15 * IPHONE6_HEIGHT];

    [self.contentView addSubview:self.titlelabel];
    
    self.lightView = [[UIView alloc]initWithFrame:CGRectMake(0, 30 * IPHONE6_HEIGHT  , KWIDTH, 1)];
    [self.contentView addSubview:self.lightView];
    self.lightView.backgroundColor = [UIColor lightGrayColor];
    
    self.detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(15* IPHONE6_WIDTH,(1 + 30 + 32/2 )* IPHONE6_HEIGHT, self.frame.size.width - 15 * 2 *IPHONE6_WIDTH , 0 * IPHONE6_HEIGHT)];
    self.detailLabel.text = @"当年我 i 都能懂女郎那份 vi 军方 v 电脑里都是你从来都是女女哪里呢超能力的少年老成你打算离开 v 从那女超能力的开始吧 v 啊我好了螚卡的虐和 v 列举了难道你不叫阿尔鹏哥 v 居然饿结果女来饿俩合伙佛教哦烹饪区警方破拒绝；阿警方破；叫我拍；飞机票；ejvnnavlnvlnelanaelivjh列举了难道你不叫阿尔鹏哥 v 居然饿结果女来饿俩合伙佛教哦烹饪区警方破拒绝；阿警方破；叫我拍；飞机票；ejvnnavlnvlnelanaelivjh";
    self.detailLabel.numberOfLines = 0;
    self.detailLabel.font = [UIFont systemFontOfSize:12 * IPHONE6_HEIGHT];
    [self.detailLabel sizeToFit];

    [self.contentView addSubview:self.detailLabel];
    
    
}
- (void)setContentStr:(NSString *)contentStr{
    self.detailLabel.frame = CGRectMake(15* IPHONE6_WIDTH,(1 + 30 + 32/2 )* IPHONE6_HEIGHT, self.frame.size.width - 15 * 2 *IPHONE6_WIDTH , 0 * IPHONE6_HEIGHT);
    self.detailLabel.text = contentStr;
    self.detailLabel.numberOfLines = 0;
    [self.detailLabel sizeToFit];
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
