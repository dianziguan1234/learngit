//
//  ViewController.h
//  cospo
//
//  Created by gwc on 15/7/3.
//  Copyright (c) 2015年 gwc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIKit+AFNetworking.h"//添加所有网络接口
#import "Config.h"//配置文件

#import "JSONKit.h"
#import "MJRefresh.h" //上拉或者下提刷新
#import "AFJSONFactory.h"
#import "UIImageView+WebCache.h"//下载图片并缓存到本地

#import "ReadWriteToDocument.h"//读取文件

#import "WXApi.h"
//导入第三方类库
#import "UMSocial.h"//友盟
#import "UMSocialWechatHandler.h"//微信分享
#import "UMSocialQQHandler.h"//QQ分享
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"
@interface BaseViewController : UIViewController<UITextFieldDelegate,MJRefreshBaseViewDelegate,JSONDataReturnDelegate>
{
    ReadWriteToDocument *document;
    UITextField *searchTextField;
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
}
-(AFJSONFactory *)JsonFactory;
-(void)alertOnly:(NSString *)content;//弹出提示框
//自定义uiimageView
-(UIImageView *)customImageView:(CGRect)frame image:(UIImage *)image;
//画横线
-(UILabel *)drawLinebg:(CGRect)frame lineColor:(UIColor *)lineColor;
//用户自定义Label
//alignment,－1:left,0:center,1:right
-(UILabel *)customLabel:(CGRect)frame color:(UIColor *)color text:(NSString *)text alignment:(int)alignment font:(CGFloat)font;
-(UIButton *)customButton:(CGRect)frame backgroungImageNormal:(UIImage *)normalImage backgrounImageSelect:(UIImage *)selectImage title:(NSString *)title tag:(int)tag titleColor:(UIColor *)titleColor;
//自定义左右
-(UIBarButtonItem *)customBarButtonItem:(UIImage *)image;
-(UIBarButtonItem *)customRightBarButtonItem:(UIImage *)image;
//搜索图
-(UIView *)searchView:(NSString *)placeholder;
-(UITextField*)customTextField:(NSString *)placeholder frame:(CGRect)frame;
//导航栏右上角确定按钮
-(UIView *)customRightTitle:(NSString *)title;
@end

