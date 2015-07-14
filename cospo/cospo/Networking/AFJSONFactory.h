//
//  AFJSONFactory.h
//  PrivateTao
//
//  Created by cgx on 14-5-17.
//  Copyright (c) 2014年 LianJia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
//#import "JSONKit.h"

//返回json格式的数据
@protocol JSONDataReturnDelegate <NSObject>

-(void)JSONSuccess:(id)responseObject;//返回成功json
-(void)JSONError:(NSError *)error;    //返回错误json
-(void)JSONExit;    //退出

@end

@interface AFJSONFactory : NSObject
{
    
    id<JSONDataReturnDelegate> delegate;
    
}
@property(nonatomic,retain)id<JSONDataReturnDelegate> delegate;

//类
-(void)getJSONDataByParam:(NSDictionary *)params method:(NSString *)method action:(NSString *)action;


//测试
//-(void)test:(NSString *)param1 action:(NSString *)action;

//注册－POST
-(void)sign:(NSString *)login_id password:(NSString *)password password_confirmation:(NSString *)password_confirmation check_code:(NSString *)check_code method:(NSString *)method action:(NSString *)action;

//登录-POST
-(void)login:(NSString *)login_id passsword:(NSString *)passsword method:(NSString *)method action:(NSString *)action;

//微信登陆-POST
-(void)weixin_sign:(NSString *)weixin_openid nickname:(NSString *)nickname sex:(NSString *)sex avatar_url:(NSString *)avatar_url addr:(NSString *)addr method:(NSString *)method action:(NSString *)action;

//文件上传
-(void)uploadFile:(UIImage *)img method:(NSString *)method action:(NSString *)action;

//创建俱乐部
/*
name 名称
addr 地址
desc 描述
project_ids 项目 已;号分割
img 头像
imgs 封面 多个已;号分割 最多3个
is_public 陌生人可见 1可见 0 不可见
is_check 开启验证 1开启 0关闭
lat 经度
lng 纬度
 */
//创建俱乐部
-(void)createClub:(NSString *)name addr:(NSString *)addr desc:(NSString *)desc project_ids:(NSString *)project_ids img:(NSString *)img imgs:(NSString *)imgs is_public:(NSString *)is_public is_check:(NSString *)is_check lat:(NSString *)lat lng:(NSString *)lng method:(NSString *)method action:(NSString *)action;
@end
