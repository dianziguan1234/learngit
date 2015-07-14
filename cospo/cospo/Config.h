//
//  Config.h
//  anchexin
//
//  Created by cgx on 14-8-5.
//
//

#ifndef Cospo_App_Config_h
#define Cospo_App_Config_h

#define PageNumber 15

#define DATABASENAME @"COSPO_IOS" //数据库表名

//宣传url
#define Propaganda @"http://file.vxplo.cn/?nid=363797&key=5c896eb2bb&title=5omj5YqoY29zcG8gICAgIA--&html5=true&width=640&v=32&slink=/idea/ebr9lsH/from_singlemessage/isappinstalled_0&from=singlemessage&isappinstalled=1#p1"

//友盟统计APPKey

#define UMENG_APPKEY @"551dfe17fd98c587f4000564"

//设置百度key
#define BaiDu_key @"jHpEnlGa1VkxNjnM4cB6CjmW"

//AVOSClod的id、key
#define AVid @"bc5m2mco46e1w5imilyvj27b594alfog7mholscjcgqe71r2"
#define AVkey @"krgcxbjxrk31qxw1bre1lbdwsfn089egqti5ao11zhq5si8s"

//微信朋友圈
#define WXid @"wxb81fa29258871b4a"
#define WXkey @"822bbaa18c54d9c3e92992c24d61fcbb"

//QQ
#define QQid @"100586726"
#define QQkey @"961bb15add472fc2d2e0016b31c052d4"

//判断是否iphon5的尺寸
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//判断是否iphon6的尺寸
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)) : NO)

//判断是否iphon6+的尺寸
#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)

//判断是否是ios8以上的系统
#define IOS8 [[[UIDevice currentDevice]systemVersion] floatValue] >= 8.0

#define IMAGE(imagePath) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(imagePath) ofType:@"png"]]

//使用说明table.backgroundColor = kUIColorFromRGB(0xCCFFFF);
#define kUIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define WIDTH 320.0

#define POSTMethod @"POST"
#define GETMethod @"GET"


#define ft_commonColor 0x2fa624
#define ft_lineColor 0x995f19

//通用的红色
#define common_red 0xec0970


//背景色值，俱乐部，成员，活动大厅背景
#define custom_gray 0xefefef


//导航栏背景色
#define navColor 0x000000

//浅灰色提示文字
#define grayTitleColor 0xc1c1c1
//深色提示文字
#define darkTitleColor 0x273039
//白色填充
#define fillCellColor 0xffffff
//灰色背景
#define graybgColor 0xeeeeee
//橙色
#define orangeTitleColor 0xff790d

//深色线色值
#define darkLineColor 0xe4e4e4
//浅色线色值
#define lightLineColor 0xeeeeee

#define activity_darkLinebg 0x222222
#define activity_lightLinebg 0x313131
#define activity_bgViewController 0x171717
#define activity_titleColor 0xe0e0e0
#define activity_bgView 0x1c1c1c

//足球
#define ftb_color 0x3e9c34
//篮球
#define bsk_color 0xff790d
//羽毛球
#define bad_color 0x00ffde
//网球
#define wang_color 0x89d537
//桌球
#define tai_color 0x6a01df


//基本红
#define basic_redColor 0xe53b42




//缓存根目录命名
//#define cos_score @"cospo_personInfo_Score"//用户经验
#define cos_club @"cospo_personInfo_Club"//用户俱乐部
#define cos_feed @"cospo_personInfo_Feed"//用户日志

//联系人
#define cos_contact @"cospo_Contact"
//成员－附近
#define cos_member_nearby @"cospo_member_nearby"
//成员－热门
#define cos_member_hot @"cos_member_hot"


//场馆－附近
#define cos_location_nearby @"cospo_location_nearby"
//场馆－热门
#define cos_location_hot @"cospo_location_hot"
//场馆－收藏
#define cos_location_save @"cospo_location_save"


//我的俱乐部
#define cos_club_my @"cospo_club_my"
//我关注的俱乐部
#define cos_club_collection @"cospo_club_collection"
//附近俱乐部
#define cos_club_nearby @"cospo_club_nearby"
//发现俱乐部
#define cos_club_find @"cospo_club_find"



//我的活动
#define cos_activity_my @"cospo_activity_my"
//我关注的活动
#define cos_activity_collection @"cospo_activity_collection"
//附近活动
#define cos_activity_nearby @"cospo_activity_nearby"
//热门活动
#define cos_activity_find @"cospo_activity_find"

//用户签到
#define cos_user_sign @"cospo_user_sign"

//场馆日志中的最近活动
#define cos_venues_activity_nearby @"cospo_venues_activity_nearby"
//场馆日志中的热门活动
#define cos_venues_activity_hot @"cospo_venues_activity_hot"


//通知－－缓存俱乐部
#define cos_nocitation_club @"cospo_nocitation_club"
//通知－－缓存活动
#define cos_nocitation_activity @"cospo_nocitation_activity"
//gwc
#define tabBarback_Color 0x24292c

#endif
