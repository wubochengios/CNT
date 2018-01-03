//
//  WZXYoungDetailView.m
//  CNT
//
//  Created by 王智鑫 on 2017/12/6.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXYoungDetailView.h"

@implementation WZXYoungDetailView

- (instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubView];
    }
    return self;
}

- (void) createSubView {
    
    //  头像
    _headImage = [UIImage imageNamed:@"content_icon_touxiang_01_default"];
    _headImageView = [[UIImageView alloc] initWithImage:_headImage];
    _headImageView.frame = CGRectMake(150 * IPHONE6_WIDTH, 12 * IPHONE6_HEIGHT, 65 * IPHONE6_WIDTH, 65 * IPHONE6_HEIGHT);
    _headImageView.layer.cornerRadius = 32.5 * IPHONE6_HEIGHT;
    _headImageView.clipsToBounds = YES;
    [self addSubview:_headImageView];
    //  姓名
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(132.5 * IPHONE6_WIDTH, 80  * IPHONE6_HEIGHT, 100 * IPHONE6_WIDTH, 20 * IPHONE6_HEIGHT)];
    //_nameLabel.text = @"王老师";
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.font = [UIFont systemFontOfSize:16 * IPHONE6_WIDTH];
    [self addSubview:_nameLabel];
    //  横线
    _lightView = [[UIView alloc] initWithFrame:CGRectMake(0, 110 * IPHONE6_HEIGHT, KWIDTH, 10 * IPHONE6_HEIGHT)];
    _lightView.backgroundColor = [UIColor colorWithRed:237.0f/255.0f green:237.0f/255.0f blue:237.0f/255.0f alpha:1];
    [self addSubview:_lightView];
    //  教学评分 - 字和显示
    _scoreFirstLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 * IPHONE6_WIDTH, 135  * IPHONE6_HEIGHT, 70 * IPHONE6_WIDTH, 20 * IPHONE6_HEIGHT)];
    _scoreFirstLabel.text = @"教学评分";
    _scoreFirstLabel.textAlignment = NSTextAlignmentCenter;
    _scoreFirstLabel.font = [UIFont systemFontOfSize:16 * IPHONE6_WIDTH];
    [self addSubview:_scoreFirstLabel];
    
    _scoreSecondLabel = [[UILabel alloc] initWithFrame:CGRectMake(105 * IPHONE6_WIDTH, 135  * IPHONE6_HEIGHT, 100 * IPHONE6_WIDTH, 20 * IPHONE6_HEIGHT)];
    //_scoreSecondLabel.text = @"108分";
    _scoreSecondLabel.textColor = [UIColor grayColor];
    _scoreSecondLabel.font = [UIFont systemFontOfSize:13 * IPHONE6_WIDTH];
    [self addSubview:_scoreSecondLabel];
    
    //  上课形式 - 字和显示
    _lessonFirstLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 * IPHONE6_WIDTH, 175  * IPHONE6_HEIGHT, 70 * IPHONE6_WIDTH, 20 * IPHONE6_HEIGHT)];
    _lessonFirstLabel.text = @"上课形式";
    _lessonFirstLabel.textAlignment = NSTextAlignmentCenter;
    _lessonFirstLabel.font = [UIFont systemFontOfSize:16 * IPHONE6_WIDTH];
    [self addSubview:_lessonFirstLabel];
    
    _lessonSecondLabel = [[UILabel alloc] initWithFrame:CGRectMake(105 * IPHONE6_WIDTH, 175  * IPHONE6_HEIGHT, 100 * IPHONE6_WIDTH, 20 * IPHONE6_HEIGHT)];
    //_lessonSecondLabel.text = @"1对1教学";
    _lessonSecondLabel.textColor = [UIColor grayColor];
    _lessonSecondLabel.font = [UIFont systemFontOfSize:13 * IPHONE6_WIDTH];
    [self addSubview:_lessonSecondLabel];
    
    //  合适人群 - 字和显示
    _crowdFirstLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 * IPHONE6_WIDTH, 215  * IPHONE6_HEIGHT, 70 * IPHONE6_WIDTH, 20 * IPHONE6_HEIGHT)];
    _crowdFirstLabel.text = @"适合人群";
    _crowdFirstLabel.textAlignment = NSTextAlignmentCenter;
    _crowdFirstLabel.font = [UIFont systemFontOfSize:16 * IPHONE6_WIDTH];
    [self addSubview:_crowdFirstLabel];
    
    _crowdSecondLabel = [[UILabel alloc] initWithFrame:CGRectMake(105 * IPHONE6_WIDTH, 215  * IPHONE6_HEIGHT, 100 * IPHONE6_WIDTH, 20 * IPHONE6_HEIGHT)];
    //_crowdSecondLabel.text = @"Junior初级学员";
    _crowdSecondLabel.textColor = [UIColor grayColor];
    _crowdSecondLabel.font = [UIFont systemFontOfSize:13 * IPHONE6_WIDTH];
    [self addSubview:_crowdSecondLabel];
    
    //  价格课程 - 字和显示
    _priceFirstLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 * IPHONE6_WIDTH, 255  * IPHONE6_HEIGHT, 70 * IPHONE6_WIDTH, 20 * IPHONE6_HEIGHT)];
    _priceFirstLabel.text = @"价格课程";
    _priceFirstLabel.textAlignment = NSTextAlignmentCenter;
    _priceFirstLabel.font = [UIFont systemFontOfSize:16 * IPHONE6_WIDTH];
    [self addSubview:_priceFirstLabel];
    
    _priceSecondLabel = [[UILabel alloc] initWithFrame:CGRectMake(105 * IPHONE6_WIDTH, 255  * IPHONE6_HEIGHT, 100 * IPHONE6_WIDTH, 20 * IPHONE6_HEIGHT)];
    _priceSecondLabel.text = @"1250豆／25分钟";
    _priceSecondLabel.textColor = [UIColor grayColor];
    _priceSecondLabel.font = [UIFont systemFontOfSize:13 * IPHONE6_WIDTH];
    [self addSubview:_priceSecondLabel];
    
    //  自我介绍 - 字和显示
    _selfintroductionFirstLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 * IPHONE6_WIDTH, 295  * IPHONE6_HEIGHT, 70 * IPHONE6_WIDTH, 20 * IPHONE6_HEIGHT)];
    _selfintroductionFirstLabel.text = @"自我介绍";
    _selfintroductionFirstLabel.textAlignment = NSTextAlignmentCenter;
    _selfintroductionFirstLabel.font = [UIFont systemFontOfSize:16 * IPHONE6_WIDTH];
    [self addSubview:_selfintroductionFirstLabel];
    
    _selfintroductionSecondLabel = [[UILabel alloc] initWithFrame:CGRectMake(105 * IPHONE6_WIDTH, 297  * IPHONE6_HEIGHT, 250 * IPHONE6_WIDTH, 140 * IPHONE6_HEIGHT)];
    //_selfintroductionSecondLabel.text = @"1250豆／25分钟sssssdsadasdasdsadsadasdsadasdasdasdasdsadasdasdadasdasd圣诞节撒。 圣诞节i 阿萨德技术ID叫阿斯竞赛就能设计大赛德累斯顿洛杉矶离开倒计时 啊上课嘉陵道街拉开。 的 的sad就是大家撒到家";
    //_selfintroductionSecondLabel.backgroundColor = [UIColor yellowColor];
    _selfintroductionSecondLabel.numberOfLines = 0;
    _selfintroductionSecondLabel.textColor = [UIColor grayColor];
    _selfintroductionSecondLabel.font = [UIFont systemFontOfSize:13 * IPHONE6_WIDTH];
    [_selfintroductionSecondLabel sizeToFit];
    [self addSubview:_selfintroductionSecondLabel];
    
    //  自我介绍 - 字和显示
    _commentsFirstLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 * IPHONE6_WIDTH, 430  * IPHONE6_HEIGHT, 70 * IPHONE6_WIDTH, 20 * IPHONE6_HEIGHT)];
    _commentsFirstLabel.text = @"华说评语";
    _commentsFirstLabel.textAlignment = NSTextAlignmentCenter;
    _commentsFirstLabel.font = [UIFont systemFontOfSize:16 * IPHONE6_WIDTH];
    [self addSubview:_commentsFirstLabel];
    
    _commentsSecondLabel = [[UILabel alloc] initWithFrame:CGRectMake(105 * IPHONE6_WIDTH, 432  * IPHONE6_HEIGHT, 250 * IPHONE6_WIDTH, 140 * IPHONE6_HEIGHT)];
    //_commentsSecondLabel.text = @"此课程系列适合 3 ～ 12 岁或者同等水平儿童。英语说结合大量的教学实践，理论研究、线上测试和师生调研，激发学生兴趣，满足了实际交际运用的需求。";
    //_commentsSecondLabel.backgroundColor = [UIColor yellowColor];
    _commentsSecondLabel.numberOfLines = 0;
    _commentsSecondLabel.textColor = [UIColor grayColor];
    _commentsSecondLabel.font = [UIFont systemFontOfSize:13 * IPHONE6_WIDTH];
    
    [self addSubview:_commentsSecondLabel];
    
    //  预约button
    _orderingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _orderingBtn.frame = CGRectMake(53 * IPHONE6_WIDTH, 550  * IPHONE6_HEIGHT, 269 * IPHONE6_WIDTH, 40  * IPHONE6_HEIGHT);
    _orderingBtn.backgroundColor = REDCOLOR;
    [_orderingBtn setTitle:@"立即预约" forState:UIControlStateNormal];
    [_orderingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _orderingBtn.layer.cornerRadius = 20 * IPHONE6_HEIGHT;
    _orderingBtn.clipsToBounds = YES;
    _orderingBtn.titleLabel.font = [UIFont systemFontOfSize:17 * IPHONE6_WIDTH];
    [self addSubview:_orderingBtn];
    
}
#pragma mark - 给model附值
- (void)setModel:(WZXTeacherDetailModel *)model {
    [_headImageView yy_setImageWithURL:[NSURL URLWithString:model.image] placeholder:placeholderStr];
    self.nameLabel.text = model.realname;// 名字
    self.scoreSecondLabel.text = [NSString stringWithFormat:@"%ld分",(long)model.grade];//    评分
    self.commentsSecondLabel.text = model.hsEstimate;   //  华说评语
    [_commentsSecondLabel sizeToFit];//  label文字置顶。
    self.crowdSecondLabel.text = model.suitType;//  适合类型    如 “适合初级学者”
    self.selfintroductionSecondLabel.text = model.selfAssessment;// 自我评价
    [_selfintroductionSecondLabel sizeToFit];//  label文字置顶。
}




@end
