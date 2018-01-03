//
//  WZXMineHeadView.m
//  CNT
//
//  Created by 王智鑫 on 2017/11/14.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXMineHeadView.h"

@interface WZXMineHeadView ()

@property (nonatomic ,assign) RoleName roleName;
/**
 *  按钮选中,中间值
 */
@property (nonatomic,strong) UIButton *selectedBtn;

@end

@implementation WZXMineHeadView

- (instancetype) initWithRoleName:(RoleName)role {
    
    self = [super init];
    if (self) {
        [self createRoleSubView];
        self.frame = CGRectMake(0, 0, KWIDTH, 160 * AUTO_HEIGHT);
        
        if (role == RoleNameStudent) {
            [self createAppraisaLabel];
        } else {
            [self createStateButton];
        }
    } 
    return self;
}

- (void)createRoleSubView {
#pragma mark - 头像
    self.headImage = [UIImage imageNamed:@"content_icon_touxiang_01_default"];
    self.headImageView = [[UIImageView alloc] initWithImage:self.headImage];
    self.headImageView.frame = CGRectMake(17 * IPHONE6_WIDTH, 9 * IPHONE6_HEIGHT, 70 * IPHONE6_WIDTH, 70 * IPHONE6_HEIGHT);
    self.headImageView.clipsToBounds = YES;
    self.headImageView.layer.cornerRadius = 35 * AUTO_WIDTH;
    [self addSubview:self.headImageView];
#pragma mark - 名字
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(95 * IPHONE6_WIDTH, 20 * IPHONE6_HEIGHT, 100 * IPHONE6_WIDTH, 14 * IPHONE6_HEIGHT)];
    self.nameLabel.font = [UIFont systemFontOfSize:14 * IPHONE6_WIDTH];
    self.nameLabel.text = @"您好，同学";
    [self addSubview:_nameLabel];
#pragma mark - icon .. >
    self.iconImage = [UIImage imageNamed:@"content_icon_jiantou_default"];
    self.iconImageView = [[UIImageView alloc] initWithImage:self.iconImage];
    self.iconImageView.frame = CGRectMake(340 * IPHONE6_WIDTH, 30 * IPHONE6_HEIGHT, 5 * IPHONE6_WIDTH, 10 * IPHONE6_HEIGHT);
    [self addSubview:self.iconImageView];
    
#pragma mark - 累计上课 ... 两个
    self.classLabelFirst = [[UILabel alloc] initWithFrame:CGRectMake(40 * IPHONE6_WIDTH, 85 * IPHONE6_HEIGHT, 70 * IPHONE6_WIDTH, 10 * IPHONE6_HEIGHT)];
    self.classLabelFirst.textColor = [UIColor grayColor];
    self.classLabelFirst.text = @"累计上课";
    self.classLabelFirst.font = [UIFont systemFontOfSize:14 * IPHONE6_WIDTH];
    [self addSubview:self.classLabelFirst];
    
    self.classLabelSecond = [[UILabel alloc] initWithFrame:CGRectMake(40 * IPHONE6_WIDTH, 115 * IPHONE6_HEIGHT, 60 * IPHONE6_WIDTH, 10 * IPHONE6_HEIGHT)];
    self.classLabelSecond.text = @"0节";
    self.classLabelSecond.textAlignment = NSTextAlignmentCenter;
    self.classLabelSecond.font = [UIFont systemFontOfSize:17 * IPHONE6_WIDTH];
    [self addSubview:self.classLabelSecond];
    
#pragma mark - 累积说汉语 ... 两个
    self.speakLabelFirst = [[UILabel alloc] initWithFrame:CGRectMake(160 * IPHONE6_WIDTH, 85 * IPHONE6_HEIGHT, 80 * IPHONE6_WIDTH, 10 * IPHONE6_HEIGHT)];
    self.speakLabelFirst.textColor = [UIColor grayColor];
    self.speakLabelFirst.text = @"累计说汉语";
    self.speakLabelFirst.font = [UIFont systemFontOfSize:14 * IPHONE6_WIDTH];
    [self addSubview:self.speakLabelFirst];
    
    self.speakLabelSecond = [[UILabel alloc] initWithFrame:CGRectMake(160 * IPHONE6_WIDTH, 115 * IPHONE6_HEIGHT, 70 * IPHONE6_WIDTH, 10 * IPHONE6_HEIGHT)];
    self.speakLabelSecond.text = @"0小时";
    self.speakLabelSecond.textAlignment = NSTextAlignmentCenter;
    self.speakLabelSecond.font = [UIFont systemFontOfSize:17 * IPHONE6_WIDTH];
    [self addSubview:self.speakLabelSecond];
    
#pragma mark - 周目标 ... 两个
    self.weekLabelFirst = [[UILabel alloc] initWithFrame:CGRectMake(300 * IPHONE6_WIDTH, 85 * IPHONE6_HEIGHT, 60 * IPHONE6_WIDTH, 10 * IPHONE6_HEIGHT)];
    self.weekLabelFirst.textColor = [UIColor grayColor];
    self.weekLabelFirst.text = @"周目标";
    self.weekLabelFirst.font = [UIFont systemFontOfSize:14 * IPHONE6_WIDTH];
    [self addSubview:self.weekLabelFirst];
    
    self.weekLabelSeconds = [[UILabel alloc] initWithFrame:CGRectMake(300 * IPHONE6_WIDTH, 115 * IPHONE6_HEIGHT, 50 * IPHONE6_WIDTH, 10 * IPHONE6_HEIGHT)];
    self.weekLabelSeconds.text = @"0/5节";
    self.weekLabelSeconds.textAlignment = NSTextAlignmentCenter;
    self.weekLabelSeconds.font = [UIFont systemFontOfSize:17 * IPHONE6_WIDTH];
    [self addSubview:self.weekLabelSeconds];
    
#pragma mark - 创建透明button盖住个人信息
    self.presonalbigBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.presonalbigBtn.backgroundColor = [UIColor clearColor];
    self.presonalbigBtn.frame = CGRectMake(0, 0, KWIDTH, 79 * IPHONE6_HEIGHT);
    [self addSubview:self.presonalbigBtn];
    
}

#pragma mark - 学生创建未测评
- (void)createAppraisaLabel {
    self.appraisaLabel = [[UILabel alloc] initWithFrame:CGRectMake(95 * IPHONE6_WIDTH, 45 * IPHONE6_HEIGHT, 55 * IPHONE6_WIDTH, 20 * IPHONE6_HEIGHT)];
    self.appraisaLabel.font = [UIFont systemFontOfSize:14 * IPHONE6_WIDTH];
    self.appraisaLabel.textColor = [UIColor whiteColor];
    self.appraisaLabel.backgroundColor = [UIColor colorWithRed:255.0f/255.9f green:91.0f/255 blue:95.0f/255 alpha:0.8];
    self.appraisaLabel.textAlignment = NSTextAlignmentCenter;
    self.appraisaLabel.layer.cornerRadius = 5 * IPHONE6_HEIGHT;
    self.appraisaLabel.clipsToBounds = YES;
    self.appraisaLabel.text = @"未评测";
    [self addSubview:_appraisaLabel];
}

#pragma mark - 老师创建在线离线
- (void)createStateButton {
    self.onLineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.onLineBtn.frame = CGRectMake(95 * IPHONE6_WIDTH, 42 * IPHONE6_HEIGHT, 33 * IPHONE6_WIDTH, 18 * IPHONE6_HEIGHT);
    self.onLineBtn.backgroundColor = REDCOLOR;
    self.onLineBtn.layer.cornerRadius = 5 * IPHONE6_WIDTH;
    self.onLineBtn.clipsToBounds = YES;
    self.onLineBtn.tag = 100;
    self.onLineBtn.titleLabel.font = [UIFont systemFontOfSize:13 * IPHONE6_WIDTH];
    [self.onLineBtn setTitle:@"在线" forState:UIControlStateNormal];
    [self.onLineBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.onLineBtn addTarget:self action:@selector(onLineAndoffLineBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.onLineBtn];
    
    self.offLineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.offLineBtn.frame = CGRectMake(135 * IPHONE6_WIDTH, 42 * IPHONE6_HEIGHT, 33 * IPHONE6_WIDTH, 18 * IPHONE6_HEIGHT);
    self.offLineBtn.backgroundColor = [UIColor lightGrayColor];
    self.offLineBtn.layer.cornerRadius = 5 * IPHONE6_WIDTH;
    self.offLineBtn.clipsToBounds = YES;
    self.offLineBtn.tag = 101;
    self.offLineBtn.titleLabel.font = [UIFont systemFontOfSize:13 * IPHONE6_WIDTH];
    [self.offLineBtn setTitle:@"离线" forState:UIControlStateNormal];
    [self.offLineBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.offLineBtn addTarget:self action:@selector(onLineAndoffLineBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.offLineBtn];
}

- (void)onLineAndoffLineBtnAction:(UIButton *)btn {
    
    if (btn.tag == 100) {
        self.onLineBtn.backgroundColor = REDCOLOR;
        
        self.offLineBtn.backgroundColor = [UIColor lightGrayColor];
        NSString *idString = [self getRandomStringWithNum:8];
        [_delegate HeaderViewLogonAgora:idString];
        
        
        
    } else if (btn.tag == 101) {
        self.onLineBtn.backgroundColor = [UIColor lightGrayColor];
        
        self.offLineBtn.backgroundColor = REDCOLOR;
        [_delegate HeaderViewLonOutAgora];
                
    }
}




#pragma mark 生成随机数
- (NSString *)getRandomStringWithNum:(NSInteger)num
{
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < num; i++) {
        int number = arc4random() % 36;
        if (number < 10) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            string = [string stringByAppendingString:tempString];
        }else {
            int figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
        }
    }
    return string;
}











@end
