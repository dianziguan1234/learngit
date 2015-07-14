//
//  AFJSONFactory.m
//  PrivateTao
//
//  Created by cgx on 14-5-17.
//  Copyright (c) 2014年 LianJia. All rights reserved.
//

#import "AFJSONFactory.h"


//static NSString * const AFBaseURLString = @"http://42.96.173.60:3000/";
//static NSString * const AFBaseURLString = @"http://api.cospo.org/";

static NSString * const AFBaseURLString = @"http://115.29.39.195:8080/";


@implementation AFJSONFactory
@synthesize delegate;


//特殊字符编码转换
-(NSString *)encodeURL:(NSString *)unescapedString
{
    NSString *escapedUrlString= (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)unescapedString, NULL,(CFStringRef)@"!*'();:@+$,/?%#[]",kCFStringEncodingUTF8));//!*'();:@&=+$,/?%#[]
    
    return escapedUrlString;
}


- (void)reach
{
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // 局域网络,不花钱
     */
}


//类
-(void)getJSONDataByParam:(NSDictionary *)params method:(NSString *)method action:(NSString *)action
{
    NSLog(@"jsonParam::%@",params);
    
   [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];

    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        //NSLog(@"%ld", status);
        if (status==1 || status==2)
        {
            //1.管理器
            AFHTTPRequestOperationManager *manager= [AFHTTPRequestOperationManager manager];
            //2.0 设置请求格式
            //manager.requestSerializer=[AFJSONRequestSerializer serializer];
            [manager.operationQueue cancelAllOperations];//取消所有请求
            
            
            
            //2.1 设置返回数据类型
            manager.responseSerializer = [AFJSONResponseSerializer serializer]; //先实例化一下
        
            @try{
                
                if ([method isEqualToString:@"POST"])
                {
                    
                    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"application/json"];
                    
                    //3.发起请求
                    [manager POST:[NSString stringWithFormat:@"%@%@",AFBaseURLString,action]
                       parameters:params
                          success: ^(AFHTTPRequestOperation *operation, id responseObject)
                     {
                         [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
                         NSLog(@"success=>method:%@==%@",method,responseObject);
                        if (responseObject && ([[responseObject objectForKey:@"code"] intValue]==1004 || [[responseObject objectForKey:@"code"] intValue]==1003))
                         {
                             //1004:sid无效.1003:账户不存在
                             if ([delegate respondsToSelector:@selector(JSONExit)])
                             {
                                 [delegate JSONExit];
                             }

                         }
                         else
                         {
                             if ([delegate respondsToSelector:@selector(JSONSuccess:)])
                             {
                                 //[[AFNetworkReachabilityManager sharedManager] stopMonitoring];
                                 [delegate JSONSuccess:responseObject];
                             }
                         }
                        
                     }
                          failure: ^(AFHTTPRequestOperation *operation, NSError *error)
                     {
                         [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
                         NSLog(@"error=>method:%@==%@",method,error);
                         
                         if ([delegate respondsToSelector:@selector(JSONError:)])
                         {
                             [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
                             
                             [delegate JSONError:error];
                             
                         }
                     }];

                }
                else
                {
                    //manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
                    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"application/json"];
                    
                    [manager GET:[NSString stringWithFormat:@"%@%@",AFBaseURLString,action]
                      parameters:params
                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                             [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
                             
                            NSLog(@"url::%@",operation.request.URL);
                            NSLog(@"success=>method:%@==%@",method,responseObject);
                             if (responseObject && ([[responseObject objectForKey:@"code"] intValue]==1004 || [[responseObject objectForKey:@"code"] intValue]==1003))
                             {
                                 //1004:sid无效.1003:账户不存在
                                 if ([delegate respondsToSelector:@selector(JSONExit)])
                                 {
                                     [delegate JSONExit];
                                 }
                             }
                             else
                             {
                                 if ([delegate respondsToSelector:@selector(JSONSuccess:)])
                                 {
                                     //[[AFNetworkReachabilityManager sharedManager] stopMonitoring];
                                     [delegate JSONSuccess:responseObject];
                                 }
                             }
                             
                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                             
                             [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
                             
                             NSLog(@"error=>method:%@==%@",method,error);
                             if ([delegate respondsToSelector:@selector(JSONError:)])
                             {
                                 [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
                                 
                                 [delegate JSONError:error];
                                 
                             }

                         }];
                }
            }
            @catch(NSException *exception)
            {
                //NSLog(@"exception:%@", exception);
            }
            @finally {
                
            }
        }
        else
        {
            [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
            
            if ([delegate respondsToSelector:@selector(JSONError:)])
            {
                [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
                
                [delegate JSONError:nil];
            }
        }
    }];
    
    
}


/*
//测试
-(void)test:(NSString *)param1 action:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    
    [bodyDic setObject:mobile forKey:@"mobile"];
    [bodyDic setObject:secret forKey:@"secret"];
    
    [self getJSONDataByParam:bodyDic action:action];
}
 */

//注册－POST
-(void)sign:(NSString *)login_id password:(NSString *)password password_confirmation:(NSString *)password_confirmation check_code:(NSString *)check_code method:(NSString *)method action:(NSString *)action;
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    
    [bodyDic setObject:login_id forKey:@"login_id"];//手机号码
    [bodyDic setObject:password forKey:@"password"];//密码
    [bodyDic setObject:password_confirmation forKey:@"password_confirmation"];//确认
    [bodyDic setValue:check_code forKey:@"check_code"];
    [self getJSONDataByParam:bodyDic method:method action:action];
    
}

//手机账号登录-POST
-(void)login:(NSString *)login_id passsword:(NSString *)passsword method:(NSString *)method action:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    
    [bodyDic setObject:login_id forKey:@"login_id"];
    [bodyDic setObject:passsword forKey:@"password"];
    
    [self getJSONDataByParam:bodyDic method:method action:action];
}

//微信登陆post
-(void)weixin_sign:(NSString *)weixin_openid nickname:(NSString *)nickname sex:(NSString *)sex avatar_url:(NSString *)avatar_url addr:(NSString *)addr method:(NSString *)method action:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:weixin_openid forKey:@"unionid"];//微信unionid
    [bodyDic setObject:nickname forKey:@"nickname"];//昵称
    [bodyDic setObject:sex forKey:@"sex"];//性别
    [bodyDic setObject:avatar_url forKey:@"avatar_url"];//头像
    [bodyDic setObject:addr forKey:@"addr"];//地址
    
    /*
     [bodyDic setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:@"COSPO_LoginInfo"] objectForKey:@"sid"] forKey:@"sid"];
     [bodyDic setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:@"COSPO_LoginInfo"] objectForKey:@"uid"] forKey:@"uid"];
     */
    
    [self getJSONDataByParam:bodyDic method:method action:action];
}

//文件上传
-(void)uploadFile:(UIImage *)img method:(NSString *)method action:(NSString *)action
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    
    NSData *imageData = UIImageJPEGRepresentation(img, 1);
    [manager POST:[NSString stringWithFormat:@"%@%@",AFBaseURLString,action]
       parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
           
           [formData appendPartWithFileData :imageData name:@"file" fileName:@"1.png" mimeType:@"image/png"];
           
       } success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         
         NSLog(@"Success: %@", responseObject);
         [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
         if ([delegate respondsToSelector:@selector(JSONSuccess:)])
         {
             //[[AFNetworkReachabilityManager sharedManager] stopMonitoring];
             [delegate JSONSuccess:responseObject];
         }
         
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         
         
         //NSLog(@"file====Error: %@", error);
         [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
         if ([delegate respondsToSelector:@selector(JSONError:)])
         {
             //[[AFNetworkReachabilityManager sharedManager] stopMonitoring];
             
             [delegate JSONError:error];
             
         }
         
     }];
    
    /*
     //创建Request对象
     NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
     [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",AFBaseURLString,action]]];
     [request setHTTPMethod:@"POST"];
     
     NSMutableData *body = [NSMutableData data];
     
     //设置表单项分隔符
     NSString *boundary = @"---------------------------14737809831466499882746641449";
     
     //设置内容类型
     NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
     [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
     
     //写入图片的内容
     [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"PIC_DATA1.jpg\"\r\n",@"file"] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
     NSData *imageData = UIImageJPEGRepresentation([UIImage imageNamed:@"homt_frame.png"], 0.3);
     //NSLog(@"imageData::%@",imageData);
     [body appendData:imageData];
     [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
     
     //写入尾部内容
     [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     // NSLog(@"body：%@",body);
     
     [request setHTTPBody:body];
     
     // NSHTTPURLResponse *urlResponese = nil;
     // NSError *error = [[NSError alloc]init];
     NSError *error =nil;
     //NSLog(@"daddddd");
     NSData* resultData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
     NSLog(@"resultData::%@",resultData);
     NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableLeaves error:nil];
     NSLog(@"responseDic::%@",responseDic);
     */
    
    
}

//创建俱乐部
-(void)createClub:(NSString *)name addr:(NSString *)addr desc:(NSString *)desc project_ids:(NSString *)project_ids img:(NSString *)img imgs:(NSString *)imgs is_public:(NSString *)is_public is_check:(NSString *)is_check lat:(NSString *)lat lng:(NSString *)lng method:(NSString *)method action:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    
    [bodyDic setValue:name forKey:@"name"];
    [bodyDic setValue:addr forKey:@"addr"];
    if (![desc isEqualToString:@""])
    {
        [bodyDic setValue:desc forKey:@"desc"];
    }
    [bodyDic setValue:project_ids forKey:@"project_ids"];
    [bodyDic setValue:img forKey:@"img"];
    [bodyDic setValue:imgs forKey:@"imgs"];
    [bodyDic setValue:is_public forKey:@"is_public"];
    [bodyDic setValue:is_check forKey:@"is_check"];
    [bodyDic setValue:lat forKey:@"lat"];
    [bodyDic setValue:lng forKey:@"lng"];
    
    [bodyDic setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:@"COSPO_LoginInfo"] objectForKey:@"sid"] forKey:@"sid"];
    [bodyDic setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:@"COSPO_LoginInfo"] objectForKey:@"uid"] forKey:@"uid"];
  
    
    
}



@end
