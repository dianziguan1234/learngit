//
//  CustomNavigationController.m
//  AnCheXin
//
//  Created by cgx on 13-11-6.
//  Copyright (c) 2013年 LianJia. All rights reserved.
//

#import "CustomNavigationController.h"
#import <QuartzCore/QuartzCore.h>

@interface CustomNavigationController ()

@end

@implementation CustomNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
/*
    if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        self.navigationBar.barTintColor=[UIColor clearColor];
        self.navigationBar.backgroundColor=[UIColor blackColor];
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"logoTitle"] forBarMetrics:UIBarMetricsDefault];
    }
*/
    if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        /*
        // Set Navigation Bar style
        CGRect rect=CGRectZero;
        rect = CGRectMake(0.0f, 0.0f, WIDTH,64.0);
        
        // Set Navigation Bar style
        //CGRect rect = CGRectMake(0.0f, 0.0f, ScreenWidth,64.0f);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context, [[UIColor colorWithWhite:0.0 alpha:0.5f] CGColor]);
        CGContextFillRect(context, rect);
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        */
        /*
        [[UINavigationBar appearance] setBackgroundImage:IMAGE(@"navImgBg") forBarMetrics:UIBarMetricsDefault];
        
        
        [[UINavigationBar appearance] setTitleVerticalPositionAdjustment: 0.0f forBarMetrics: UIBarMetricsDefault];//title的位置
        [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
        */
        
        //[[UINavigationBar appearance] setTintColor: [UIColor blackColor]];
        //self.navigationBar.backgroundColor=[UIColor blackColor];
        
        //设置文本的阴影色彩和透明度。
        
        //[[UINavigationBar appearance] setBackgroundImage:IMAGE(@"navImgBg") forBarMetrics:UIBarMetricsDefault];
        self.navigationBar.barTintColor=kUIColorFromRGB(tabBarback_Color);
        
        [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:20.0], NSFontAttributeName,nil]];//title的颜色
        
    }
}

//重写push方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    
    if (viewController.navigationItem.leftBarButtonItem== nil && [self.viewControllers count] > 1 )
    {
         viewController.navigationItem.leftBarButtonItem =[self customLeftBackButton];//重新定义左按钮
    }
   
}


-(UIBarButtonItem *)customLeftBackButton
{
    UIView *customView=[[UIView alloc] initWithFrame:CGRectMake(0, 0,50,40)];
    customView.backgroundColor=[UIColor clearColor];
    UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(0, 7, 30,30)];
    img.image=IMAGE(@"navImg_back");
    [customView addSubview:img];
    /*
    UILabel *customLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 10, customView.frame.size.width-20, 20)];
    customLabel.backgroundColor=[UIColor clearColor];
    customLabel.text=@"返回";
    customLabel.textAlignment=NSTextAlignmentLeft;
    customLabel.textColor=[UIColor whiteColor];
    customLabel.font=[UIFont systemFontOfSize:18.0];
    [customView addSubview:customLabel];
     */
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=customView.bounds;
    [btn addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
    [customView addSubview:btn];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:customView];
    
    return backItem;
}

-(void)popself
{
    [self popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
