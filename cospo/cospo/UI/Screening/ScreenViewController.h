//
//  ScreenViewController.h
//  cospo
//
//  Created by gwc on 15/7/3.
//  Copyright (c) 2015年 gwc. All rights reserved.
//

#import "BaseViewController.h"
#import "CDRTranslucentSideBar.h"
@interface ScreenViewController : BaseViewController<CDRTranslucentSideBarDelegate,UIGestureRecognizerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    CDRTranslucentSideBar *_sideBar;
}
@property (nonatomic, strong) CDRTranslucentSideBar *sideBar;

@end
