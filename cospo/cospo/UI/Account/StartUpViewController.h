//
//  StartUpViewController.h
//  Cospo
//
//  Created by cgx on 15-3-5.
//  Copyright (c) 2015年 cgx. All rights reserved.
//

#import "BaseViewController.h"
#import "ChoosePlatformViewController.h"
#import "CustomNavigationController.h"

@interface StartUpViewController : BaseViewController<UIScrollViewDelegate>
{
    UIScrollView *guideScrollView;
    UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
    int index;
    
    
}

@end
