//
//  AppDelegate.m
//  CNT
//
//  Created by 王智鑫 on 2017/11/7.
//  Copyright © 2017年 王智鑫. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "WZXHomePageViewController.h"
#import "WZXAchievementViewController.h"
#import "WZXMineViewController.h"
#import "WZXTheratingViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
// 微信SDK头文件
#import "WXApi.h"
#import <FacebookConnector/FacebookConnector.h>
#import <Twitter/Twitter.h>
#import <FBSDKMessengerShareKit/FBSDKMessengerShareKit.h>
#import <TwitterKit/TwitterKit.h>
#import <Fabric/Fabric.h>
#import "VideoTalkManager.h"
#import "BasicNavigationController.h"

// wu test:
#import "WZXRegistrationPreViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) UITabBarController *tabBarC;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    // voip
    [[VideoTalkManager sharedClinet] initWithSever];
    
    /**初始化ShareSDK应用
     
     @param activePlatforms
     使用的分享平台集合
     @param importHandler (onImport)
     导入回调处理，当某个平台的功能需要依赖原平台提供的SDK支持时，需要在此方法中对原平台SDK进行导入操作
     @param configurationHandler (onConfiguration)
     配置回调处理，在此方法中根据设置的platformType来填充应用配置信息
     */
    [ShareSDK registerActivePlatforms:@[
                                        @(SSDKPlatformTypeSinaWeibo),
                                        @(SSDKPlatformTypeMail),
                                        @(SSDKPlatformTypeSMS),
                                        @(SSDKPlatformTypeCopy),
                                        @(SSDKPlatformTypeWechat),
                                        @(SSDKPlatformTypeQQ),
                                        @(SSDKPlatformTypeRenren),
                                        @(SSDKPlatformTypeFacebook),
                                        @(SSDKPlatformTypeTwitter),
                                        @(SSDKPlatformTypeGooglePlus),
                                        ]
                             onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeFacebook:
                 [ShareSDKConnector connectFacebookMessenger:[FBSDKMessengerSharer class]];
                 break;
             case SSDKPlatformTypeTwitter:
                 [[Twitter sharedInstance] startWithConsumerKey:@"asdsd"consumerSecret:@"sdasdsd"];
                 [Fabric with:@[[Twitter sharedInstance]]];
                break;
             default:
                 break;
         }
     }
                      onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 // 设置新浪微博应用信息, 其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
                                           appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                                         redirectUri:@"http://www.sharesdk.cn"
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wxe0da1d6087c8aa8e"
                                       appSecret:@"a63067be8a88be99737a66a91f2745b8"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"100371282"
                                      appKey:@"aed9b0303e3ed1e27bae87c33761161d"
                                    authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeRenren:
                 [appInfo        SSDKSetupRenRenByAppId:@"226427"
                                                 appKey:@"fc5b8aed373c4c27a05b712acba0f8c3"
                                              secretKey:@"f29df781abdd4f49beca5a2194676ca4"
                                               authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeFacebook:
                 [appInfo SSDKSetupFacebookByApiKey:@"1561616553907087"
                                          appSecret:@"641af21ae6f9049b2d878307c0d7d696"
                                        displayName:@"shareSDK"
                                           authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeTwitter:
                 [appInfo SSDKSetupTwitterByConsumerKey:@"BQ2rxesb5Fn1DSOEnkYZiyRum"
                                         consumerSecret:@"McMGNwR8laHxPrsyzyWsao0KeTRKGc5WcpA5ltTjLaqwmkSCUB"
                                            redirectUri:@"http://mob.com"];
                 break;
             case SSDKPlatformTypeGooglePlus:
                 [appInfo SSDKSetupGooglePlusByClientID:@"232554794995.apps.googleusercontent.com"
                                           clientSecret:@"PEdFgtrMw97aCvf0joQj7EMk"
                                            redirectUri:@"http://localhost"];
                 break;
             default:
                 break;
         }
     }];
    
#pragma mark - 首页
    
    WZXHomePageViewController *homePageVC = [[WZXHomePageViewController alloc] init];
    UINavigationController *homePageNaVC = [[BasicNavigationController alloc] initWithRootViewController:homePageVC];
    UIImage *homePageImage = [UIImage imageNamed:@"tabbar_icon_home_selected"];
    homePageImage = [homePageImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homePageNaVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"tabbar_icon_home_default"] selectedImage:homePageImage];
    homePageNaVC.navigationBar.translucent = YES;
    
#pragma mark 成就
    
    WZXAchievementViewController *achievementVC = [[WZXAchievementViewController alloc] init];
    UINavigationController *achievementNaVC = [[BasicNavigationController alloc] initWithRootViewController:achievementVC];
    UIImage *achievementImage = [UIImage imageNamed:@"tabbar_icon_achievement_selected"];
    achievementImage = [achievementImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    achievementNaVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"成就" image:[UIImage imageNamed:@"tabbar_icon_achievement_default"] selectedImage:achievementImage];
//    achievementNaVC.navigationBar.translucent = YES;
    
#pragma mark 我的
    
    WZXMineViewController *mineVC = [[WZXMineViewController alloc] init];
    UINavigationController *mineNaVC = [[BasicNavigationController alloc] initWithRootViewController:mineVC];
    UIImage *mineImage = [UIImage imageNamed:@"tabbar_icon_me_selected"];
    mineImage = [mineImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mineNaVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"tabbar_icon_me_default"] selectedImage:mineImage];
//    mineNaVC.navigationBar.translucent = YES;

    self.tabBarC = [[UITabBarController alloc] init];
    _tabBarC.viewControllers = [NSArray arrayWithObjects:homePageNaVC, achievementNaVC, mineNaVC, nil];
    
    // appearance 批量设置控件
    [self setupUIsAppearance];
    
    // 免费体验(外教1对1在线学汉语)
//    WZXTheratingViewController *theVC = [[WZXTheratingViewController alloc] init];
//    UINavigationController *theNav = [[UINavigationController alloc] initWithRootViewController:theVC];
//    self.window.rootViewController = theNav;
    
    // 监听登录页发来的通知, wu question: 哪些时候会发LoginSuccessNotification, 什么时候会删登陆状态?
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess:) name:LoginSuccessNotification object:nil];

    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"loginSuccess"]) {
        LoginViewController *loginV = [[LoginViewController alloc] init];
        self.window.rootViewController = [[BasicNavigationController alloc] initWithRootViewController:loginV];
    } else {
        self.window.rootViewController = _tabBarC;
    }
    
    // wu test:
    self.window.rootViewController = [[BasicNavigationController alloc] initWithRootViewController:[WZXRegistrationPreViewController new]];
    
    [self.window makeKeyAndVisible];

    return YES;
}
- (void)loginSuccess:(NSNotification *)notification{
    NSString *str = [notification object]; // @"1"
    [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"loginSuccess"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.window.rootViewController = _tabBarC;
    _tabBarC.selectedIndex = 0;
}

#pragma mark 批量设置控件
- (void)setupUIsAppearance {
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
}

- (void)applicationWillResignActive:(UIApplication *)application { }
- (void)applicationDidEnterBackground:(UIApplication *)application { }
- (void)applicationWillEnterForeground:(UIApplication *)application { }
- (void)applicationDidBecomeActive:(UIApplication *)application { }
- (void)applicationWillTerminate:(UIApplication *)application { }

@end
