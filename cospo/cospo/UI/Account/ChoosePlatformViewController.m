//
//  ChoosePlatformViewController.m
//  cospo
//
//  Created by gwc on 15/7/3.
//  Copyright (c) 2015年 gwc. All rights reserved.
//

#import "ChoosePlatformViewController.h"
#import "LoginOtherViewController.h"
@interface ChoosePlatformViewController ()

@end

@implementation ChoosePlatformViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    
    self.navigationController.navigationBarHidden=YES;
    [[self rdv_tabBarController] setTabBarHidden:YES animated:NO];
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:NO];
    self.navigationController.navigationBarHidden=NO;
    [[self rdv_tabBarController] setTabBarHidden:NO animated:NO];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tap];
    UIView *mainView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 480+(iPhone5?88:0))];
    mainView.backgroundColor=[UIColor yellowColor];
    [mainView addSubview:[self customImageView:mainView.frame image:IMAGE(@"accountBG")]];
    [mainView addSubview:[self customImageView:CGRectMake((WIDTH-74)/2, 64, 74, 132) image:IMAGE(@"account_logoIcon")]];
    UIView *loginView=[[UIView alloc]initWithFrame:CGRectMake(0, 64+132+48, mainView.frame.size.width, 80)];
    loginView.backgroundColor=[UIColor clearColor];
    [loginView addSubview:[self customImageView:CGRectMake(30, (loginView.frame.size.height/2-24)/2, 24, 24) image:IMAGE(@"account_mobile")]];
    //手机号
    userTextField=[[UITextField alloc] initWithFrame:CGRectMake(30+16+14, (loginView.frame.size.height/2-20)/2, WIDTH-60, 20)];
    userTextField.delegate=self;
    userTextField.keyboardType=UIKeyboardTypeNumberPad;
    userTextField.textAlignment=NSTextAlignmentLeft;
    userTextField.borderStyle=UITextBorderStyleNone;
    userTextField.placeholder=@"请输入手机号";
    userTextField.textColor=[UIColor whiteColor];
    userTextField.returnKeyType=UIReturnKeyDone;
    userTextField.font=[UIFont systemFontOfSize:16.0];
    userTextField.tintColor = kUIColorFromRGB(activity_titleColor);//设置光标颜色
    [userTextField setValue:kUIColorFromRGB(0x919191) forKeyPath:@"_placeholderLabel.textColor"];
    [userTextField setValue:[UIFont systemFontOfSize:16.0] forKeyPath:@"_placeholderLabel.font"];
    userTextField.textColor=kUIColorFromRGB(activity_titleColor);
    [loginView addSubview:[self drawLinebg:CGRectMake(30, loginView.frame.size.height/2, mainView.frame.size.width-30*2, 0.5) lineColor:kUIColorFromRGB(0x919191)]];
    
    //密码
    [loginView addSubview:[self customImageView:CGRectMake(30, loginView.frame.size.height/2+(loginView.frame.size.height/2-24)/2, 24, 24) image:IMAGE(@"account_pwd")]];
    pwdTextField=[[UITextField alloc] initWithFrame:CGRectMake(30+16+14, loginView.frame.size.height/2+(loginView.frame.size.height/2-20)/2, WIDTH-60, 20)];
    pwdTextField.delegate=self;
    pwdTextField.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    pwdTextField.textAlignment=NSTextAlignmentLeft;
    pwdTextField.borderStyle=UITextBorderStyleNone;
    pwdTextField.secureTextEntry=YES;
    pwdTextField.placeholder=@"请输入密码";
    pwdTextField.textColor=[UIColor whiteColor];
    pwdTextField.font=[UIFont systemFontOfSize:16.0];
    pwdTextField.returnKeyType=UIReturnKeyDone;
    pwdTextField.tintColor = kUIColorFromRGB(activity_titleColor);//设置光标颜色
    [pwdTextField setValue:kUIColorFromRGB(0x919191) forKeyPath:@"_placeholderLabel.textColor"];
    [pwdTextField setValue:[UIFont systemFontOfSize:16.0] forKeyPath:@"_placeholderLabel.font"];
    pwdTextField.textColor=kUIColorFromRGB(activity_titleColor);
    [loginView addSubview:pwdTextField];
    [loginView addSubview:[self drawLinebg:CGRectMake(30, loginView.frame.size.height-0.5, mainView.frame.size.width-30*2, 0.5) lineColor:kUIColorFromRGB(0x919191)]];
    
    UIView *signAndPwdView=[[UIView alloc] initWithFrame:CGRectMake(0, loginView.frame.size.height+loginView.frame.origin.y+30, mainView.frame.size.width, 40)];
    signAndPwdView.backgroundColor=[UIColor clearColor];
     [signAndPwdView addSubview:[self customLabel:CGRectMake(30,(signAndPwdView.frame.size.height-20)/2, 100, 20) color:kUIColorFromRGB(activity_titleColor) text:@"用户注册" alignment:-1 font:13.0]];
    [signAndPwdView addSubview:[self customButton:CGRectMake(0, 0, signAndPwdView.frame.size.width/2, signAndPwdView.frame.size.height) backgroungImageNormal:nil backgrounImageSelect:nil title:nil tag:1 titleColor:nil]];
    
    [signAndPwdView addSubview:[self customLabel:CGRectMake(signAndPwdView.frame.size.width-100-30,(signAndPwdView.frame.size.height-20)/2, 100, 20) color:kUIColorFromRGB(activity_titleColor) text:@"忘记密码" alignment:1 font:13.0]];
    [signAndPwdView addSubview:[self customButton:CGRectMake(signAndPwdView.frame.size.width/2, 0, signAndPwdView.frame.size.width/2, signAndPwdView.frame.size.height) backgroungImageNormal:nil backgrounImageSelect:nil title:nil tag:2 titleColor:nil]];
    //登录按钮
    UIButton *loginBtn=[self customButton:CGRectMake(30, signAndPwdView.frame.size.height+signAndPwdView.frame.origin.y+30-10, WIDTH-30*2, 40) backgroungImageNormal:IMAGE(@"btn_unselect") backgrounImageSelect:IMAGE(@"btn_select") title:@"登陆" tag:3 titleColor:[UIColor whiteColor]];
    
    if ([WXApi isWXAppInstalled])//判断是否安装微信客户端
    {
        
        //第三方登陆
        UIView *loginWithOtherView=[[UIView alloc] initWithFrame:CGRectMake(0, loginBtn.frame.size.height+loginBtn.frame.origin.y+30-10, mainView.frame.size.width, 60)];
        loginWithOtherView.backgroundColor=[UIColor clearColor];
        [loginWithOtherView addSubview:[self drawLinebg:CGRectMake(50, 10, 50, 0.5) lineColor:kUIColorFromRGB(0x919191)]];
        [loginWithOtherView addSubview:[self customLabel:CGRectMake((loginWithOtherView.frame.size.width-100)/2, 0, 100, 20) color:kUIColorFromRGB(activity_titleColor)  text:@"第三方登录" alignment:0 font:13.0]];
        [loginWithOtherView addSubview:[self drawLinebg:CGRectMake(loginWithOtherView.frame.size.width-50-50, 10, 50, 0.5) lineColor:kUIColorFromRGB(0x919191)]];
        [loginWithOtherView addSubview:[self customButton:CGRectMake((loginWithOtherView.frame.size.width-36)/2, ((loginWithOtherView.frame.size.height-20)-27)/2+20, 36, 36) backgroungImageNormal:IMAGE(@"wechat_unselect") backgrounImageSelect:IMAGE(@"wechat_select") title:nil tag:4 titleColor:nil]];
        [mainView addSubview:loginWithOtherView];
        
        
    }
    
    [mainView addSubview:loginBtn];
    [mainView addSubview:signAndPwdView];
    [mainView addSubview:loginView];
    [loginView addSubview:pwdTextField];
    [loginView addSubview:userTextField];
    [mainView addSubview:loginView];
    [self.view addSubview:mainView];
    

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [userTextField resignFirstResponder];
    [pwdTextField resignFirstResponder];
    return YES;
}
-(void)dealBtnEvent:(UIButton *)sender
{
    if (sender.tag==1)
    {
        //用户注册
        LoginOtherViewController *other=[[LoginOtherViewController alloc] init];
        other.state=1;
        other.title=@"用户注册";
        
        [self.navigationController pushViewController:other animated:YES];
    }
    else if (sender.tag==2)
    {
        //忘记密码
        LoginOtherViewController *other=[[LoginOtherViewController alloc] init];
        other.state=2;
        other.title=@"忘记密码";
        
        [self.navigationController pushViewController:other animated:YES];
    }
    else if (sender.tag==3)
    {
        //登录
        if (userTextField.text.length>0 && pwdTextField.text.length>0)
        {
            request_Index=1;
            //[[self JsonFactory] login:userTextField.text passsword:pwdTextField.text method:POSTMethod action:@"v1/users/signin.json"];
            [[self JsonFactory]login:userTextField.text passsword:pwdTextField.text method:POSTMethod action:@"v3/users/signin.json"];
        }
        else
        {
            [self alertOnly:@"请输入账号密码"];
        }
        
    }
    else if (sender.tag==4)
    {
        //第三方登录--微信
        [self loginWithWeChat];
    }
}
-(void)handleTap:(UIGestureRecognizer *)gesture
{
    [self.view endEditing:YES];
    [userTextField resignFirstResponder];
    [pwdTextField resignFirstResponder];
    
    
}

-(void)JSONSuccess:(id)responseObject
{
    if (responseObject && [[responseObject objectForKey:@"code"] intValue]==0 && request_Index==1)
    {
        //保存账号、密码
        [[NSUserDefaults standardUserDefaults] setObject:userTextField.text forKey:@"COSPO_NAME"];
        [[NSUserDefaults standardUserDefaults] setObject:pwdTextField.text forKey:@"COSPO_PWD"];
        [[NSUserDefaults standardUserDefaults] setObject:[responseObject objectForKey:@"data"]forKey:@"COSPO_LoginInfo"];
        NSLog(@"data::%@",[responseObject objectForKey:@"data"]);
        //单例赋值
        //[AppDelegate setGlobal].personInfoDictionary=[[[NSUserDefaults standardUserDefaults] objectForKey:@"COSPO_LoginInfo"] objectForKey:@"user"];
        
        //设置订阅_channels
        
         AVInstallation *currentInstallation = [AVInstallation currentInstallation];
        [currentInstallation setObject:[NSArray arrayWithObject:[NSString stringWithFormat:@"u%@",[[[NSUserDefaults standardUserDefaults] objectForKey:@"COSPO_LoginInfo"] objectForKey:@"uid"]] ]forKey:@"channels"];
        [currentInstallation saveInBackground];
         
        [self presentViewController:[[AppDelegate setGlobal] setupViewControllers] animated:YES completion:^{
            
        }];
    }else if ([[responseObject objectForKey:@"code"] intValue]==1001)
    {
        [self alertOnly:@"密码有误"];//错误提示
        
    }else if (responseObject && [[responseObject objectForKey:@"code"] intValue]==0 && request_Index==3)
    {
        //微信登陆
        //保存用户信息
        [[NSUserDefaults standardUserDefaults] setObject:[responseObject objectForKey:@"data"]forKey:@"COSPO_LoginInfo"];
        NSLog(@"weixin ::%@",[responseObject objectForKey:@"data"]);
        
        //单例赋值
        //[AppDelegate setGlobal].personInfoDictionary=[[[NSUserDefaults standardUserDefaults] objectForKey:@"COSPO_LoginInfo"] objectForKey:@"user"];
        
        //设置订阅_channels
        AVInstallation *currentInstallation = [AVInstallation currentInstallation];
        [currentInstallation setObject:[NSArray arrayWithObject:[NSString stringWithFormat:@"u%@",[[[NSUserDefaults standardUserDefaults] objectForKey:@"COSPO_LoginInfo"] objectForKey:@"uid"]] ]forKey:@"channels"];
        [currentInstallation saveInBackground];
        
        
         [self presentViewController:[[AppDelegate setGlobal] setupViewControllers] animated:YES completion:^{
         
         }];
        

    }


}

//微信登录
-(void)loginWithWeChat
{
    // NSLog(@"微信登录");
    if ([WXApi isWXAppInstalled])//判断是都存在客户端
    {
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
        //点击微信界面上的登录按钮
        snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
            //NSLog(@"response is %@",response);
            if (response.responseCode ==200)
            {
                //得到的数据在回调Block对象形参respone的data属性
                [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToWechatSession  completion:^(UMSocialResponseEntity *response){
                    //NSLog(@"SnsInformation is %@",response.data);
                    
                    //1.管理器
                    AFHTTPRequestOperationManager *manager= [AFHTTPRequestOperationManager manager];
                    //2.0 设置请求格式
                    //manager.requestSerializer=[AFJSONRequestSerializer serializer];
                    
                    //2.1 设置返回数据类型
                    manager.responseSerializer = [AFJSONResponseSerializer serializer]; //先实例化一下
                    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/plain"];
                    // https://api.weixin.qq.com/sns/userinfo?access_token=ACCESS_TOKEN&openid=OPENID
                    
                    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
                    [bodyDic setObject:[response.data objectForKey:@"access_token"] forKey:@"access_token"];
                    [bodyDic setObject:[response.data objectForKey:@"openid"] forKey:@"openid"];
                    // [bodyDic setObject:@"zh_CN" forKey:@"lang"];
                    
                    // NSLog(@"bodyDic::%@",bodyDic);
                    
                    [manager GET:[NSString stringWithFormat:@"%@",@"https://api.weixin.qq.com/sns/userinfo"]
                      parameters:bodyDic
                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                             
                             //NSLog(@"success=>%@",responseObject);
                             request_Index=3;
                             
                             NSString *sex=nil;
                             if ([[response.data objectForKey:@"gender"] intValue]==1)
                             {
                                 sex=@"0";
                             }
                             else
                             {
                                 sex=@"1";
                             }
                             
                             [[self JsonFactory] weixin_sign:[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"unionid"]] nickname:[response.data objectForKey:@"screen_name"] sex:sex  avatar_url:[response.data objectForKey:@"profile_image_url"]  addr:[response.data objectForKey:@"location"] method:POSTMethod action:@"v3/users/weixin-signin.json"];
                             
                             
                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                             
                             // NSLog(@"error=>%@",error);
                             
                         }];
                    
                }];
            }
        });
        
    }
    
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
