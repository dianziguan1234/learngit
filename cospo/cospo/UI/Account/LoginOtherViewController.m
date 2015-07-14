//
//  LoginOtherViewController.m
//  cospo
//
//  Created by gwc on 15/7/3.
//  Copyright (c) 2015年 gwc. All rights reserved.
//

#import "LoginOtherViewController.h"

@interface LoginOtherViewController ()

@end

@implementation LoginOtherViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    self.navigationController.navigationBarHidden=NO;
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
    [mainView addSubview:[self customImageView:CGRectMake((WIDTH-74)/2, 20, 74, 132) image:IMAGE(@"account_logoIcon")]];
    
    //登录框
    UIView *loginView=[[UIView alloc] initWithFrame:CGRectMake(0, 50+97+20, mainView.frame.size.width, 120)];
    loginView.backgroundColor=[UIColor clearColor];
    [loginView addSubview:[self customImageView:CGRectMake(30, (loginView.frame.size.height/3-24)/2, 24, 24) image:IMAGE(@"account_mobile")]];
    userTextField=[[UITextField alloc] initWithFrame:CGRectMake(30+16+14, (loginView.frame.size.height/3-20)/2, WIDTH-60, 20)];
    userTextField.delegate=self;
    userTextField.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    userTextField.textAlignment=NSTextAlignmentLeft;
    userTextField.borderStyle=UITextBorderStyleNone;
    userTextField.placeholder=@"请输入手机号";
    userTextField.textColor=[UIColor whiteColor];
    userTextField.returnKeyType=UIReturnKeyDone;
    userTextField.font=[UIFont systemFontOfSize:16.0];
    userTextField.tintColor = kUIColorFromRGB(activity_titleColor);//设置光标颜色
    [userTextField setValue:kUIColorFromRGB(0x919191) forKeyPath:@"_placeholderLabel.textColor"];
    [userTextField setValue:[UIFont systemFontOfSize:16.0] forKeyPath:@"_placeholderLabel.font"];
    userTextField.textColor=kUIColorFromRGB(0x919191);
    
    [loginView addSubview:userTextField];
    [loginView addSubview:[self drawLinebg:CGRectMake(30, loginView.frame.size.height/3, mainView.frame.size.width-30*2, 0.5) lineColor:kUIColorFromRGB(0x919191)]];
    
    //密码
    [loginView addSubview:[self customImageView:CGRectMake(30, loginView.frame.size.height/3+(loginView.frame.size.height/3-24)/2, 24, 24) image:IMAGE(@"account_pwd")]];
    pwdTextField=[[UITextField alloc] initWithFrame:CGRectMake(30+16+14, loginView.frame.size.height/3+(loginView.frame.size.height/3-20)/2, WIDTH-60, 20)];
    pwdTextField.delegate=self;
    pwdTextField.keyboardType=UIKeyboardTypeASCIICapable;
    pwdTextField.textAlignment=NSTextAlignmentLeft;
    pwdTextField.borderStyle=UITextBorderStyleNone;
    pwdTextField.secureTextEntry=YES;
    if (self.state==1)
    {
        pwdTextField.placeholder=@"请输入密码";
    }else if (self.state==2)
    {
        pwdTextField.placeholder=@"请输入新密码";
    }
   
    pwdTextField.textColor=[UIColor whiteColor];
    pwdTextField.font=[UIFont systemFontOfSize:16.0];
    pwdTextField.returnKeyType=UIReturnKeyDone;
    pwdTextField.tintColor = kUIColorFromRGB(activity_titleColor);//设置光标颜色
    [pwdTextField setValue:kUIColorFromRGB(0x919191) forKeyPath:@"_placeholderLabel.textColor"];
    [pwdTextField setValue:[UIFont systemFontOfSize:16.0] forKeyPath:@"_placeholderLabel.font"];
    pwdTextField.textColor=kUIColorFromRGB(0x919191);
    [loginView addSubview:pwdTextField];
    [loginView addSubview:[self drawLinebg:CGRectMake(30, loginView.frame.size.height/3*2-0.5, mainView.frame.size.width-30*2, 0.5) lineColor:kUIColorFromRGB(0x919191)]];
    
    //验证码
    codeTextField=[[UITextField alloc] initWithFrame:CGRectMake(30+16+14, loginView.frame.size.height/3*2+(loginView.frame.size.height/3-20)/2, WIDTH-60, 20)];
    codeTextField.delegate=self;
    codeTextField.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    codeTextField.textAlignment=NSTextAlignmentLeft;
    codeTextField.borderStyle=UITextBorderStyleNone;
    codeTextField.placeholder=@"验证码";
    codeTextField.textColor=[UIColor whiteColor];
    codeTextField.font=[UIFont systemFontOfSize:16.0];
    codeTextField.returnKeyType=UIReturnKeyDone;
    codeTextField.tintColor = kUIColorFromRGB(activity_titleColor);//设置光标颜色
    [codeTextField setValue:kUIColorFromRGB(0x919191) forKeyPath:@"_placeholderLabel.textColor"];
    [codeTextField setValue:[UIFont systemFontOfSize:16.0] forKeyPath:@"_placeholderLabel.font"];
    codeTextField.textColor=kUIColorFromRGB(activity_titleColor);
    [loginView addSubview:codeTextField];
    [loginView addSubview:[self drawLinebg:CGRectMake(30, loginView.frame.size.height-0.5, mainView.frame.size.width-30*2-110, 0.5) lineColor:kUIColorFromRGB(0x919191)]];
    
    codeBtn=[self customButton:CGRectMake(mainView.frame.size.width-30-100, loginView.frame.size.height/3*2+(loginView.frame.size.height/3-40)/2+2, 100, 38) backgroungImageNormal:IMAGE(@"code_unslect") backgrounImageSelect:IMAGE(@"code_select") title:@"验证码" tag:2 titleColor:[UIColor whiteColor]];
    codeBtn.titleLabel.font=[UIFont fontWithName:nil size:16];
    [loginView addSubview:codeBtn];
    
    UIButton *loginBtn=nil;
    if (self.state==1)
    {
        //用户注册
        loginBtn=[self customButton:CGRectMake(30, loginView.frame.size.height+loginView.frame.origin.y+50, WIDTH-30*2, 40) backgroungImageNormal:IMAGE(@"btn_unselect") backgrounImageSelect:IMAGE(@"btn_select") title:@"注册并登陆" tag:0 titleColor:[UIColor whiteColor]];
    }
    else if(self.state==2)
    {
        loginBtn=[self customButton:CGRectMake(30, loginView.frame.size.height+loginView.frame.origin.y+50, WIDTH-30*2, 40) backgroungImageNormal:IMAGE(@"btn_unselect") backgrounImageSelect:IMAGE(@"btn_select") title:@"完成" tag:0 titleColor:[UIColor whiteColor]];
    }
    
    [mainView addSubview:loginBtn];
    [mainView addSubview:loginView];
    [self.view addSubview:mainView];
    
}

-(void)dealBtnEvent:(UIButton *)sender
{
    if (sender.tag==0)
    {
        if (self.state==1)
        {
            //注册
            if (userTextField.text.length>0 && [self checkPhoneNumInput:userTextField.text] && pwdTextField.text.length>0 && codeTextField.text.length>0)
            {
                request_Index=2;
                //[[self JsonFactory] sign:userTextField.text password:pwdTextField.text password_confirmation:pwdTextField.text nickname:@"" check_token:[codeDic objectForKey:@"check_token"] check_code:codeTextField.text method:@"POST" action:@"v1/users.json"];
                [[self JsonFactory]sign:userTextField.text password:pwdTextField.text password_confirmation:pwdTextField.text check_code:@"000000" method:POSTMethod action:@"v3/users.json"];
                NSLog(@"注册");
                NSLog(@"userTextField.text::%@",userTextField.text);
                NSLog(@"pwdTextField::%@",pwdTextField.text);
            }
            else
            {
                [self alertOnly:@"请检查是否有输入项目未输入"];
            }
        }
        else if(self.state==2 )
        {
            //忘记密码
            if (userTextField.text.length>0 && [self checkPhoneNumInput:userTextField.text] && codeTextField.text.length>0 && pwdTextField.text.length>0)
            {
                //request_Index=3;
                //[[self JsonFactory] reset:userTextField.text check_code:codeTextField.text new_password:pwdTextField.text method:POSTMethod action:@"v1/users/reset-password"];
                NSLog(@"忘记密码");
            }
            else
            {
                [self alertOnly:@"请检查您是否输入完整的手机号,验证码以及新设置的密码"];
            }
            
        }
    }
        /*
        else if(state==4)
        {
            if ([self checkPhoneNumInput:userTextField.text] && codeTextField.text.length>0)
            {
                request_Index=4;
                [[self JsonFactory] bindMobile:[[[NSUserDefaults standardUserDefaults] objectForKey:@"COSPO_LoginInfo"] objectForKey:@"uid"] mobile:userTextField.text check_code:codeTextField.text check_token:[codeDic objectForKey:@"check_token"] method:POSTMethod action:@"v1/users/bind-mobile.json"];
            }
            else
            {
                [self alertOnly:@"请检查是否有输入项目未输入"];
            }
            
        }
        
    }*/
    else if(sender.tag==2)
    {
        //获取验证码
        //1.首先判断输入的是否是手机号
        if ([self checkPhoneNumInput:userTextField.text])
        {
            //request_Index=1;
            //[[self JsonFactory] checkcode:userTextField.text method:POSTMethod action:@"v1/users/send-checkcode.json"];
            NSLog(@"获取验证码");
            
            codeBtn.enabled=NO;//按钮不可点击
            
            times=60;
            [codeBtn setTitle:[NSString stringWithFormat:@"%d 秒",times] forState:UIControlStateNormal];
            //[codeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            
            timer= [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(reduceTime) userInfo:nil repeats:YES];
            
        }
        else
        {
            [self alertOnly:@"您输入的手机号有误,请核对后重新输入"];
        }
    }
}

//判断是否是手机号
-(BOOL)checkPhoneNumInput:(NSString *)text
{
    
    NSString *regex =@"(13[0-9]|0[1-9]|0[1-9][0-9]|0[1-9][0-9][0-9]|15[0-9]|18[02356789])\\d{8}";
    
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [mobileTest evaluateWithObject:text];
    
}


-(void)reduceTime
{
    times--;
    [codeBtn setTitle:[NSString stringWithFormat:@"%d 秒",times] forState:UIControlStateNormal];
    [codeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    if (times==0)
    {
        [timer invalidate];
        timer=nil;
        
        //按钮倒计时间
        codeBtn.enabled=YES;
        [codeBtn setTitle:@"验证码" forState:UIControlStateNormal];
        //[codebtn setTitleColor:kUIColorFromRGB(0xec0970) forState:UIControlStateNormal];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [userTextField resignFirstResponder];
    [pwdTextField resignFirstResponder];
    [codeTextField resignFirstResponder];
    return YES;
}
-(void)handleTap:(UIGestureRecognizer *)gesture
{
    [self.view endEditing:YES];
    [userTextField resignFirstResponder];
    [pwdTextField resignFirstResponder];
    [codeTextField resignFirstResponder];
    
}

-(void)JSONSuccess:(id)responseObject
{
    if (responseObject && [[responseObject objectForKey:@"code"] intValue]==0&&request_Index==2) {
        //表示注册登陆
        //保存账号、密码
        [[NSUserDefaults standardUserDefaults] setObject:userTextField.text forKey:@"COSPO_NAME"];
        [[NSUserDefaults standardUserDefaults] setObject:pwdTextField.text forKey:@"COSPO_PWD"];
        [[NSUserDefaults standardUserDefaults] setObject:[responseObject objectForKey:@"data"]forKey:@"COSPO_LoginInfo"];
        
        //单例赋值
        //[AppDelegate setGlobal].personInfoDictionary=[[[NSUserDefaults standardUserDefaults] objectForKey:@"COSPO_LoginInfo"] objectForKey:@"user"];
        
        //设置订阅_channels
        AVInstallation *currentInstallation = [AVInstallation currentInstallation];
        [currentInstallation setObject:[NSArray arrayWithObject:[NSString stringWithFormat:@"u%@",[[[NSUserDefaults standardUserDefaults] objectForKey:@"COSPO_LoginInfo"] objectForKey:@"uid"]] ]forKey:@"channels"];
        [currentInstallation saveInBackground];
        
        //self.view.window.rootViewController=[[AppDelegate setGlobal] setupViewControllers];
       
         [self presentViewController:[[AppDelegate setGlobal] setupViewControllers] animated:YES completion:^{
         
         }];
        

    }else{
        [self alertOnly:[[responseObject objectForKey:@"msg"] description]];
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
