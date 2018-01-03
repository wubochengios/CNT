//
//  TopMenuView.m
//  text
//
//  Created by YHY on 2017/11/7.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TopMenuView.h"
#import <objc/runtime.h>

#define KTableViewCellHeight 44
#define KDisplayMaxCellOfNumber  5
#define KmaskBackGroundViewColor  [UIColor colorWithRed:40/255 green:40/255 blue:40/255 alpha:.2]
#define KOBJCSetObject(object,value)  objc_setAssociatedObject(object,@"title" , value, OBJC_ASSOCIATION_RETAIN_NONATOMIC)

#define KOBJCGetObject(object) objc_getAssociatedObject(object, @"title")

@interface TopMenuView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic) NSArray *titleArray ;
@property (nonatomic)NSMutableArray *tableDataArray;
@property (nonatomic) CGFloat selfOriginalHeight ;
@property (nonatomic) CGFloat tableViewMaxHeight ;
@property (nonatomic) UIView  *maskBackGroundView;
@property (nonatomic)UITableView *tableView;
@property (nonatomic) NSMutableArray *buttonArray;
@property (nonatomic) NSMutableArray *buttons;
@property (nonatomic,strong) UIButton *titleButton;


@end

@implementation TopMenuView
- (instancetype)initWithFrame:(CGRect)frame menuTitleArray:(NSArray *)titleArray{
    self = [super initWithFrame:frame];
    if (self) {
        _titleArray = titleArray;
        _tableViewMaxHeight = KTableViewCellHeight * KDisplayMaxCellOfNumber;
        _selfOriginalHeight =frame.size.height;
        self.backgroundColor=[UIColor clearColor];
        
        [self addSubview:self.maskBackGroundView];
        [self addSubview:self.tableView];
        [self creatView];
        
    }
    return self;
}

- (void)creatView{
    _titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _titleButton.frame = CGRectMake(0, 0, KWIDTH/_titleArray.count, _selfOriginalHeight);
    [_titleButton setTitle:[NSString stringWithFormat:@"%@",self.titleArray[0]] forState:0];
    [_titleButton setTitleColor:[UIColor redColor] forState:0];
    [_titleButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    _titleButton.tag =999;
    [_titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    _titleButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_titleButton setImage:[UIImage imageNamed:@"shaoer_jiantou_pressed"] forState:0];
    [_titleButton setTitleEdgeInsets:UIEdgeInsetsMake(0, - _titleButton.imageView.frame.size.width - 15, 0, 0)];
    [_titleButton setImageEdgeInsets:UIEdgeInsetsMake(0, _titleButton.titleLabel.bounds.size.width, 0, -_titleButton.titleLabel.bounds.size.width)];
    
    
    [self addSubview:_titleButton];
    [self.buttons addObject:_titleButton];
    
    _buttonArray = [NSMutableArray array];
    for (int i = 1; i < _titleArray.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i * KWIDTH/_titleArray.count, 0, KWIDTH/_titleArray.count, _selfOriginalHeight)];
        UIImage *image = [UIImage imageNamed:@"pingfen_jiantou_pressed"];
      // 还可增设间距
        CGFloat spacing = 5;
        [btn setImage:image forState:UIControlStateNormal];
        btn.titleLabel.font= [UIFont systemFontOfSize:14];
        CGSize titleSize = [_titleArray[i] boundingRectWithSize:CGSizeMake(KWIDTH/3.0-20, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:btn.titleLabel.font} context:nil].size;
        [btn setTitle:_titleArray[i] forState:UIControlStateNormal];
        // 图片右移
        CGFloat imageWith = [btn currentImage].size.width;
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, - (imageWith + spacing), 0, imageWith + spacing);
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, titleSize.width + spacing, 0,  -titleSize.width + spacing);
        
        
        btn.tag = 1000 + i;
        [btn setTitleColor:[UIColor blackColor] forState:0];
        [btn addTarget:self action:@selector(segmentIndexSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [_buttonArray addObject:btn];
        
    }
}
-(void)segmentIndexSelected:(UIButton *)titleButton
{
    
    titleButton.selected = !titleButton.isSelected;
    if (self.menuDataArray.count == 0) {
        return;
    }
//    NSUInteger index =  titleButton.tag - 1000;
    for (UIButton *button in _buttonArray) {
        if (button == titleButton) {
            NSString *titleStr = [titleButton currentTitle];
            if (button.isSelected) {
//                NSLog(@"1111111");
                NSInteger shengInt = 1;//生序是1
                if (_lesson_sortBlock) {
                    _lesson_sortBlock(shengInt,titleStr);
                }
            }else{
                NSInteger jiangInt = 0;//降序0
//                NSLog(@"000000");
                if (_lesson_sortBlock) {
                    _lesson_sortBlock(jiangInt,titleStr);
                }
            }
//            NSLog(@"yes");
        }else
        {
            NSLog(@"No");
        }
    }

    [self takeBackTableView];
}
-(void)titleButtonClick:(UIButton *)button
{
    
    self.tableDataArray = self.menuDataArray;
    if (self.menuDataArray.count == 0) {
        return;
    }
    self.tempButton = button;
        //设置默认选中第一项。
        if ([KOBJCGetObject(self.tempButton) length] < 1) {
            WZXYoungModel *model = self.tableDataArray.firstObject;
            KOBJCSetObject(self.tempButton, model.categoryName);
        }
        [self.tableView reloadData];
        CGFloat tableViewHeight =  self.tableDataArray.count * KTableViewCellHeight < self.tableViewMaxHeight ?
        self.tableDataArray.count * KTableViewCellHeight : self.tableViewMaxHeight;
        [self expandWithTableViewHeight:tableViewHeight];


    
}
//展开。
-(void)expandWithTableViewHeight:(CGFloat )tableViewHeight
{
    
    self.maskBackGroundView.hidden=NO;
    
    CGRect rect = self.frame;
    rect.size.height = KHEIGHT - self.frame.origin.y;
    self.frame= rect;
    
    [self showSpringAnimationWithDuration:0.3 animations:^{
        
        self.tableView.frame = CGRectMake(0, self.selfOriginalHeight, KWIDTH, tableViewHeight);
        
        self.maskBackGroundView.alpha =1;
        self.maskBackGroundView.backgroundColor =  [[UIColor blackColor]colorWithAlphaComponent:0.3];
        
    } completion:^{
        
    }];
}
//收起。
-(void)takeBackTableView
{

    
    CGRect rect = self.frame;
    rect.size.height = self.selfOriginalHeight;
    self.frame = rect;
    [self showSpringAnimationWithDuration:.3 animations:^{
        
        self.tableView.frame = CGRectMake(0, self.selfOriginalHeight, KWIDTH,0);;
        self.maskBackGroundView.alpha =0;
        
    } completion:^{
        self.maskBackGroundView.hidden=YES;
    }];
    
}
-(void)showSpringAnimationWithDuration:(CGFloat)duration
                            animations:(void (^)())animations
                            completion:(void (^)())completion
{
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:.8 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        if (animations) {
            animations();
        }
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

-(void)maskBackGroundViewTapClick
{
    [self takeBackTableView];
}

-(UITableView *)tableView
{
    if (_tableView) {
        return _tableView;
    }
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, self.frame.size.height, KWIDTH, 0)];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    self.tableView.rowHeight= KTableViewCellHeight;
    return self.tableView;
}
#pragma mark  --  <代理方法>
#pragma mark  --  <UITableViewDelegate,UITableViewDataSource>

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableDataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    downMenuCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell =[[downMenuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    WZXYoungModel *model = self.tableDataArray[indexPath.row];
    cell.textLabel.text = model.categoryName;
    NSString *objcTitle = KOBJCGetObject(self.tempButton);
    
    if ([cell.textLabel.text isEqualToString:objcTitle]) {
        cell.isSelected = YES;
    }
    else
    {
        cell.isSelected=NO;
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    downMenuCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    WZXYoungModel *model = self.tableDataArray[indexPath.row];
    cell.textLabel.text = model.categoryName;
    cell.isSelected = YES;
    
    [self.tempButton setTitle:[NSString stringWithFormat:@"%@",cell.textLabel.text] forState:UIControlStateNormal];
    //    [self.tempButton setTitleColor:DVLColor(@"ffb60f") forState:0];
    [self.tempButton setImage:[UIImage imageNamed:@"shaoer_jiantou_pressed"] forState:UIControlStateNormal];
    CGSize titleSize = [self.tempButton.titleLabel.text boundingRectWithSize:CGSizeMake(KWIDTH/3.0-20, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.tempButton.titleLabel.font} context:nil].size;//SCREEN_WIDTH/3.0-20
    KOBJCSetObject(self.tempButton, cell.textLabel.text);
    UIImage *currentImage = [self.tempButton currentImage];
    CGFloat currentImageWith = currentImage.size.width;
    CGFloat img_W = currentImageWith;
    CGFloat tit_W = titleSize.width;
    self.tempButton.titleEdgeInsets = (UIEdgeInsets){
        .top    = 0,
        .left   = - (img_W + 4 / 2),
        .bottom = 0,
        .right  =   (img_W + 4 / 2),
    };
    
    self.tempButton.imageEdgeInsets = (UIEdgeInsets){
        .top    = 0,
        .left   =   (tit_W + 4 / 2),
        .bottom = 0,
        .right  = - (tit_W + 4 / 2),
    };
    
    if (self.handleSelectBlock) {
        self.handleSelectBlock(model);
    }
    [self takeBackTableView];
    
}


-(NSMutableArray *)buttons
{
    if (_buttons) {
        return _buttons;
    }
    self.buttons =[[NSMutableArray alloc]init];
    
    return self.buttons;
}


-(NSMutableArray *)tableDataArray
{
    if (_tableDataArray) {
        return _tableDataArray;
    }
    self.tableDataArray = [[NSMutableArray alloc]init];
    
    return self.tableDataArray;
}

-(NSMutableArray *)menuDataArray
{
    if (_menuDataArray) {
        return _menuDataArray;
    }
    self.menuDataArray =[[NSMutableArray alloc]init];
    
    return self.menuDataArray;
}
-(UIView *)maskBackGroundView
{
    if (_maskBackGroundView) {
        return _maskBackGroundView;
    }
    self.maskBackGroundView=[[UIView alloc]initWithFrame:CGRectMake(0,40,self.frame.size.width, KHEIGHT - self.frame.origin.y)];
    self.maskBackGroundView.backgroundColor=KmaskBackGroundViewColor;
    self.maskBackGroundView.hidden=YES;
    self.maskBackGroundView.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(maskBackGroundViewTapClick)];
    [self.maskBackGroundView addGestureRecognizer:tap];
    
    return self.maskBackGroundView;
}


@end




@implementation downMenuCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self configCellView];
    }
    
    return self;
}


-(void)configCellView
{
    self.selectImageView.hidden=YES;
    self.textLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.selectImageView];
}


-(UIImageView *)selectImageView
{
    if (_selectImageView) {
        return _selectImageView;
    }
    
    UIImage *image = [UIImage imageNamed:@"Selected"];
    self.selectImageView = [[UIImageView alloc]init];
    self.selectImageView.image=image;
    
    self.selectImageView.frame = CGRectMake(KWIDTH - 20,0,image.size.width,image.size.height);
    
    self.selectImageView.center = CGPointMake(KWIDTH-15, self.frame.size.height/2);
    
    return self.selectImageView;
}

- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    if (isSelected) {
        self.textLabel.textColor = [UIColor redColor];
        self.backgroundColor=[UIColor whiteColor];
        self.selectImageView.hidden = NO;
    }else
    {
        self.textLabel.textColor = [UIColor blackColor];
        self.selectImageView.hidden = YES;
        self.backgroundColor=[UIColor whiteColor];
    }
}

@end


