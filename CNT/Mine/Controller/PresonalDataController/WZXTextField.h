//
//  WZXTextField.h
//  CNT
//
//  Created by 王智鑫 on 2017/11/16.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BRTapAcitonBlock)();
typedef void(^BREndEditBlock)(NSString *text);

@interface WZXTextField : UITextField
/** textField 的点击回调 */
@property (nonatomic, copy) BRTapAcitonBlock tapAcitonBlock;
/** textField 结束编辑的回调 */
@property (nonatomic, copy) BREndEditBlock endEditBlock;
@end
