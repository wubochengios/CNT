//
//  WZXMoreImageView.h
//  CNT
//
//  Created by 王智鑫 on 2017/12/9.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZXMoreImageView : UIView

@property (nonatomic ,strong)UIImage *bigImage;

@property (nonatomic ,strong)UIImageView *bigImageView;// 图片
@property (nonatomic ,strong)UIButton *classInformation;// 课程信息
@property (nonatomic ,strong)UIButton *classOutline;    //  课程大纲
@property (nonatomic ,strong)UIView *lightView; //  button下面小红线

@end
