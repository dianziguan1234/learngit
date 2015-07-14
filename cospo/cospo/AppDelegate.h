//
//  AppDelegate.h
//  cospo
//
//  Created by gwc on 15/7/3.
//  Copyright (c) 2015年 gwc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "UMSocial.h"//友盟
#import "Config.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"

#import <AVOSCloud/AVOSCloud.h>//引入avoscloud聊天

#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"

#import "ClubViewController.h"
#import "ActivityViewController.h"
#import "CoolgirlViewController.h"
#import "PersonalViewController.h"
#import "CustomNavigationController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate,BMKLocationServiceDelegate>
{
    BMKMapManager *_mapManager;
    BMKLocationService *_locService;
}

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,retain)NSString *lat;
@property(nonatomic,retain)NSString *lng;

+(AppDelegate*)setGlobal;

- (RDVTabBarController *)setupViewControllers;
@end

