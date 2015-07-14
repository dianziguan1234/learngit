//
//  AppDelegate.m
//  cospo
//
//  Created by gwc on 15/7/3.
//  Copyright (c) 2015年 gwc. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
- (RDVTabBarController *)setupViewControllers
{
    ClubViewController *club=[[ClubViewController alloc]init];
    CustomNavigationController *clubNav=[[CustomNavigationController alloc]initWithRootViewController:club];
    
    ActivityViewController *activity=[[ActivityViewController alloc]init];
    CustomNavigationController *activityNav=[[CustomNavigationController alloc]initWithRootViewController:activity];
    
    CoolgirlViewController *cool=[[CoolgirlViewController alloc]init];
    CustomNavigationController *coolNav=[[CustomNavigationController alloc]initWithRootViewController:cool];
    
    PersonalViewController *person=[[PersonalViewController alloc]init];
    CustomNavigationController *personNav=[[CustomNavigationController alloc]initWithRootViewController:person];
    RDVTabBarController *custabBarController = [[RDVTabBarController alloc] init];
    custabBarController.tabBar.backgroundView.backgroundColor=kUIColorFromRGB(tabBarback_Color);
    [custabBarController setViewControllers:@[clubNav,activityNav,coolNav,personNav]];
     [self customizeTabBarForController:custabBarController];
    return custabBarController;
    
}
- (void)customizeTabBarForController:(RDVTabBarController *)rdtabBarController
{
    UIImage *finishedImage = [UIImage imageNamed:@"tabSelect"];//选中
    //UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_unselected"];//未选中
    
    
    NSArray *tabTitleArray=@[@"俱乐部",@"活动",@"coolGirl",@"我"];
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[rdtabBarController tabBar] items])
    {
        //设置item的选中与未选中的背景图
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:nil];
        
        //UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"select_icon%d",(int)(index+1)]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"unselect_icon%d",(int)(index+1)]];
        
        //设置选中与未选中的图标
        [item setFinishedSelectedImage:unselectedimage withFinishedUnselectedImage:unselectedimage];
        
        
        //设置文字
        item.title=[tabTitleArray objectAtIndex:index];
        item.unselectedTitleAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:13.0],NSForegroundColorAttributeName:kUIColorFromRGB(0xffffff)};
        item.selectedTitleAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:13.0],NSForegroundColorAttributeName:kUIColorFromRGB(0xffffff)};
        
        
        index++;
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    //添加视图
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor=[UIColor whiteColor];
    self.window.rootViewController=[self setupViewControllers];
    //设置百度地图
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定key generalDelegate参数
    BOOL ret = [_mapManager start:BaiDu_key  generalDelegate:self];
    if (!ret)
    {
        NSLog(@"manager start failed!");
    }
    
    //设置定位精确度，默认：kCLLocationAccuracyBest
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    //指定最小距离更新(米)，默认：kCLDistanceFilterNone
    [BMKLocationService setLocationDistanceFilter:100.f];
    
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    
    //设置分享appkey
    [UMSocialData setAppKey:UMENG_APPKEY];
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:WXid
                            appSecret:WXkey
                                  url:@"http://www.cospo.org/"];
    
    //设置QQ
    [UMSocialQQHandler setQQWithAppId:QQid
                               appKey:QQkey
                                  url:@"http://www.cospo.org/"];
    //
    [AVOSCloud setApplicationId:@"2nayzni66nsmusomzihcctnfeyk213bzx0ywyadux7ht6vnm" clientKey:@"baul9agbq1y1cwj96ga7v6yya9lbujvr4sn3cu0h4pxci5q9"];
    //推送设置
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
        
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    }
    else
    {
        [application registerForRemoteNotificationTypes:
         UIRemoteNotificationTypeBadge |
         UIRemoteNotificationTypeAlert |
         UIRemoteNotificationTypeSound];
    }
    
    //选择证书--测试证书
    [AVPush setProductionMode:NO];
    
    
    [self.window makeKeyAndVisible];
    return YES;
}

//推送获取设备token
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    
    NSLog(@"error::%@",error);
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"deviceToken:::::::%@",deviceToken);
    AVInstallation *currentInstallation = [AVInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
    
}
//接收到通知。
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSLog(@"userInfo::%@",userInfo);
}

//回调跳转函数
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}


//百度地图回调函数
- (void)onGetNetworkState:(int)iError
{
    //判断是否联网成功
    if (0 == iError)
    {
        NSLog(@"联网成功");
    }
    else{
         NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    //是否百度地图可以正常显示
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else
    {
        NSLog(@"onGetPermissionState %d",iError);
    }
}


//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //NSLog(@"heading is %@",userLocation.heading);
}


//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
     NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [AppDelegate setGlobal].lat=[NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude];
    [AppDelegate setGlobal].lng=[NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];
}

-(void)didFailToLocateUserWithError:(NSError *)error
{
    //NSLog(@"didFailToLocateUserWithError %@",error);
    
    [AppDelegate setGlobal].lat=@"";
    [AppDelegate setGlobal].lng=@"";
    
}

//设置全局参数
+(AppDelegate*)setGlobal
{
    return (AppDelegate*)[[UIApplication sharedApplication]delegate];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
