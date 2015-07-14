//
//  CreateClubViewController.h
//  cospo
//
//  Created by gwc on 15/7/5.
//  Copyright (c) 2015年 gwc. All rights reserved.
//

#import "BaseViewController.h"

@interface CreateClubViewController : BaseViewController<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

{
    UITextField *_clubNameField;
    UIImageView *_img5;
    UITextView *_textView;
    UILabel *_desc;
    UILabel *_addrDesc;
    UILabel *_resultAdd;
    
    int btnClickNum1;
    int btnClickNum2;
    int btnClickNum3;
    int btnClickNum4;
    int btnClickNum5;
    
    
    UIButton *doneBtn;
    int request;
    UIImageView *clubImage;
    NSString *clubImgUrl;//俱乐部头像封面图片
    UIImageView *clubCover1;
    NSString *clubCover1Url;
    UIImageView *clubCover2;
    NSString *clubCover2Url;
    UIImageView *clubCover3;
    NSString *clubCover3Url;
    int choose;
    NSString *lat1;
    NSString *lng1;
    
    NSString *BasprojectId;
    NSString *ftbprojectId;
    NSString *badprojectId;
    NSString *tennisprojectId;
    NSString *tabprojectId;
    NSString *is_public;
    NSString *is_check;
    
}
@end
