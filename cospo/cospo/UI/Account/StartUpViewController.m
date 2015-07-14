//
//  StartUpViewController.m
//  Cospo
//
//  Created by cgx on 15-3-5.
//  Copyright (c) 2015年 cgx. All rights reserved.
//

#import "StartUpViewController.h"

@interface StartUpViewController ()

@end

@implementation StartUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden=YES;
    
    index=0;
    
    guideScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    guideScrollView.delegate=self;
    guideScrollView.userInteractionEnabled=YES;
    guideScrollView.pagingEnabled=YES;
    guideScrollView.bounces=NO;
    guideScrollView.contentSize=CGSizeMake(4*WIDTH, guideScrollView.frame.size.height);
    
    for (int i=0; i<4; i++)
    {
        UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(i*WIDTH, 0, WIDTH, guideScrollView.frame.size.height)];
        NSString *iconStr=nil;
        
        if (iPhone5)
        {
            iconStr=[NSString stringWithFormat:@"app_1136_%d",i+1];
        }
        else
        {
            iconStr=[NSString stringWithFormat:@"app_960_%d",i+1];
        }
    
        //NSLog(@"iconStr::%@",iconStr);
        
        img.image=IMAGE(iconStr);
        
        
        [guideScrollView addSubview:img];
        
        
        if (i==3)
        {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=img.frame;
            [btn addTarget:self action:@selector(enterLogin) forControlEvents:UIControlEventTouchUpInside];
            
            [guideScrollView addSubview:btn];
        }
    }
    
    
    
    [self.view addSubview:guideScrollView];
    
    
}

-(void)enterLogin
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"ISFirst"];
    
    ChoosePlatformViewController *platform=[[ChoosePlatformViewController alloc] init];
    [self.navigationController pushViewController:platform animated:YES];
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pagewidth = scrollView.frame.size.width;
    int currentPage = floor((scrollView.contentOffset.x - pagewidth/4) / pagewidth) + 1;
    //NSLog(@"currentPage::%d",currentPage);
    
    if (currentPage==3)
    {
        index++;
        if (index==2)
        {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"ISFirst"];
            
            ChoosePlatformViewController *platform=[[ChoosePlatformViewController alloc] init];
            [self.navigationController pushViewController:platform animated:YES];
        }
    }
    else
    {
        index=0;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
