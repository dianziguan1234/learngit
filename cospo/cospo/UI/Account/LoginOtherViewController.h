//
//  LoginOtherViewController.h
//  cospo
//
//  Created by gwc on 15/7/3.
//  Copyright (c) 2015年 gwc. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"
#import "WXApi.h"
@interface LoginOtherViewController : BaseViewController
{
    UITextField *userTextField;
    UITextField *pwdTextField;
    
    UITextField *codeTextField;
    
    UIButton *codeBtn;
    int times;
    NSTimer *timer;
    int request_Index;
}
@property(nonatomic,assign)int state;
@end
