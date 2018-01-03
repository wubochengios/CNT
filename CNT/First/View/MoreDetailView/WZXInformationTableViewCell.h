//
//  WZXInformationTableViewCell.h
//  CNT
//
//  Created by 王智鑫 on 2017/12/10.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZXInformationTableViewCell : UITableViewCell

@property (nonatomic ,strong)UILabel *titlelabel;
@property (nonatomic ,strong)UIView *lightView;
@property (nonatomic ,strong)UILabel *detailLabel;

@property (nonatomic, strong) NSString *contentStr;
@end
