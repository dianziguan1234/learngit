

//
//  CoolgirlViewController.m
//  Gwc
//
//  Created by gwc on 15/7/2.
//  Copyright (c) 2015年 gwc. All rights reserved.
//

#import "CoolgirlViewController.h"

@interface CoolgirlViewController ()

@end

@implementation CoolgirlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"CoolGirl";
    
    _webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, 320)];
    _webView.backgroundColor = [UIColor grayColor];
    _webView.scalesPageToFit =YES;
    _webView.delegate =self;
    NSURL *url =[[NSURL alloc] initWithString:@"http://www.baidu.com"];
    
    NSURLRequest *request =  [[NSURLRequest alloc] initWithURL:url];
    [_webView loadRequest:request];
    
    [self.view addSubview:[self customButton:CGRectMake(110, 350, 100, 50) backgroungImageNormal:IMAGE(@"1") backgrounImageSelect:IMAGE(@"2") title:@"返回" tag:1 titleColor:kUIColorFromRGB(0x24292c)]];
    
    //
    //[_webView stringByEvaluatingJavaScriptFromString:@"var script = document.createElement('script');"
//     "script.type = 'text/javascript';"
//     "script.text = \"function myFunction() { "
//     "var field = document.getElementsByName('q')[0];"
//     "field.value='朱祁林';"
//     "document.forms[0].submit();"
//     "}\";"
//     "document.getElementsByTagName('head')[0].appendChild(script);"];
//    
//    [_webView stringByEvaluatingJavaScriptFromString:@"myFunction();"];
    //
    [self.view addSubview:_webView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *currentURL = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
    
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];

    
    //[_webView stringByEvaluatingJavaScriptFromString:@"myFunction();"];
    NSLog(@"---------%@,---------%@",currentURL,title);
    //NSLog(@"好好好");
}

-(void)dealBtnEvent:(UIButton *)sender
{
    if (sender.tag==1) {
        if ([_webView canGoBack]) {
            [_webView goBack];
        }else
        {
              [self.navigationController popViewControllerAnimated:YES];
        }
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
