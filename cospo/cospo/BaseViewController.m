//
//  ViewController.m
//  cospo
//
//  Created by gwc on 15/7/3.
//  Copyright (c) 2015年 gwc. All rights reserved.
//

#import "BaseViewController.h"
#import "ChoosePlatformViewController.h"
#import "CustomNavigationController.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //定义文件
    document= [[ReadWriteToDocument alloc]init];
    document.folderName=@"Cospo";

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma -
#pragma -request请求
-(AFJSONFactory *)JsonFactory
{
    AFJSONFactory *jsonFactory=[[AFJSONFactory alloc] init];
    jsonFactory.delegate=self;
    
    return jsonFactory;
}

#pragma -
#pragma --JSONDataReturnDelegate
#pragma --SUCCESS
-(void)JSONSuccess:(id)responseObject
{
    
}


#pragma --ERROR
-(void)JSONError:(NSError *)error
{
    /*
     NSLog(@"code::%ld",(long)error.code);
     NSLog(@"domain::%@",error.domain);
     NSLog(@"userInfo::%@",error.userInfo);
     */
    
    if (error.code==0 && !error.domain && !error.userInfo)
    {
        [self alertOnly:@"由于网络或者服务器后台出问题,请稍后重新刷新..."];
    }
    else if (error.code==-1011)
    {
        [self alertOnly:@"服务器异常"];
    }
    /*
     NSData *jsonData = [error.description dataUsingEncoding:NSUTF8StringEncoding];
     NSError *err=nil;
     NSDictionary *jsonDic= [NSJSONSerialization JSONObjectWithData:jsonData
     options:NSJSONReadingMutableContainers
     error:&err];
     
     NSLog(@"jsonDic::%@",jsonDic);
     */
    
    
    
}

-(void)JSONExit //退出
{
    //清除账号、密码
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"COSPO_NAME"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"COSPO_PWD"];
    //清除用户信息
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"COSPO_LoginInfo"];
    
    ChoosePlatformViewController *platform=[[ChoosePlatformViewController alloc] init];
    CustomNavigationController *navPlatform=[[CustomNavigationController alloc] initWithRootViewController:platform];
    navPlatform.navigationBarHidden=YES;//隐藏导航栏
    
    self.view.window.rootViewController=navPlatform;
    
}

-(void)alertOnly:(NSString *)content
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil
                                                  message:content
                                                 delegate:nil
                                        cancelButtonTitle:@"确定"
                                        otherButtonTitles:nil];
    
    [alert show];
    
    
}

//自定义imageview
-(UIImageView *)customImageView:(CGRect)frame image:(UIImage *)image
{
    UIImageView *customImageView=[[UIImageView alloc] initWithFrame:frame];
    customImageView.image=image;
    
    return customImageView;
}
//画横线
-(UILabel *)drawLinebg:(CGRect)frame lineColor:(UIColor *)lineColor
{
    UILabel *lineLabel=[[UILabel alloc] initWithFrame:frame];
    lineLabel.backgroundColor=lineColor;
    
    return lineLabel;
}
//用户自定义Label
//alignment,－1:left,0:center,1:right
-(UILabel *)customLabel:(CGRect)frame color:(UIColor *)color text:(NSString *)text alignment:(int)alignment font:(CGFloat)font
{
    UILabel *customLabel=[[UILabel alloc] initWithFrame:frame];
    customLabel.backgroundColor=[UIColor clearColor];
    customLabel.text=text;
    customLabel.textColor=color;
    if (alignment==-1)
    {
        customLabel.textAlignment=NSTextAlignmentLeft;
    }
    else if (alignment==0)
    {
        customLabel.textAlignment=NSTextAlignmentCenter;
    }
    else
    {
        customLabel.textAlignment=NSTextAlignmentRight;
    }
    customLabel.font=[UIFont systemFontOfSize:font];
    
    return customLabel;
}
-(UIButton *)customButton:(CGRect)frame backgroungImageNormal:(UIImage *)normalImage backgrounImageSelect:(UIImage *)selectImage title:(NSString *)title tag:(int)tag titleColor:(UIColor *)titleColor;
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    //btn.selected=YES;
    btn.frame=frame;
    [btn.layer setMasksToBounds:YES];
    [btn.layer setCornerRadius:5.0];
    [btn setBackgroundImage:normalImage forState:UIControlStateNormal];
    [btn setBackgroundImage:selectImage forState:UIControlStateSelected];
    [btn setTintColor:titleColor];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.tag=tag;
    [btn addTarget:self action:@selector(dealBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;

}
-(UIBarButtonItem *)customBarButtonItem:(UIImage *)image
{
    UIView *angleView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 44)];
    angleView.backgroundColor=[UIColor clearColor];
    UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake((40-24)/2,(44-23)/2, 24, 24)];
    img.image=image;
    [angleView addSubview:img];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=angleView.bounds;
    [btn addTarget:self action:@selector(barBtn) forControlEvents:UIControlEventTouchUpInside];
    [angleView addSubview:btn];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:angleView];
    
    return backItem;
}
-(void)barBtn
{
    
}
-(UIBarButtonItem *)customRightBarButtonItem:(UIImage *)image
{
    UIView *angleView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 44)];
    angleView.backgroundColor=[UIColor clearColor];
    UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake((40-24)/2,(44-23)/2, 24, 24)];
    img.image=image;
    [angleView addSubview:img];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=angleView.bounds;
    [btn addTarget:self action:@selector(RightbarBtn) forControlEvents:UIControlEventTouchUpInside];
    [angleView addSubview:btn];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:angleView];
    
    return backItem;

}
-(void)RightbarBtn
{
    
}
//处理按钮点击事件
-(void)dealBtnEvent:(UIButton *)sender
{
    
}

//搜索图
-(UIView *)searchView:(NSString *)placeholder;
{
    UIView *searchView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 40)];
    searchView.backgroundColor=[UIColor clearColor];
    
    
    //搜索框图－－300*27
    [searchView addSubview:[self customImageView:CGRectMake((searchView.frame.size.width-300)/2, (searchView.frame.size.height-27)/2, 300, 27) image:IMAGE(@"searchBG")]];
    //搜索图标－－24*24
    [searchView addSubview:[self customImageView:CGRectMake(25, (searchView.frame.size.height-24)/2, 24, 24) image:IMAGE(@"search")]];
    
    searchTextField=[[UITextField alloc] initWithFrame:CGRectMake(25+18+5, (searchView.frame.size.height-20)/2, 250, 20)];
    searchTextField.delegate=self;
    searchTextField.borderStyle=UITextBorderStyleNone;
    searchTextField.font=[UIFont systemFontOfSize:16.0];
    searchTextField.returnKeyType=UIReturnKeySearch;
    searchTextField.placeholder=placeholder;
    searchTextField.tintColor = kUIColorFromRGB(0x919191);//kUIColorFromRGB(0x4e4e4e);//设置光标颜色
    [searchTextField setValue:kUIColorFromRGB(0xc6c6c6) forKeyPath:@"_placeholderLabel.textColor"];//kUIColorFromRGB(0x4e4e4e)
    [searchTextField setValue:[UIFont systemFontOfSize:16.0] forKeyPath:@"_placeholderLabel.font"];
    searchTextField.textColor=kUIColorFromRGB(0x24292c);//kUIColorFromRGB(0x4e4e4e);
    [searchView addSubview:searchTextField];
    
    return searchView;
}
-(UITextField*)customTextField:(NSString *)placeholder frame:(CGRect)frame;
{
    UITextField *textField=[[UITextField alloc]initWithFrame:frame];
    textField.delegate=self;
    textField.borderStyle=UITextBorderStyleNone;
    textField.font=[UIFont systemFontOfSize:16.0];
    textField.returnKeyType=UIReturnKeyNext;
    textField.placeholder=placeholder;
    textField.tintColor = kUIColorFromRGB(0x919191);//kUIColorFromRGB(0x4e4e4e);//设置光标颜色
    [textField setValue:kUIColorFromRGB(0xc6c6c6) forKeyPath:@"_placeholderLabel.textColor"];//kUIColorFromRGB(0x4e4e4e)
    [textField setValue:[UIFont systemFontOfSize:16.0] forKeyPath:@"_placeholderLabel.font"];
    textField.textColor=kUIColorFromRGB(0x24292c);//kUIColorFromRGB(0x4e4e4e);
    //[textField becomeFirstResponder];

    return textField;
}

-(UIView *)customRightTitle:(NSString *)title
{
    UIView *rgtView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    rgtView.backgroundColor=[UIColor clearColor];
    [rgtView addSubview:[self customLabel:CGRectMake(0, (rgtView.frame.size.height-20)/2, rgtView.frame.size.width, 20) color:[UIColor whiteColor] text:title alignment:0 font:15.0]];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, rgtView.frame.size.width, rgtView.frame.size.height);
    [btn addTarget:self action:@selector(item) forControlEvents:UIControlEventTouchUpInside];
    [rgtView addSubview:btn];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:rgtView];
    self.navigationItem.rightBarButtonItem=item;
    return rgtView;

}

@end
