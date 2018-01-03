//
//  UrlList.h
//  CNT
//
//  Created by YHY on 2017/12/4.
//  Copyright © 2017年 王智鑫. All rights reserved.
//





#ifndef UrlList_h
#define UrlList_h


#endif /* UrlList_h */
static NSString * const SaveUserModelKey = @"SaveUserModelKey";//保存用户信息的key
static NSString * const TokenKey = @"TokenKey";//保存用户token的key
static NSString * const DeviceToken = @"deviceTocken";//保存设备token的Key
static NSString * const AgoraIsLogin = @"isLogin";//agora信令登录状态
static NSString * const AgoraIsJoined = @"isJoiner";//agora信令加入状态
static NSString * const AgoraIsInCall = @"isInCall";//agora信令呼叫状态

#pragma mark 通知key
/// 登陆成功
static NSString * const LoginSuccessNotification = @"LoginSuccessNotificationKey";

#pragma mark - ********************登入************************
/**登入 - 获取邮箱验证*/
static NSString * const Request_Login_sendEamil = @"lucyAdmin/account/sendEamil";
/**登入 - 忘记密码*/
static NSString * const Request_login_forgotPassWord = @"lucyAdmin/comm/forgetPassWord";


#pragma mark - *********************首页模块 ********************
/**首页*/
static NSString * const Request_Course_Find_Home = @"lucyAdmin/course/find_home_course";

/**首页 - 选课中心_老师列表*/
static NSString * const Request_Appointment_TeacherList = @"lucyAdmin/appointment/teacherList";

/**首页 - 选课中心_老师列表_返回该老师的时间列表(可用时间,午休时间,不可用时间)*/
static NSString * const Request_Appointment_TeacherNotTimeList = @"lucyAdmin/appointment/teacherNotTimeList";

/**首页 - 更多课程 - 选择课程 - 课程详情*/
static NSString * const Request_Appointment_CourseMessage = @"lucyAdmin/appointment/courseMessage";

/**首页 - 更多课程 - 选择课程 - 课程详情 - 确认订单*/
static NSString * const Request_OrderPayt_ConfirmAnOrder = @"lucyAdmin/orderPay/confirmAnOrder";

/**上传设备tocken*/
static NSString *const Resuest_PushTocken = @"lucyAdmin/comm/deviceToken";

/**我的页面 - 上传教师状态*/
static NSString *const Request_Comm_IsOnline = @"lucyAdmin/comm/IsOnline";


