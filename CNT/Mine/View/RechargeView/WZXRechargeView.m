//
//  WZXRechargeView.m
//  CNT
//
//  Created by 王智鑫 on 2017/11/21.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXRechargeView.h"

@implementation WZXRechargeView

- (instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self createSubView];
    }
    return self;
}

- (void)createSubView {
    
    self.bigGrayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, IPHONE6_WIDTH, 120)];
    self.bigGrayLabel.backgroundColor = [UIColor colorWithRed:241.0f/255.0f green:241.0f/255.0f blue:241.0f/255.0f alpha:1];
    self.bigGrayLabel.text = @"1";
    self.bigGrayLabel.font = [UIFont systemFontOfSize:22];
    self.bigGrayLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.bigGrayLabel];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
