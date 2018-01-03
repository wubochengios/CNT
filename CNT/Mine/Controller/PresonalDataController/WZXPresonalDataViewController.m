//
//  WZXPresonalDataViewController.m
//  CNT
//
//  Created by 王智鑫 on 2017/11/15.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXPresonalDataViewController.h"
#import "WZXPresonalDataTableViewCell.h"
#import <BRPickerView.h>
#import "WZXTextField.h"
#import "NSData+WZXAdd.h"

@interface WZXPresonalDataViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic ,strong) UITableView *tableView;
/** 头像 */
@property (nonatomic ,strong) UIImage *headImage;
@property (nonatomic ,strong) UIImageView *headImageView;
/** 姓名 */
@property (nonatomic ,strong) WZXTextField *nameTF;
/** 性别 */
@property (nonatomic ,strong) WZXTextField *genderTF;
/** 生日 */
@property (nonatomic ,strong) WZXTextField *birthdayTF;
/** 现居住国家 */
@property (nonatomic ,strong) WZXTextField *countryTF;
/** 国语 */
@property (nonatomic ,strong) WZXTextField *nationalLanguageTF;
/** 自评 */
@property (nonatomic ,strong) WZXTextField *selfAssessmentTF;
/** 相机 */
@property (nonatomic ,strong)UIActionSheet *actionSheet;


@property (nonatomic, strong) NSArray *titleArr;
@end

@implementation WZXPresonalDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //改变NavigationItem.title 颜色
    UIFont *font = [UIFont fontWithName:@"Arial-ItalicMT" size:18];
    NSDictionary *dic = @{NSFontAttributeName:font,
                          NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.navigationController.navigationBar.titleTextAttributes =dic;
    self.navigationItem.title = @"个人资料";
    self.tableView.hidden = NO;
#pragma mark - navigation 左侧返回键
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_jiantou_default"] style:UIBarButtonItemStylePlain target:self action:@selector(returnAction:)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
#pragma mark - 保存
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(clickSaveBtn)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
#pragma mark - 回收键盘
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];
}
#pragma mark - 回收键盘
-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    [self.view endEditing:YES];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc]init];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"testCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
    cell.textLabel.textColor = RGB_HEX(0x464646, 1.0f);
    NSString *title = [self.titleArr objectAtIndex:indexPath.row];
    if ([title hasPrefix:@"* "]) {
        NSMutableAttributedString *textStr = [[NSMutableAttributedString alloc]initWithString:title];
        [textStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[[textStr string]rangeOfString:@"* "]];
        cell.textLabel.attributedText = textStr;
    } else {
        cell.textLabel.text = [self.titleArr objectAtIndex:indexPath.row];
    }
    
    switch (indexPath.row) {
        case 0:
        {
            [self setHeadImageV:cell];
        }
            break;
        case 1:
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            [self setupNameTF:cell];
        }
            break;
        case 2:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [self setupGenderTF:cell];
        }
            break;
        case 3:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [self setupBirthdayTF:cell];
        }
            break;
        case 4:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [self setupCountryTF:cell];
        }
            break;
        case 5:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [self nationalLanguageTF:cell];
        }
            break;
        case 6:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
        case 7:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [self selfAssessmentTF:cell];
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55 * IPHONE6_HEIGHT;
}

#pragma mark - 统一textField格式
- (WZXTextField *)getTextField:(UITableViewCell *)cell {
    WZXTextField *textField = [[WZXTextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 300 * IPHONE6_WIDTH, 0, 265* IPHONE6_WIDTH, 55 * IPHONE6_HEIGHT)];
    textField.backgroundColor = [UIColor clearColor];
    textField.font = [UIFont systemFontOfSize:16.0f* IPHONE6_WIDTH];
    textField.textAlignment = NSTextAlignmentRight;
    textField.textColor = RGB_HEX(0x666666, 1.0);
    textField.delegate = self;
    [cell.contentView addSubview:textField];
    return textField;
}

#pragma mark - 头像
- (void)setHeadImageV:(UITableViewCell *)cell {
    _headImage = [UIImage imageNamed:@"con_touxiang_default"];
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] initWithImage:_headImage];
        _headImageView.frame = CGRectMake(290* IPHONE6_WIDTH, 2.5 * IPHONE6_HEIGHT, 50* IPHONE6_WIDTH, 50 * IPHONE6_HEIGHT);
        _headImageView.clipsToBounds = YES;
        _headImageView.layer.cornerRadius = 25 * AUTO_WIDTH;
        [cell addSubview:_headImageView];
#pragma mark - 给头像图片添加点击方法
        _headImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapHeaderView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headACtion:)];
        [_headImageView addGestureRecognizer:tapHeaderView];
    }
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
            [BRStringPickerView showStringPickerWithTitle:@"宝宝性别" dataSource:@[@"男", @"女", @"其他"] defaultSelValue:@"男" isAutoSelect:YES resultBlock:^(id selectValue) {
                weakSelf.genderTF.text = selectValue;
            }];
        };
    }
}

#pragma mark - 生日 textField
- (void)setupBirthdayTF:(UITableViewCell *)cell {
    if (!_birthdayTF) {
        _birthdayTF = [self getTextField:cell];
        _birthdayTF.placeholder = @"请选择";
        __weak typeof(self) weakSelf = self;
        _birthdayTF.tapAcitonBlock = ^{
            [BRDatePickerView showDatePickerWithTitle:@"出生年月" dateType:UIDatePickerModeDate defaultSelValue:weakSelf.birthdayTF.text minDateStr:@"" maxDateStr:[NSData currentDateString] isAutoSelect:YES resultBlock:^(NSString *selectValue) {
                weakSelf.birthdayTF.text = selectValue;
            }];
        };
    }
}

#pragma mark - 现居住国家 textField
- (void)setupCountryTF:(UITableViewCell *)cell {
    if (!_countryTF) {
        _countryTF = [self getTextField:cell];
        _countryTF.placeholder = @"请选择";
        __weak typeof(self) weakSelf = self;
        _countryTF.tapAcitonBlock = ^{
            NSArray *dataSources = @[@[@"美国",@"阿富汗",@"奥兰群岛",@"阿尔巴尼亚",@"阿尔及利亚",@"美属萨摩亚",@"安道尔",@"安哥拉",@"安圭拉",@"南极洲",@"安提瓜和巴布达",@"阿根廷",@"亚美尼亚",@"阿鲁巴",@"澳大利亚",@"奥地利",@"阿塞拜疆",@"巴哈马",@"巴林",@"孟加拉国",@"巴巴多斯",@"白俄罗斯",@"比利时",@"伯利兹",@"贝宁",@"百慕",@"BES群岛",@"不丹",@"玻利维亚",@"波斯尼亚和黑塞哥维那",@"博茨瓦纳",@"布维岛",@"巴西",@"英属印度洋领地",@"英属维尔京群岛",@"文莱",@"保加利亚",@"布基纳法索",@"布隆迪",@"柬埔寨",@"喀麦隆",@"加拿",@"佛得角",@"开曼群岛",@"中非共和国",@"乍得",@"智利",@"中国",@"圣诞岛",@"科科斯（基灵）群岛",@"哥伦比亚",@"科摩罗",@"刚果",@"刚果（民主共和国",@"库克群岛",@"哥斯达黎加",@"科特迪瓦",@"克罗地亚",@"库拉索岛",@"塞浦路斯",@"捷克共和国",@"丹麦",@"吉布提",@"多米尼加",@"多米尼加共和国",@"东帝汶",@"厄瓜多尔",@"埃及",@"萨尔瓦多",@"赤道几内亚",@"厄立特里亚",@"爱沙尼亚",@"埃塞俄比亚",@"福克兰群岛（马尔维纳斯群岛）",@"法罗群岛",@"密克罗尼西亚联邦密克罗尼西亚",@"斐济",@"芬兰",@"法国",@"法国 大都会",@"法属圭亚那",@"法属波利尼西亚",@"法国南部领土",@"加蓬",@"冈比亚",@"格鲁吉亚",@"德国",@"加纳",@"直布罗陀",@"希腊",@"格陵兰岛",@"格林纳达",@"瓜德罗普岛",@"关岛",@"危地马拉",@"根西岛",@"几内亚",@"几内亚 几内亚比绍",@"圭亚那",@"海地",@"赫德岛和麦克唐纳群岛",@"罗马教廷（梵蒂冈城国",@"洪都拉斯",@"香港",@"匈牙利",@"冰岛",@"印度",@"印度尼西亚",@"伊拉克",@"爱尔兰",@"马恩岛",@"以色列",@"意大利",@"牙买加",@"日本",@"新泽西州",@"约旦",@"哈萨克斯坦",@"肯尼亚",@"基里巴斯",@"科威特",@"吉尔吉斯斯坦",@"老挝",@"拉脱维亚",@"黎巴嫩",@"莱索托",@"利比里亚",@"利比亚",@"列支敦士登",@"立陶宛",@"卢森堡",@"澳门",@"马其顿",@"马达加斯加",@"马拉维",@"马来西亚",@"马尔地夫",@"马里",@"马耳他",@"马绍尔群岛",@"马提尼克岛",@"毛里塔尼亚",@"毛里求斯",@"马约特岛",@"墨西哥",@"摩纳哥",@"蒙古",@"黑山",@"蒙特塞拉特",@"摩洛哥",@"莫桑比克",@"缅甸",@"纳米比亚",@"瑙鲁",@"尼泊尔",@"荷兰",@"荷属安的列斯群岛",@"新喀里多尼亚",@"新西兰",@"尼加拉瓜",@"尼日尔",@"尼日利亚",@"纽埃",@"诺福克岛",@"北马里亚纳群岛",@"挪威",@"阿曼",@"巴基斯坦",@"帕劳",@"巴勒斯坦领土",@"巴拿马",@"巴布亚新几内亚",@"巴拉圭",@"秘鲁",@"菲律宾",@"皮特凯恩",@"波兰",@"葡萄牙",@"波多黎各",@"卡塔尔",@"摩尔多瓦共和国",@"留尼旺",@"罗马尼亚",@"俄罗斯联邦",@"卢旺达",@"S格鲁吉亚＆S南桑威奇群岛",@"圣巴泰勒米岛地区",@"圣赫勒拿岛",@"圣基茨和尼维斯",@"圣卢西亚",@"圣马丁",@"圣皮埃尔和密克隆",@"圣文森特和格林纳丁斯",@"萨摩亚",@"圣马力诺",@"圣多美和普林西比",@"沙特阿拉伯",@"苏格兰",@"塞内加尔",@"塞尔维亚",@"塞舌尔",@"塞拉利昂",@"新加坡",@"圣马丁岛",@"斯洛伐克",@"斯洛文尼亚",@"索罗门群岛",@"索马里",@"南非",@"韩国",@"西班牙",@"斯里兰卡",@"苏里南",@"斯瓦尔巴群岛和扬马延岛",@"史瓦济兰",@"瑞典",@"瑞士",@"台湾",@"塔吉克斯坦",@"坦桑尼亚",@"泰国",@"多哥",@"托克劳",@"汤加",@"特里尼达和多巴哥",@"突尼斯",@"土耳其",@"土库曼斯坦",@"特克斯和凯科斯群岛",@"图瓦卢",@"美国美属维尔京群岛",@"乌干达",@"乌克兰",@"阿拉伯联合大公国",@"英国",@"美国本土外小",@"乌拉圭",@"乌兹别克斯坦",@"瓦努阿图",@"委内瑞拉",@"越南",@"瓦利斯群岛和富图纳群岛",@"西撒哈拉",@"也门",@"南斯拉夫",@"赞比亚",@"津巴布韦"]];
            [BRStringPickerView showStringPickerWithTitle:@"选择国家" dataSource:dataSources defaultSelValue:@[@"中国"] isAutoSelect:YES resultBlock:^(id selectValue) {
                weakSelf.countryTF.text = [NSString stringWithFormat:@"%@", selectValue[0]];
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
            }];
        };
    }
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == 0 || textField.tag == 4) {
        [textField resignFirstResponder];
    }
    return YES;
}

- (NSArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@"* 头像", @"* 昵称", @"* 性别", @"* 生日", @"  现居住国家", @"* 国语", @"   推荐码", @"   自评"];
    }
    return _titleArr;
}

//头像调用系统相册
- (void)headACtion:(UITapGestureRecognizer *)sender {
    
    
    [self openActionSheetFunc];
}

//调用ActionSheet
- (void)openActionSheetFunc
{
    //判断设备是否有具有摄像头(相机)功能
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        _actionSheet = [[UIActionSheet alloc]initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    }
    else
    {
        _actionSheet = [[UIActionSheet alloc]initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil];
    }
    _actionSheet.tag = 100;
    //显示提示栏
    [_actionSheet showInView:self.view];

}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 100)
    {
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            switch (buttonIndex)
            {
                case 0:
                    //来源:相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1:
                    //来源:相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                case 2:
                    return;
            }
        }
        else
        {
            if (buttonIndex == 2)
            {
                return;
            }
            else
            {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        //跳转到相机或者相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.allowsEditing  = YES;
        imagePickerController.sourceType = sourceType;
        imagePickerController.delegate = self;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}

//pickerController的代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [_headImageView setImage:image];
    
//    [AFTools updateHeaderImage:image andImageUrl:@"" andSuccessBlock:^(id responseObject) {
//        //_myDataModel.userimage = @"";
//        //[self requstWithSave];
//    } andFaileBlock:^(NSError *error) {
//
//    }];
    
}


- (void)returnAction:(UIButton *)returnBtn {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 
** 联系方式
@property (nonatomic, strong) WZXTextField *phoneTF;
** 地区
@property (nonatomic, strong) WZXTextField *addressTF;
** 学历
@property (nonatomic, strong) WZXTextField *educationTF;
 
 #pragma mark - 联系方式 textField
 - (void)setupPhoneTF:(UITableViewCell *)cell {
 if (!_phoneTF) {
 _phoneTF = [self getTextField:cell];
 _phoneTF.placeholder = @"请输入";
 _phoneTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
 _phoneTF.returnKeyType = UIReturnKeyDone;
 _phoneTF.tag = 4;
 }
 }
 
 #pragma mark - 地址 textField
 - (void)setupAddressTF:(UITableViewCell *)cell {
 if (!_addressTF) {
 _addressTF = [self getTextField:cell];
 _addressTF.placeholder = @"请选择";
 __weak typeof(self) weakSelf = self;
 _addressTF.tapAcitonBlock = ^{
 [BRAddressPickerView showAddressPickerWithDefaultSelected:@[@10, @0, @3] isAutoSelect:YES resultBlock:^(NSArray *selectAddressArr) {
 weakSelf.addressTF.text = [NSString stringWithFormat:@"%@%@%@", selectAddressArr[0], selectAddressArr[1], selectAddressArr[2]];
 }];
 };
 }
 }
 
 #pragma mark - 学历 textField
 - (void)setupEducationTF:(UITableViewCell *)cell {
 if (!_educationTF) {
 _educationTF = [self getTextField:cell];
 _educationTF.placeholder = @"请选择";
 __weak typeof(self) weakSelf = self;
 _educationTF.tapAcitonBlock = ^{
 [BRStringPickerView showStringPickerWithTitle:@"学历" dataSource:@[@"大专以下", @"大专", @"本科", @"硕士", @"博士", @"博士后"] defaultSelValue:@"本科" isAutoSelect:YES resultBlock:^(id selectValue) {
 weakSelf.educationTF.text = selectValue;
 }];
 };
 }
 }
 
 */

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
