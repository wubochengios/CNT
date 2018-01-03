//
//  WZXRegistrationPreViewController.m
//  CNT
//
//  Created by 王智鑫 on 2017/11/28.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXRegistrationPreViewController.h"
#import <BRPickerView.h>
#import "WZXTextField.h"
#import "NSData+WZXAdd.h"
#import "UpYunFormUploader.h"
#import "ChangePictureViewController.h"
#import "WZXRoleModel.h"
#import "WZXTheratingViewController.h"
#import "LoginViewController.h"
#import "WBCCommonData.h"

@interface WZXRegistrationPreViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ChangePictureViewControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
/// 头像
@property (nonatomic, strong) UIImage *headImage;
@property (nonatomic, strong) UIImageView *headImageView;
/// 姓名
@property (nonatomic, strong) WZXTextField *nameTF;
/// 性别
@property (nonatomic, strong) WZXTextField *genderTF;
/// 生日
@property (nonatomic, strong) WZXTextField *ageTF;
/// 现居住国家
@property (nonatomic, strong) WZXTextField *countryTF;
/// 国语
@property (nonatomic, strong) WZXTextField *nationalLanguageTF;
/// 自评
@property (nonatomic, strong) WZXTextField *selfAssessmentTF;
/// 推荐码
@property (nonatomic, strong) WZXTextField *referralTF;
/** 传参8个  ***  密码在.h里 */
@property (nonatomic, copy) NSString *nameString;
@property (nonatomic, copy) NSString *sexString;
@property (nonatomic, copy) NSString *ageString;
@property (nonatomic, copy) NSString *contryString;
@property (nonatomic, copy) NSString *languageString;
@property (nonatomic, copy) NSString *referralString;
@property (nonatomic, copy) NSString *selfAssessmentString;
@property (nonatomic, copy) NSString *imageString;
/// 相机
@property (nonatomic, strong) UIImageView *picture;
/// 每个列表名字
@property (nonatomic, strong) NSArray *titleArr;
/// 男女int
@property (nonatomic, assign) NSInteger sexNum;
/// 年龄int
@property (nonatomic, assign) NSInteger ageNum;
// yyModel - 存数据
@property (nonatomic, strong) WZXRoleModel *myRoleModel;

@end

NSString * const CellReuseIdentifier = @"Cell";

@implementation WZXRegistrationPreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人资料";
    self.tableView.hidden = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellReuseIdentifier];
    [self setupHeaderView];
    [self setupFooterView];
}

- (void)setupHeaderView {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 156*IPHONE6_HEIGHT)];
    headView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = headView;
    UIImage *headImage = [UIImage imageNamed:@"con_tianjia_default"];
    UIImageView *headIv = [[UIImageView alloc] initWithImage:headImage];
    [headView addSubview:headIv];
    [headIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(170*0.5*IPHONE6_HEIGHT);
        make.width.mas_equalTo(186*0.5*IPHONE6_HEIGHT);
        make.top.mas_equalTo(54*0.5*IPHONE6_HEIGHT);
    }];
    
    _headImageView = headIv;
    headIv.userInteractionEnabled = YES;
    [_headImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headACtion:)]];
    headIv.layer.cornerRadius = 20;
    headIv.clipsToBounds = YES;
    
    UILabel *addAvatarLb = [UILabel new];
    addAvatarLb.font = [UIFont systemFontOfSize:16];
    addAvatarLb.textColor = COLOR_RGB(0x333333);
    [headView addSubview:addAvatarLb];
    [addAvatarLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(headIv.mas_bottom).mas_equalTo(11);
    }];
    addAvatarLb.text = @"Add Avatar";
}

- (void)setupFooterView {
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 238*0.5*IPHONE6_HEIGHT)];
    self.tableView.tableFooterView = footView;
    
    UIButton *saveBtn = [UIButton new];
    [footView addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(98*0.5*IPHONE6_HEIGHT);
        make.width.mas_equalTo(594*0.5*IPHONE6_HEIGHT);
        make.top.mas_equalTo(52*0.5*IPHONE6_HEIGHT);
    }];
    saveBtn.backgroundColor = REDCOLOR;
    [saveBtn setTitle:@"Save\n保存" forState:UIControlStateNormal];
    saveBtn.titleLabel.numberOfLines = 0;
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    saveBtn.layer.cornerRadius = 5;
    [saveBtn addTarget:self action:@selector(requstWithSave) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - <UITableViewDataSource / UITableViewDelegate>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sectionArr = self.titleArr[section];
    return sectionArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
    cell.textLabel.textColor = RGB_HEX(0x464646, 1.0f);
    
    NSArray *sectionArr = self.titleArr[indexPath.section];
    NSString *title = sectionArr[indexPath.row];
    cell.textLabel.text = title;
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                [self setupNameTF:cell];
                break;
            case 1:
                [self setupGenderTF:cell];
                break;
            case 2:
                [self setupBirthdayTF:cell];
                break;
            default:
                break;
        }
    } else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                [self setupCountryTF:cell];
                break;
            case 1:
                [self nationalLanguageTF:cell];
                break;
            case 2:
                [self setupReferralTF:cell];
                break;
            case 3:
                [self selfAssessmentTF:cell];
                break;
            default:
                break;
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

#pragma mark - 统一textField格式
- (WZXTextField *)getTextField:(UITableViewCell *)cell  {
    WZXTextField *textField = [[WZXTextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 300 * IPHONE6_WIDTH, 0, 265* IPHONE6_WIDTH, 55 * IPHONE6_HEIGHT)];
    textField.backgroundColor = [UIColor clearColor];
    textField.font = [UIFont systemFontOfSize:16.0f* IPHONE6_WIDTH];
    textField.textAlignment = NSTextAlignmentRight;
    textField.textColor = RGB_HEX(0x666666, 1.0);
    textField.delegate = self;
    [cell.contentView addSubview:textField];
    return textField;
}

#pragma mark - 姓名 textField
- (void)setupNameTF:(UITableViewCell *)cell {
    if (!_nameTF) {
        _nameTF = [self getTextField:cell];
        _nameTF.placeholder = @"请输入";
        _nameTF.returnKeyType = UIReturnKeyDone;
        _nameTF.tag = 0;
    }
}

#pragma mark - 性别 textField
- (void)setupGenderTF:(UITableViewCell *)cell {
    if (!_genderTF) {
        _genderTF = [self getTextField:cell];
        _genderTF.placeholder = @"请选择";
        __weak typeof(self) weakSelf = self;
        _genderTF.tapAcitonBlock = ^{
            [BRStringPickerView showStringPickerWithTitle:@"宝宝性别" dataSource:@[@"男", @"女"] defaultSelValue:@"男" isAutoSelect:YES resultBlock:^(id selectValue) {
                weakSelf.genderTF.text = selectValue;
                weakSelf.sexString = selectValue;
                if ([weakSelf.sexString isEqualToString:@"男"]) {
                    weakSelf.sexNum = 1;
                } else if ([weakSelf.sexString isEqualToString:@"女"])
                    weakSelf.sexNum = 2;
            }];
        };
    }
}

#pragma mark - 年龄 textField
- (void)setupBirthdayTF:(UITableViewCell *)cell {
    if (!_ageTF) {
        _ageTF = [self getTextField:cell];
        _ageTF.placeholder = @"请输入";
        _ageTF.returnKeyType = UIReturnKeyDone;
        _ageTF.tag = 3;
    }
}

#pragma mark - 现居住国家 textField
- (void)setupCountryTF:(UITableViewCell *)cell {
    if (!_countryTF) {
        _countryTF = [self getTextField:cell];
        _countryTF.placeholder = @"请选择";
        __weak typeof(self) weakSelf = self;
        _countryTF.tapAcitonBlock = ^{
            NSArray *dataSources = @[[WBCCommonData countriesOfWorld]];
            [BRStringPickerView showStringPickerWithTitle:@"选择国家" dataSource:dataSources defaultSelValue:@[@"中国"] isAutoSelect:YES resultBlock:^(id selectValue) {
                weakSelf.countryTF.text = [NSString stringWithFormat:@"%@", selectValue[0]];
                weakSelf.contryString = [NSString stringWithFormat:@"%@", selectValue[0]];
            }];
        };
    }
}

#pragma mark - 选择语言 textField
- (void)nationalLanguageTF:(UITableViewCell *)cell {
    if (!_nationalLanguageTF) {
        _nationalLanguageTF = [self getTextField:cell];
        _nationalLanguageTF.placeholder = @"请选择";
        __weak typeof(self) weakSelf = self;
        _nationalLanguageTF.tapAcitonBlock = ^{
            NSArray *dataSources = @[@[@"English",@"汉语",@"Русский",@"Français",@"ไทย",@"Svenska",@"日本語",@"한국어",@"Türkçe",@"Čeština",@"Italiano(Italia)"]];
            [BRStringPickerView showStringPickerWithTitle:@"选择语言" dataSource:dataSources defaultSelValue:@[@"汉语"] isAutoSelect:YES resultBlock:^(id selectValue) {
                weakSelf.nationalLanguageTF.text = [NSString stringWithFormat:@"%@", selectValue[0]];
                weakSelf.languageString = [NSString stringWithFormat:@"%@", selectValue[0]];
            }];
        };
    }
}

#pragma mark - 自评 textField
- (void)selfAssessmentTF:(UITableViewCell *)cell {
    if (!_selfAssessmentTF) {
        _selfAssessmentTF = [self getTextField:cell];
        _selfAssessmentTF.placeholder = @"请选择";
        __weak typeof(self) weakSelf = self;
        _selfAssessmentTF.tapAcitonBlock = ^{
            NSArray *dataSources = @[@[@"Starten",@"Basic communication in Chinese",@"Fluent communication in Chinese",@"Can read and write Chinese",@"Fluent in written and read Chinese"]];
            [BRStringPickerView showStringPickerWithTitle:@"选择语言" dataSource:dataSources defaultSelValue:@[@"Fluent communication in Chinese"] isAutoSelect:YES resultBlock:^(id selectValue) {
                weakSelf.selfAssessmentTF.text = [NSString stringWithFormat:@"%@", selectValue[0]];
                weakSelf.selfAssessmentString = [NSString stringWithFormat:@"%@", selectValue[0]];
            }];
        };
    }
}
- (void)setupReferralTF:(UITableViewCell *)cell{
    if (!_referralTF) {
        _referralTF = [self getTextField:cell];
        _referralTF.placeholder = @"请输入";
        _referralTF.returnKeyType = UIReturnKeyDone;
        _referralTF.tag = 4;
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == 0 || textField.tag == 4 || textField.tag == 3) {
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if ([textField isEqual:self.nameTF]) {
        
        self.nameString = _nameTF.text;
        
    }
    else if ([textField isEqual:self.referralTF]){
        
        self.referralString = _referralTF.text;
        
    }
    else if ([textField isEqual:self.ageTF])
        
        
     self.ageNum = [_ageTF.text integerValue];
}

// 头像调用系统相册
- (void)headACtion:(UITapGestureRecognizer *)sender {
    ChangePictureViewController *changePictureViewController = [[ChangePictureViewController alloc] init];
    changePictureViewController.changeNumber = 1;
    changePictureViewController.delegate = self;
    [self presentViewController:changePictureViewController animated:YES completion:nil];
}

- (void)image:(UIImage *)image AndChangeNumber:(NSInteger)number {
    [self.picture setImage:image];
    [self.headImageView setImage:image];
    
    NSData *imageData = UIImagePNGRepresentation(image);
    //生成随机时间
    NSDate *curDate = [NSDate date];//获取当前日期
    NSDateFormatter *formater = [[ NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy/MM/dd"];//这里去掉 具体时间 保留日期
    NSString * curTime = [formater stringFromDate:curDate];
    curTime = [NSString stringWithFormat:@"%@/%.0f", curTime, [curDate timeIntervalSince1970] * 1000];
    //生成saveKey
    NSString *saveKeyString = [NSString stringWithFormat:@"/%@.jpg", curTime];
    UpYunFormUploader *up = [[UpYunFormUploader alloc] init];
    NSString *bucketName = @"webcast";
    //上传又拍云
    [up uploadWithBucketName:bucketName operator:@"zhou" password:@"zhou123456" fileData:imageData fileName:nil saveKey:saveKeyString otherParameters:nil success:^(NSHTTPURLResponse *response, NSDictionary *responseBody) {
        NSLog(@"111111111%@",responseBody);
        if ([[responseBody objectForKey:@"code"]integerValue] == 200) {
            
            self.imageString = [NSString stringWithFormat:@"%@%@",UPYUN,[responseBody objectForKey:@"url"]];
            
            NSLog(@"%@",self.imageString);
        }
    } failure:^(NSError *error, NSHTTPURLResponse *response, NSDictionary *responseBody) {
        
        NSLog(@"%@1111111111",error);
        
    } progress:^(int64_t completedBytesCount, int64_t totalBytesCount) {
        
    }];
}

// 点击保存上传用户信息
- (void)requstWithSave {
    [self.view endEditing:YES];
    NSString *url = [NSString stringWithFormat:@"%@",@"lucyAdmin/account/register"];
    NSDictionary *params = @{@"email":_email,
                             @"password":_passWord,
                             @"image":_imageString,
                             @"nickname":_nameString,
                             @"sex":@(_sexNum),
                             @"age":@(_ageNum),
                             @"currentCity":_contryString,
                             @"mandrin":_languageString,
                             @"refCode":_referralString,
                             @"selfAssessment":_selfAssessmentString,
                             };
    
    [AFTools postWithUrl:url andParameters:params andSuccessBlock:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
#pragma mark - 已经注册跳回登录界面
        if ([[responseObject objectForKey:@"code"]integerValue] == 10004) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"此账号已注册，请直接登录" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alert animated:YES completion:^{
                
            }];
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                LoginViewController *loginVC = [[LoginViewController alloc] init];
                [self.navigationController pushViewController:loginVC animated:YES];
            }];
            [alert addAction:alertAction];
        }
#pragma mark - 未注册，驻车成功跳到测试课
        if ([[responseObject objectForKey:@"code"]integerValue] == 1) {
            NSMutableDictionary *dic = [responseObject objectForKey:@"data"];
            _myRoleModel = [WZXRoleModel new];
            [_myRoleModel yy_modelSetWithJSON:dic];
            //[self request:_myDataModel.role];
            //[_mineTableView reloadData];
            /* 请求失败弹出提示框 */
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"保存成功" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alert animated:YES completion:^{
                
            }];
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                WZXTheratingViewController *theRating = [[WZXTheratingViewController alloc] init];
                [self.navigationController pushViewController:theRating animated:YES];
            }];
            [alert addAction:alertAction];
            
        }
    } andFaileBlock:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
    
    
}

#pragma mark - setter / getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = COLOR_RGB(0xefeff4);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc]init];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@[@"Nickname(昵称)", @"Sex(性别)", @"Time of life(年龄)"],
                      @[@"Current city(现居住地)", @"Mandrin(国语)", @"Referral Code(推荐码)", @"Self-assessment(自评)"]];
    }
    return _titleArr;
}

@end
