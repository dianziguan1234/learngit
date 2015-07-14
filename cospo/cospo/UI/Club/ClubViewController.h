//
//  ClubViewController.h
//  Gwc
//
//  Created by gwc on 15/7/2.
//  Copyright (c) 2015年 gwc. All rights reserved.
//

#import "BaseViewController.h"
#import "CDRTranslucentSideBar.h"
@interface ClubViewController : BaseViewController<CDRTranslucentSideBarDelegate,UIGestureRecognizerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    CDRTranslucentSideBar *_sideBar;
    UIImageView *_check1;
    UIImageView *_check2;
    UIImageView *_check3;
    UIImageView *_check4;
    UIImageView *_check5;
    UIImageView *_check6;
  
    int btnClickNum1;
    int btnClickNum2;
    int btnClickNum3;
    int btnClickNum4;
    int btnClickNum5;
    int btnClickNum6;
    UISwitch *_swith1;
    UISwitch *_swith2;
    
    UITableView *ClubTableView;
    
    NSArray *clubArray;//数据源
    NSArray *imageArray;
    NSArray *imageCoverArray;
    
    

}
@property (nonatomic, strong) CDRTranslucentSideBar *sideBar;
@end
