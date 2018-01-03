//
//  ChangePictureViewController.h
//  MShow
//
//  Created by 姚旭 on 2017/2/9.
//  Copyright © 2017年 YaoXu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChangePictureViewControllerDelegate <NSObject>

- (void)image:(UIImage *)image AndChangeNumber:(NSInteger)number;

@end


@interface ChangePictureViewController : UIViewController
@property (nonatomic, assign)NSInteger changeNumber;
@property (nonatomic, weak)id<ChangePictureViewControllerDelegate>delegate;
@property (nonatomic, copy)NSString *postString;

@end
