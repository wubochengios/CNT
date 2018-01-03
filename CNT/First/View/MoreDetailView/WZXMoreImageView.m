//
//  WZXMoreImageView.m
//  CNT
//
//  Created by 王智鑫 on 2017/12/9.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXMoreImageView.h"

@implementation WZXMoreImageView

- (instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self createSubView];
        self.backgroundColor = [UIColor colorWithRed:241.0f/255.0f green:241.0f/255.0f blue:241.0f/255.0f alpha:1];
    }
    return self;
}

- (void)createSubView {
    //  大图片
    self.bigImage = [UIImage imageNamed:@"banner-1"];
    self.bigImageView = [[UIImageView alloc] initWithImage:self.bigImage];
    self.bigImageView.frame = CGRectMake(0, 0, self.frame.size.width, 105 *IPHONE6_HEIGHT);
    [self addSubview:self.bigImageView];
    //  课程信息按钮
    self.classInformation = [UIButton buttonWithType:UIButtonTypeCustom];
    self.classInformation.frame = CGRectMake(0, 105 * IPHONE6_HEIGHT, KWIDTH/2, 44 * IPHONE6_HEIGHT);
    [self.classInformation setTitle:@"课程信息" forState:UIControlStateNormal];
    [self.classInformation setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.classInformation addTarget:self action:@selector(classInformation:) forControlEvents:UIControlEventTouchUpInside];
    self.classInformation.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.classInformation];
    //  课程大纲按钮
    self.classOutline = [UIButton buttonWithType:UIButtonTypeCustom];
    self.classOutline.frame = CGRectMake(KWIDTH/2, 105 * IPHONE6_HEIGHT, KWIDTH/2, 44 *IPHONE6_HEIGHT);
    [self.classOutline setTitle:@"课程大纲" forState:UIControlStateNormal];
    [self.classOutline setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.classOutline addTarget:self action:@selector(classOutline:) forControlEvents:UIControlEventTouchUpInside];
    self.classOutline.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.classOutline];
    //  横线Viwe
    self.lightView = [[UIView alloc] initWithFrame:CGRectMake(50 * IPHONE6_WIDTH, 149 *IPHONE6_HEIGHT, KWIDTH/2 - 100 * IPHONE6_WIDTH, 1)];
    self.lightView.backgroundColor = [UIColor redColor];
    [self addSubview:self.lightView];

}

//课程信息点击方法
-(void)classInformation:(UIButton *)classInformation {
    self.lightView.frame =  CGRectMake(50 * IPHONE6_WIDTH, 149 *IPHONE6_HEIGHT, KWIDTH/2 - 100 * IPHONE6_WIDTH, 1);
    
}
//课程大纲点击方法
-(void)classOutline:(UIButton *)classInformation {
    self.lightView.frame =  CGRectMake((50 * IPHONE6_WIDTH+KWIDTH/2) * IPHONE6_WIDTH, 149 *IPHONE6_HEIGHT,KWIDTH/2 - 100 * IPHONE6_WIDTH  , 1);
    
}








@end
