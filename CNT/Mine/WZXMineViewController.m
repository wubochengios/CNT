//
//  WZXMineViewController.m
//  CNT
//
//  Created by 王智鑫 on 2017/11/14.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "WZXMineViewController.h"
#import "WZXMineHeadView.h"
#import "WZXFirstTableViewCell.h"
#import "UIImage+ChangeColor.h"
#import "WZXSetViewController.h"
#import "WZXCourSewareViewController.h"
#import "WZXPresonalDataViewController.h"
#import "WZXClassTimeViewController.h"
#import "WZXIncomeDetailViewController.h"
#import "WZXRechargeViewController.h"
#import "WZXMyClassViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "agorasdk.h"
#import "demohelp.h"
#import "WZXVideoCallViewController.h"

#define enableMediaCertificate 0

@interface WZXMineViewController ()<UITableViewDataSource,UITableViewDelegate,WZXMineHeaderViewDelegate>
@property (nonatomic, strong) NSArray *datas;
@end

@implementation WZXMineViewController{
    
    NSMutableString *logString;
    BOOL isLogin;
    BOOL isJoined;
    BOOL isInCall;
    NSString *idString;
    AgoraAPI *inst;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarTintColor:REDCOLOR];//修改navigationBar颜色
    [self creatTableView];
//    [self createRightBtn];
    isLogin = false;
    isJoined = false;
    isInCall = false;
    [WSTools setBoolObject:isLogin forKey:AgoraIsLogin];
    [WSTools setBoolObject:isJoined forKey:AgoraIsJoined];
    [WSTools setBoolObject:isInCall forKey:AgoraIsInCall];
    
    inst = [AgoraAPI getInstanceWithoutMedia:AgroaAPPID];
    WZXMineViewController * __weak weak_self = self;
    AgoraAPI * __weak weak_inst = inst;

    
#pragma mark - 创建导航栏左侧..我
    //修改系统自带的navigationItem的rightBarButtonItem的颜色
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithTitle:@"我😯" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_icon_shezhi_default"] style:UIBarButtonItemStylePlain target:self action:@selector(setAction:)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    //登录成功回调
    inst.onLoginSuccess = ^(uint32_t uid, int fd) {
        //加入房间
        [weak_self doJoin];
        
    };
    //退出登录回调
    inst.onLogout = ^(AgoraEcode ecode) {
        
        //101 用户登出
        if (ecode == AgoraEcode_LOGOUT_E_USER){
            
            //登出成功 上传销毁房间接口
            
        }else{
            //登出失败
        }
        //修改登录失败状态
        [weak_self set_state_logout];
        //修改通话失败状态
        [weak_self set_state_not_in_call];
        //离开
        [weak_self doLeave];
    };
    //加入频道回调 返回name频道名
    inst.onChannelJoined = ^(NSString *channelID) {
#pragma 登录成功上传随房间号以及修改教师状态

        [weak_self postTeacherType:1];
        
        
    };
    
    inst.onChannelUserLeaved = ^(NSString *name, uint32_t uid){
#pragma mark 离开频道后 上传教师状态
        [weak_self postTeacherType:0];
        
    };
    
    inst.onInviteReceived = ^(NSString* channel, NSString *name, uint32_t uid, NSString *extra){
        
        
        [weak_self set_state_in_call];
        [weak_self doJoin];
        /*
         接受呼叫  channel 频道名
         account 客户端定义的用户账号
         */
        [weak_inst channelInviteAccept:channel account:name uid:uid];
    };
    
    
}


#pragma mark - 右上角设置按钮
- (void)setAction:(UIBarButtonItem *)setBtn {
    WZXSetViewController *setVC = [[WZXSetViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:setVC animated:YES];
}

#pragma mark - 创建tableView
- (void)creatTableView{
    
    self.mineTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT) style:UITableViewStylePlain];
    self.mineTableView.delegate = self;
    self.mineTableView.dataSource = self;
    [self.view addSubview:self.mineTableView];
    [self request:2];
    
#pragma mark - 注册cell
    [self.mineTableView registerClass:[WZXFirstTableViewCell class] forCellReuseIdentifier:@"firstCell"];
}

#pragma mark - 根据登录角色来创建头视图
- (void)setupSubViewWithRoleName:(RoleName)role {
    [self initDataWithRoleName:role];
    // - 头视图
    WZXMineHeadView *headView = [[WZXMineHeadView alloc] initWithRoleName:role];
    headView.delegate = self;
#pragma mark - 盖住头像的大btn点击方法
    [headView.presonalbigBtn addTarget:self action:@selector(presonalBigBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.mineTableView.tableHeaderView = headView;
    
}

- (void)presonalBigBtnAction:(UIButton *)presonalBigBtn {
    
    WZXPresonalDataViewController *presonalVC = [[WZXPresonalDataViewController alloc] init];
    presonalVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:presonalVC animated:YES];
}

#pragma mark - 根据进入的角色来创建我的cell
- (void)initDataWithRoleName:(RoleName)role {
    
    if (role == RoleNameTeacher) {
        _datas = @[@{@"title":@"我的课时", @"image":@"content_icon_wodkeshi_default"},
                   @{@"title":@"我的课表", @"image":@"content_icon_wodekebiao_default"},
                   @{@"title":@"我的课件", @"image":@"content_icon_wodekejian_default"},
                   @{@"title":@"收入详情", @"image":@"content_icon_chongzhi_default"},
                   @{@"title":@"消息提示", @"image":@"content_icon_xiaoxitixing_default"},
                   @{@"title":@"推广有奖", @"image":@"content_icon_tuiguangyoujiang_default"},
                   @{@"title":@"在线客服", @"image":@"content_icon_zaixiankefu_default"},
                   @{@"title":@"我的学习组", @"image":@"content_icon_xuexiqunzhu_default"},
                   @{@"title":@"设置", @"image":@"content_icon_shezhi_default"}];
    } else {
        _datas = @[@{@"title":@"学豆任务", @"image":@"content_icon_xuedourenwu_default"},
                   @{@"title":@"充值", @"image":@"content_icon_chongzhi_default"},
                   @{@"title":@"消息提示", @"image":@"content_icon_xiaoxitixing_default"},
                   @{@"title":@"推广有奖", @"image":@"content_icon_tuiguangyoujiang_default"},
                   @{@"title":@"在线客服", @"image":@"content_icon_zaixiankefu_default"},
                   @{@"title":@"我的学习组", @"image":@"content_icon_xuexiqunzhu_default"},
                   @{@"title":@"教师申请", @"image":@"content_icon_jiaoshishenqing_default"},
                   @{@"title":@"设置", @"image":@"content_icon_shezhi_default"}];
        
    }
}

#pragma mark - 必要的方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSDictionary *data = _datas[indexPath.row];
  
    WZXFirstTableViewCell *firstCell = [tableView dequeueReusableCellWithIdentifier:@"firstCell"];
    firstCell.textLabel.font = [UIFont systemFontOfSize:16 * IPHONE6_HEIGHT];
    firstCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    firstCell.textLabel.text = data[@"title"];
    firstCell.imageView.image = [UIImage imageNamed:data[@"image"]];
    
    return firstCell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44 * IPHONE6_HEIGHT;
}
#pragma mark - 分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _datas.count;
}

#pragma mark - header
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.5;
}

#pragma mark - footer
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //取消点击至灰效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *data = _datas[indexPath.row];
    
    if ([data[@"title"] isEqualToString:@"学豆任务"]) {
        
        
    } else if ([data[@"title"] isEqualToString:@"充值"]) {
        WZXRechargeViewController *rechargeVC = [[WZXRechargeViewController alloc] init];
        rechargeVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:rechargeVC animated:YES];
    } else if ([data[@"title"] isEqualToString:@"消息提醒"]) {
        
    } else if ([data[@"title"] isEqualToString:@"推广有奖"]) {
        
    } else if ([data[@"title"] isEqualToString:@"在线客服"]) {
        WZXVideoCallViewController *videoCallVC = [[WZXVideoCallViewController alloc] init];
        videoCallVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:videoCallVC animated:YES];
        
    } else if ([data[@"title"] isEqualToString:@"我的学习组"]) {
        
    } else if ([data[@"title"] isEqualToString:@"教师申请"]) {
        
    } else if ([data[@"title"] isEqualToString:@"设置"]) {
        WZXSetViewController *setVC = [[WZXSetViewController alloc] init];
        setVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setVC animated:YES];
    } else if ([data[@"title"] isEqualToString:@"我的课时"]) {
        WZXMyClassViewController *myClassVC = [[WZXMyClassViewController alloc] init];
        myClassVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:myClassVC animated:YES];
    } else if ([data[@"title"] isEqualToString:@"我的课表"]) {
        WZXClassTimeViewController *classTimeVC = [[WZXClassTimeViewController alloc] init];
        classTimeVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:classTimeVC animated:YES];
    } else if ([data[@"title"] isEqualToString:@"我的课件"]) {
        WZXCourSewareViewController *courSewareVC = [[WZXCourSewareViewController alloc] init];
        courSewareVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:courSewareVC animated:YES];
    }else if ([data[@"title"] isEqualToString:@"收入详情"]) {
        WZXIncomeDetailViewController *incomeVC = [[WZXIncomeDetailViewController alloc] init];
        incomeVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:incomeVC animated:YES];
    }

}

#pragma mark headerViewDelegate
- (void)HeaderViewLogonAgora:(NSString *)roomId {
    idString = roomId;
    //修改登录状态
    [self set_state_login];
    NSDictionary *userDic = [WSTools getInfoObject: SaveUserModelKey];
    NSString *userId = [userDic objectForKey:@"email"];
    //登录
    [self do_login:userId];
    
}

- (void)HeaderViewLonOutAgora {
    [self set_state_logout];
    
    //登出
    [inst logout];

    
}

#pragma mark Agora方法

//加入通话
- (void) doJoin
{
    dispatch_async(dispatch_get_main_queue(), ^(){
        
        
        
        isJoined = true;
        [WSTools setBoolObject:isJoined forKey:AgoraIsJoined];

        //加入频道
        [inst channelJoin:idString];
        
        
        NSString *key = AgroaAPPID;
        
                if (enableMediaCertificate){
        
                    key = [KeyHelp createMediaKeyByAppID:AgroaAPPID
                                          appCertificate:AgroaCertificate1
                                             channelName:@""
                                                  unixTs:time(NULL)
                                               randomInt:(rand()%256 << 24) + (rand()%256 << 16) + (rand()%256 << 8) + (rand()%256)
                                                     uid:0
                                               expiredTs:0
                           ];
        

            }
    });
}
#pragma mark 登录
- (void) do_login: (NSString*)name{
    //时间戳
    unsigned expiredTime =  (unsigned)[[NSDate date] timeIntervalSince1970] + 3600;
    //加密方法
    NSString * token =  [self calcToken:AgroaAPPID certificate:AgroaCertificate1 account:name expiredTime:expiredTime];
    
    /* 登录方法
     appid id
     account 客户端自定义账号 最大128可见字符 保持唯一性
     tocken app id和AppCertificate生成的SingnalingKey
     uid 废弃 固定为0
     decicelId 设备号 目前无用 设置为空
     retry_time_in_s 登录重试时间 默认30s
     retry_count 登录重试次数 默认3次
     */
    [inst login2:AgroaAPPID
         account:name
           token:token
             uid:0
        deviceID:@""
 retry_time_in_s:60
     retry_count:5
     ];
    
    
}

//离开
- (void) doLeave
{
    if (!isJoined) return;
    dispatch_async(dispatch_get_main_queue(), ^(){
        isJoined = false;
        [WSTools setBoolObject:isLogin forKey:AgoraIsLogin];

        //离开频道
        [inst channelLeave:idString];
        //离开频道  当调用 joinChannelByKey() API 方法后，必须调用 leaveChannel() 结束通话，否则无法开始下一次通话。 不管当前是否在通话中，都可以调用 leaveChannel()，没有副作用。该方法会把会话相关的所有资源释放掉。该方法是异步操作，调用返回时并没有真正退出频道。在真正退出频道后，SDK 会触发 didLeaveChannelWithStats 回调。
        
        
    });
}
//修改登录失败状态
- (void)set_state_logout{
    isLogin = false;
    [WSTools setBoolObject:isLogin forKey:AgoraIsLogin];

    dispatch_async(dispatch_get_main_queue(), ^(){
        
        
    });
}
//修改登录成功状态
- (void)set_state_login{
    isLogin = true;
    [WSTools setBoolObject:isLogin forKey:AgoraIsLogin];

    dispatch_async(dispatch_get_main_queue(), ^(){
        
    });
}
//修改通话成功状态
- (void)set_state_in_call{
    isInCall = true;
    [WSTools setBoolObject:isInCall forKey:AgoraIsInCall];

    dispatch_async(dispatch_get_main_queue(), ^(){
        
        
    });
}
//修改通话失败状态
- (void)set_state_not_in_call{
    isInCall = false;
    [WSTools setBoolObject:isInCall forKey:AgoraIsInCall];

    dispatch_async(dispatch_get_main_queue(), ^(){
        
    });
}

#pragma mark Agora加密方法

- (NSString*)MD5:(NSString *)string {
    const char *ptr = [string UTF8String];
    
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(ptr, strlen(ptr), md5Buffer);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x",md5Buffer[i]];
    
    return output;
    
    
}

- (NSString *) calcToken:(NSString *)_appID certificate:(NSString *)certificate account:(NSString*)account expiredTime:(unsigned)expiredTime {
    // Token = 1:appID:expiredTime:sign
    // Token = 1:appID:expiredTime:md5(account + vendorID + certificate + expiredTime)
    //    expiredTime = 1544544000;
    //    account = @"20000685";
    
    NSString * sign = [self MD5:[NSString stringWithFormat:@"%@%@%@%d", account, _appID, certificate, expiredTime]];
    return [NSString stringWithFormat:@"1:%@:%d:%@", _appID, expiredTime, sign];
}

#pragma mark 网络请求

- (void)postTeacherType:(NSInteger)type {
    
    NSDictionary *parmater = @{@"type":@(type),@"roomId":idString};
    [AFTools postWithUrl:Request_Comm_IsOnline andParameters:parmater andSuccessBlock:^(id responseObject) {
        
        
        
        
    } andFaileBlock:^(NSError *error) {
        
    }];
    
    
    
    
}

#pragma mark - 观众主播身份判定
- (void)request:(NSInteger)roleInt{
    
    [self setupSubViewWithRoleName:roleInt];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
