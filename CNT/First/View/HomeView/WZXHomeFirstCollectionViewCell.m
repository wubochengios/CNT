//
//  WZXHomeFirstCollectionViewCell.m
//  CNT
//
//  Created by 王智鑫 on 2017/11/9.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXHomeFirstCollectionViewCell.h"

@implementation WZXHomeFirstCollectionViewCell

- (instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
    
        self.backgroundColor = [UIColor whiteColor];
        [self createSubView];
    }
    return self;
}

- (void)createSubView {
#pragma mark -  青少年汉语 + 英文
    self.youngBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.youngBtn.frame = CGRectMake(20 * AUTO_WIDTH, 10 * AUTO_HEIGHT, 69 * AUTO_WIDTH, 69 * AUTO_HEIGHT);
    [self.youngBtn setImage:[UIImage imageNamed:@"content_icon_juveniles_pressed"] forState:UIControlStateNormal];
    [self.youngBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.youngBtn setTitle:@"青少年汉语" forState:UIControlStateNormal];
    self.youngBtn.titleEdgeInsets = UIEdgeInsetsMake(((self.youngBtn.frame.size.height / 2) * AUTO_WIDTH), (-(self.youngBtn.frame.size.height * 1.25) * AUTO_HEIGHT), 0, (-(self.youngBtn.frame.size.height / 2) * AUTO_HEIGHT));
    self.youngBtn.titleLabel.font = [UIFont systemFontOfSize:13 * AUTO_WIDTH];//title字体大小
    self.youngBtn.imageEdgeInsets = UIEdgeInsetsMake(-(self.youngBtn.frame.size.height / 2), 0, 0,-(self.youngBtn.frame.size.height));
    [self.youngBtn setTitleColor:[UIColor colorWithRed:0.631 green:0.635 blue:0.631 alpha:1.000] forState:UIControlStateNormal];
    [self addSubview:self.youngBtn];
    
    UILabel *youngLabel = [[UILabel alloc] initWithFrame:CGRectMake(25 * AUTO_WIDTH, 70 * AUTO_HEIGHT, 69 * AUTO_WIDTH, 20 * AUTO_HEIGHT)];
    youngLabel.text = @"Jnvenlies";
    youngLabel.textColor = [UIColor colorWithRed:174.0f/255.0f green:174.0f/255.0f blue:174.0f/162.0f alpha:1];
    youngLabel.font = [UIFont systemFontOfSize:13 * AUTO_HEIGHT];
    [self addSubview:youngLabel];
    
#pragma mark -  成人英语 + 英文
    self.adultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.adultBtn.frame = CGRectMake(119 * AUTO_WIDTH, 10 * AUTO_HEIGHT, 69 * AUTO_WIDTH, 69 * AUTO_HEIGHT);
    [self.adultBtn setImage:[UIImage imageNamed:@"content_icon_adult_pressed"] forState:UIControlStateNormal];
    [self.adultBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.adultBtn setTitle:@"成人英语" forState:UIControlStateNormal];
    self.adultBtn.titleEdgeInsets = UIEdgeInsetsMake(self.youngBtn.frame.size.height / 2, -(self.youngBtn.frame.size.height * 1.25), 0, -(self.youngBtn.frame.size.height / 2));
    self.adultBtn.titleLabel.font = [UIFont systemFontOfSize:13 * AUTO_WIDTH];//title字体大小
    self.adultBtn.imageEdgeInsets = UIEdgeInsetsMake(-(self.youngBtn.frame.size.height / 2), 0, 0,-(self.youngBtn.frame.size.height));
    [self.adultBtn setTitleColor:[UIColor colorWithRed:0.631 green:0.635 blue:0.631 alpha:1.000] forState:UIControlStateNormal];
    [self addSubview:self.adultBtn];
    
    UILabel *adultLabel = [[UILabel alloc] initWithFrame:CGRectMake(130 * AUTO_WIDTH, 70 * AUTO_HEIGHT, 69 * AUTO_WIDTH, 20 * AUTO_HEIGHT)];
    adultLabel.text = @"Adult";
    adultLabel.textColor = [UIColor colorWithRed:174.0f/255.0f green:174.0f/255.0f blue:174.0f/162.0f alpha:1];
    adultLabel.font = [UIFont systemFontOfSize:13 * AUTO_WIDTH];
    [self addSubview:adultLabel];
    
#pragma mark -  纪录片 + 英文
    self.videoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.videoBtn.frame = CGRectMake(218 * AUTO_WIDTH, 10 * AUTO_HEIGHT, 69 * AUTO_WIDTH, 69 * AUTO_HEIGHT);
    [self.videoBtn setImage:[UIImage imageNamed:@"content_icon_documentary_pressed"] forState:UIControlStateNormal];
    [self.videoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.videoBtn setTitle:@"纪录片" forState:UIControlStateNormal];
    self.videoBtn.titleEdgeInsets = UIEdgeInsetsMake(self.youngBtn.frame.size.height / 2, -(self.youngBtn.frame.size.height * 1.5), 0, -(self.youngBtn.frame.size.height / 2));
    self.videoBtn.titleLabel.font = [UIFont systemFontOfSize:13 * AUTO_WIDTH];//title字体大小
    self.videoBtn.imageEdgeInsets = UIEdgeInsetsMake(-(self.youngBtn.frame.size.height / 2), 0, 0,-(self.youngBtn.frame.size.height));
    [self.videoBtn setTitleColor:[UIColor colorWithRed:0.631 green:0.635 blue:0.631 alpha:1.000] forState:UIControlStateNormal];
    [self addSubview:self.videoBtn];
    
    UILabel *videoLabel = [[UILabel alloc] initWithFrame:CGRectMake(230 * AUTO_WIDTH, 70 * AUTO_HEIGHT, 85 * AUTO_WIDTH, 20 * AUTO_HEIGHT)];
    videoLabel.text = @"Documentary";
    videoLabel.textColor = [UIColor colorWithRed:174.0f/255.0f green:174.0f/255.0f blue:174.0f/162.0f alpha:1];
    videoLabel.font = [UIFont systemFontOfSize:13 * AUTO_WIDTH];
    [self addSubview:videoLabel];
    
#pragma mark -  收藏 + 英文
    self.collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.collectBtn.frame = CGRectMake(317 * AUTO_WIDTH, 10 * AUTO_HEIGHT, 69 * AUTO_WIDTH, 69 * AUTO_HEIGHT);
    [self.collectBtn setImage:[UIImage imageNamed:@"content_icon_collect_pressed"] forState:UIControlStateNormal];
    [self.collectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
    self.collectBtn.titleEdgeInsets = UIEdgeInsetsMake(self.youngBtn.frame.size.height / 2, -(self.youngBtn.frame.size.height * 0.5), 0, (self.youngBtn.frame.size.height * 0.25));
    self.collectBtn.titleLabel.font = [UIFont systemFontOfSize:13 * AUTO_WIDTH];//title字体大小
    self.collectBtn.imageEdgeInsets = UIEdgeInsetsMake(-(self.youngBtn.frame.size.height / 2), -(self.youngBtn.frame.size.height * 0.5), 0,-(self.youngBtn.frame.size.height));
    [self.collectBtn setTitleColor:[UIColor colorWithRed:0.631 green:0.635 blue:0.631 alpha:1.000] forState:UIControlStateNormal];
    [self addSubview:self.collectBtn];
    
    UILabel *collectLabel = [[UILabel alloc] initWithFrame:CGRectMake(337 * AUTO_WIDTH, 70 * AUTO_HEIGHT, 85 * AUTO_WIDTH, 20 * AUTO_HEIGHT)];
    collectLabel.text = @"Collect";
    collectLabel.textColor = [UIColor colorWithRed:174.0f/255.0f green:174.0f/255.0f blue:174.0f/162.0f alpha:1];
    collectLabel.font = [UIFont systemFontOfSize:13 * AUTO_HEIGHT];
    [self addSubview:collectLabel];
}















@end
