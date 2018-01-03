//
//  WZXMyClassView.m
//  CNT
//
//  Created by 王智鑫 on 2017/12/11.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXMyClassView.h"

@implementation WZXMyClassView

- (instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self createSubView];
        self.backgroundColor = [UIColor colorWithRed:241.0f/255.0f green:241.0f/255.0f blue:241.0f/255.0f alpha:1];
    }
    return self;
}

- (void)createSubView {
    //  课程信息按钮
    self.oneByOneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.oneByOneBtn.frame = CGRectMake(0, 0, 186.5, 44);
    [self.oneByOneBtn setTitle:@"1对1课时" forState:UIControlStateNormal];
    [self.oneByOneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.oneByOneBtn addTarget:self action:@selector(oneByOneBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.oneByOneBtn.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.oneByOneBtn];
    //  课程大纲按钮
    self.oneByMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.oneByMoreBtn.frame = CGRectMake(187.5, 0, 186.5, 44);
    [self.oneByMoreBtn setTitle:@"课程大纲" forState:UIControlStateNormal];
    [self.oneByMoreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.oneByMoreBtn addTarget:self action:@selector(oneByMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.oneByMoreBtn.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.oneByMoreBtn];
    //  横线Viwe
    self.lightView = [[UIView alloc] initWithFrame:CGRectMake(50, 44, 86.5, 1)];
    self.lightView.backgroundColor = [UIColor redColor];
    [self addSubview:self.lightView];
    
}

//课程信息点击方法
-(void)oneByOneBtn:(UIButton *)classInformation {
    self.lightView.frame =  CGRectMake(52, 44, 86.5, 1);
    
}
//课程大纲点击方法
-(void)oneByMoreBtn:(UIButton *)classInformation {
    self.lightView.frame =  CGRectMake(240.5, 44, 86.5, 1);
    
}

@end
