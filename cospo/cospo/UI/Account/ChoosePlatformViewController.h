//
//  ChoosePlatformViewController.h
//  cospo
//
//  Created by gwc on 15/7/3.
//  Copyright (c) 2015年 gwc. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"
#import "WXApi.h"
@interface ChoosePlatformViewController : BaseViewController
{
    UITextField *userTextField;
    UITextField *pwdTextField;
    int request_Index;
}
@end
