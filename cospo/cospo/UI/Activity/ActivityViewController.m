//
//  ActivityViewController.m
//  Gwc
//
//  Created by gwc on 15/7/2.
//  Copyright (c) 2015年 gwc. All rights reserved.
//

#import "ActivityViewController.h"
#import "ChoosePlatformViewController.h"
@interface ActivityViewController ()

@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"活动";
    [self.view addSubview:[self customButton:CGRectMake(110, 200, 100, 40) backgroungImageNormal:IMAGE(@"1") backgrounImageSelect:IMAGE(@"2") title:@"登陆" tag:10 titleColor:[UIColor whiteColor]]];
    [self customRightTitle:@"完成"];
    // Do any additional setup after loading the view.
}

-(void)item
{
    NSLog(@"右上角确定");
}

-(void)dealBtnEvent:(UIButton *)sender
{
    if (sender.tag==10) {
        ChoosePlatformViewController *vc=[[ChoosePlatformViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
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
