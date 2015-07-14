//
//  CreateClubViewController.m
//  cospo
//
//  Created by gwc on 15/7/5.
//  Copyright (c) 2015年 gwc. All rights reserved.
//

#import "CreateClubViewController.h"
#import "ChooseLocationViewController.h"
@interface CreateClubViewController ()

@end

@implementation CreateClubViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    
    //self.navigationController.navigationBarHidden=YES;
    [[self rdv_tabBarController] setTabBarHidden:YES animated:NO];
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:NO];
    self.navigationController.navigationBarHidden=NO;
    [[self rdv_tabBarController] setTabBarHidden:NO animated:NO];
    
}
-(void)refreshAddressPoint:(NSNotification *)sender
{
    NSLog(@"sender::%@",sender.object);
    
        //选择场馆的经纬度
        lat1=[sender.object objectAtIndex:0];
        lng1=[sender.object objectAtIndex:1];
        //clubAddressLabel.text=[sender.object objectAtIndex:2];
   
    [_addrDesc removeFromSuperview];
    _resultAdd.text=[sender.object objectAtIndex:2];
    NSLog(@"lat::%@",lat1);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    btnClickNum1=0;
    btnClickNum2=0;
    btnClickNum3=0;
    btnClickNum4=0;
    btnClickNum5=0;
    lat1=@"";
    lng1=@"";
    clubImgUrl=@"";
    clubCover1Url=@"";
    clubCover2Url=@"";
    clubCover3Url=@"";
    badprojectId=@"";
    BasprojectId=@"";
    ftbprojectId=@"";
    tabprojectId=@"";
    tennisprojectId=@"";
    is_public=@"1";
    is_check=@"1";
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshAddressPoint:) name:@"refreshAddressPoint" object:nil];
    self.view.backgroundColor=kUIColorFromRGB(0xeeeeee);
    //[self.view addSubview:[self customButton:CGRectMake(110, 200, 100, 40) backgroungImageNormal:IMAGE(@"1") backgrounImageSelect:IMAGE(@"2") title:@"选择地点" tag:10 titleColor:[UIColor whiteColor]]];
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 568)];
    scrollView.contentSize=CGSizeMake(WIDTH, 885+147);
    [scrollView addSubview:[self customLabel:CGRectMake(10, 15, 104, 21) color:kUIColorFromRGB(0x24292c) text:@"俱乐部名称" alignment:-1 font:17]];
    UIImageView *img=[self customImageView:CGRectMake(10, 49, 300, 45) image:IMAGE(@"searchBG")];
    img.userInteractionEnabled=YES;
    [scrollView addSubview:img];
    [scrollView addSubview:[self customLabel:CGRectMake(10, 106, 221, 21) color:kUIColorFromRGB(0x24292c) text:@"上传头像" alignment:-1 font:17]];
    //xinghao
    [scrollView addSubview:[self customImageView:CGRectMake(97, 15, 13, 13) image:IMAGE(@"xinghao")]];
    [scrollView addSubview:[self customImageView:CGRectMake(80, 109, 13, 13) image:IMAGE(@"xinghao")]];
    [scrollView addSubview:[self customImageView:CGRectMake(78, 106+147, 13, 13) image:IMAGE(@"xinghao")]];
    [scrollView addSubview:[self customImageView:CGRectMake(98, 412+147, 13, 13) image:IMAGE(@"xinghao")]];
    [scrollView addSubview:[self customImageView:CGRectMake(98, 501+147, 13, 13) image:IMAGE(@"xinghao")]];
    //
    UIImageView *image9=[self customImageView:CGRectMake(10, 138, 300, 109) image:IMAGE(@"club_cover")];
    image9.userInteractionEnabled=YES;
    clubImage=[self customImageView:CGRectMake(4, 7, 94, 94) image:IMAGE(@"addPic")];
    [image9 addSubview:clubImage];
    [image9 addSubview:[self customButton:CGRectMake(4, 7, 94, 94) backgroungImageNormal:nil backgrounImageSelect:nil title:nil tag:5 titleColor:nil]];
    [scrollView addSubview:image9];
    _clubNameField=[self customTextField:@"输入俱乐部名称" frame:CGRectMake(15, 8, 278, 30)];
    [img addSubview:_clubNameField];
    [scrollView addSubview:[self customLabel:CGRectMake(10, 106+147, 221, 21) color:kUIColorFromRGB(0x24292c) text:@"上传封面（最多上传三张）" alignment:-1 font:17]];
    UIImageView *img2=[self customImageView:CGRectMake(10, 138+147, 300, 109) image:IMAGE(@"club_cover")];
    img2.userInteractionEnabled=YES;
    clubCover1=[self customImageView:CGRectMake(4, 7, 94, 94) image:IMAGE(@"addPic")];
    [img2 addSubview:clubCover1];
    clubCover2=[self customImageView:CGRectMake(102, 7, 94, 94) image:IMAGE(@"addPic")];
    [img2 addSubview:clubCover2];
    clubCover3=[self customImageView:CGRectMake(200, 7, 94, 94) image:IMAGE(@"addPic")];
    [img2 addSubview:clubCover3];
    [img2 addSubview:[self customButton:CGRectMake(4, 7, 94, 94) backgroungImageNormal:nil backgrounImageSelect:nil title:nil tag:0 titleColor:nil]];
    [img2 addSubview:[self customButton:CGRectMake(102, 7, 94, 94) backgroungImageNormal:nil backgrounImageSelect:nil title:nil tag:1 titleColor:nil]];
    [img2 addSubview:[self customButton:CGRectMake(200, 7, 94, 94) backgroungImageNormal:nil backgrounImageSelect:nil title:nil tag:2 titleColor:nil]];
    [scrollView addSubview:img2];
    
    //俱乐部介绍
    [scrollView addSubview:[self customLabel:CGRectMake(10, 255+147, 174, 21) color:kUIColorFromRGB(0x24292c) text:@"俱乐部介绍" alignment:-1 font:17]];
    /*UI_textView *_textView=[[UI_textView alloc]initWithFrame:CGRectMake(10, 284, 300, 116)];
    _textView.backgroundColor=[UIColor clearColor];
    _textView.font = [UIFont systemFontOfSize:16.0];
    _textView.returnKeyType=UIReturnKeyDone;
    _textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [scrollView addSubview:_textView];
     */
    
    UIImageView *img3=[self customImageView:CGRectMake(10, 284+147, 300, 116) image:IMAGE(@"culb_introduce")];
    img3.userInteractionEnabled=YES;
    //UITextField *decFiled=[self customTextField:@"简单介绍一下俱乐部" frame:CGRectMake(0,0,300,30)];
    _textView=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, 300, 116)];
    _textView.delegate=self;
    _textView.backgroundColor=[UIColor clearColor];
    _textView.font = [UIFont systemFontOfSize:16.0];
    _textView.returnKeyType=UIReturnKeyNext;
    _textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [img3 addSubview:_textView];
    _desc=[self customLabel:CGRectMake(20, 10, WIDTH, 20) color:kUIColorFromRGB(darkTitleColor)  text:@"介绍说明：如招募信息，公告等..." alignment:-1 font:16];
    _desc.enabled=NO;
    [_textView addSubview:_desc];
    [scrollView addSubview:img3];
    //选择位置
    [scrollView addSubview:[self customLabel:CGRectMake(10, 412+147, 174, 21) color:kUIColorFromRGB(0x24292c) text:@"俱乐部地址" alignment:-1 font:17]];
    UIImageView *img4=[self customImageView:CGRectMake(10, 443+147, 300, 45) image:IMAGE(@"searchBG")];
    img4.userInteractionEnabled=YES;
    [img4 addSubview:[self customImageView:CGRectMake(8, 8+2, 24, 24) image:IMAGE(@"dingwei")]];
    _addrDesc=[self customLabel:CGRectMake(178, 8+2, 78, 21) color:kUIColorFromRGB(0x24292c) text:@"点击定位" alignment:-1 font:17];
    
    [img4 addSubview:_addrDesc];
    _resultAdd=[self customLabel:CGRectMake(33, 0, 300-55, 45) color:kUIColorFromRGB(0x919191) text:nil alignment:-1 font:16];
    [img4 addSubview:_resultAdd];
    [img4 addSubview:[self customImageView:CGRectMake(264, 8+2, 24, 24) image:IMAGE(@"icon_arrorw")]];
    [img4 addSubview:[self customButton:CGRectMake(0, 0, 300, 45) backgroungImageNormal:nil backgrounImageSelect:nil title:nil tag:3 titleColor:nil]];
    [scrollView addSubview:img4];
    //选择项目
    [scrollView addSubview:[self customLabel:CGRectMake(10, 501+147, 174, 21) color:kUIColorFromRGB(0x24292c) text:@"俱乐部项目" alignment:-1 font:17]];
    _img5=[self customImageView:CGRectMake(10, 536+147, 300, 80) image:IMAGE(@"culb_xiamgmu")];
    _img5.userInteractionEnabled=YES;
    NSArray *projectArray=[NSArray arrayWithObjects:@"bsk_60",@"ftb_60",@"badminton_60",@"tennis_60",@"cue_60",nil];
    NSArray *projectTitleArray=[NSArray arrayWithObjects:@"篮球",@"足球",@"羽毛球",@"网球",@"桌球", nil];
    
    for (int i=0; i<projectArray.count; i++)
    {
        UIView *sub=[[UIView alloc] initWithFrame:CGRectMake(30*(i+1)+30*i-20, 0, 40, _img5.frame.size.height)];
        NSString *projectStr=[projectArray objectAtIndex:i];
        [sub addSubview:[self customImageView:CGRectMake((sub.frame.size.width-30)/2, 15, 30, 30) image:IMAGE(projectStr)]];
        
        UIImageView *checkImg=[self customImageView:CGRectMake((sub.frame.size.width-30)/2+20,30, 15, 15) image:IMAGE(@"activity_club_check")];
        checkImg.hidden=YES;
        checkImg.tag=10+i;
        [sub addSubview:checkImg];
        
        NSString *projectTitleStr=[projectTitleArray objectAtIndex:i];
        UILabel *des=[self customLabel:CGRectMake(0, 50, sub.frame.size.width, 20) color:kUIColorFromRGB(darkTitleColor) text:projectTitleStr alignment:0 font:13.0];
        des.tag=i;
        [sub addSubview:des];
        UIButton *subBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        subBtn.frame=sub.bounds;
        subBtn.tag=1000+i;
        [subBtn addTarget:self action:@selector(chooseProject:) forControlEvents:UIControlEventTouchUpInside];
        [sub addSubview:subBtn];
        [_img5 addSubview:sub];
    }
    [scrollView addSubview:_img5];
    //两个开关
    UIImageView *img6=[self customImageView:CGRectMake(10, 630+147, 300, 92) image:IMAGE(@"club_yanzheng")];
    img6.userInteractionEnabled=YES;
    [img6 addSubview:[self customLabel:CGRectMake(8, 13, 101, 31) color:kUIColorFromRGB(0x24292c) text:@"陌生人可见" alignment:-1 font:17]];
    [img6 addSubview:[self customLabel:CGRectMake(8, 53, 124, 31) color:kUIColorFromRGB(0x24292c) text:@"开启验证信息" alignment:-1 font:17]];
    //switch1
    UISwitch *swith1=[[UISwitch alloc]initWithFrame:CGRectMake(243, 8, 51, 31)];
    swith1.onTintColor=kUIColorFromRGB(0xf18353);
    swith1.tintColor=kUIColorFromRGB(0xf18353);
    swith1.tag=1;
    swith1.on=YES;
    [swith1 addTarget:self action:@selector(changSw:) forControlEvents:UIControlEventValueChanged];
    [img6 addSubview:swith1];
    
    //swith2
    UISwitch *swith2=[[UISwitch alloc]initWithFrame:CGRectMake(243, 53, 51, 31)];
    swith2.onTintColor=kUIColorFromRGB(0xf18353);
    swith2.tintColor=kUIColorFromRGB(0xf18353);
    swith2.tag=2;
    swith2.on=YES;
    [swith2 addTarget:self action:@selector(changSw:) forControlEvents:UIControlEventValueChanged];
    [img6 addSubview:swith2];
    [scrollView addSubview:img6];
    //创建
    doneBtn=[self customButton:CGRectMake(10, 742+147, 300, 50) backgroungImageNormal:IMAGE(@"create_unSlect") backgrounImageSelect:IMAGE(@"create_Slect") title:@"创建" tag:4 titleColor:kUIColorFromRGB(0x24292c)];
    [scrollView addSubview:doneBtn];
    //触摸谈起键盘
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    [scrollView addGestureRecognizer:tap];
    
    
    
    
    [self.view addSubview:scrollView];
    
}

#pragma mark ---触摸关闭键盘----
-(void)handleTap:(UIGestureRecognizer *)gesture
{
    [self.view endEditing:YES];
    [_textView resignFirstResponder];
    
}

#pragma textiewDelegate

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text containsString:@"\n"]) {
        [_textView resignFirstResponder];
    }
}
/*- (BOOL)textViewShouldEndEditing:(UITextView *)textView;
{
    if ([textView.text containsString:@"\n" ]) {
        
        [textView resignFirstResponder];
        return YES;
    }else
    {
        return NO;
    }
}*/

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;

}

-(void)textViewDidChange:(UITextView *)textView
{
    //self.examineText =  textView.text;
    //[_textView resignFirstResponder];
    if (textView.text.length == 0) {
        _desc.text = @"";
    }else{
        _desc.text = @"";
    }
    
}
#pragma textFiledDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_clubNameField resignFirstResponder];
    return YES;
}
-(void)changSw:(UISwitch *)sw
{
    //是否可见
    if (sw.tag==1) {
        if (sw.on)
        {
            is_public=@"1";//陌生人可见
            
        }
        else
        {
            is_public=@"0";//陌生人不可见
        }
        NSLog(@"陌生人可见");
    }
    else if (sw.tag==2){
        
        if (sw.on)
        {
            is_check=@"1";//开启验证
           
            
        }
        else
        {
            is_check=@"0";//不开启验证
            
        }
        NSLog(@"开启验证");
        
    }
    
    
    
}



//点击选择项目
-(void)chooseProject:(UIButton *)sender
{
    
    if (sender.tag-1000==0)
    {
        //NSLog(@"000");
        btnClickNum1 ++;
        if (btnClickNum1%2)
        {
            for (UIView *sub in [_img5 subviews])
            {
                for (UIView *sub_subView in [sub subviews])
                {
                     if([sub_subView isKindOfClass:[UIImageView class]] && sub_subView.tag-10==sender.tag-1000)
                     {
                         //选中显示
                         
                         UIImageView *img=(UIImageView *)sub_subView;
                         
                         img.hidden=NO;
                         NSLog(@"选了篮球");
                         BasprojectId=@"1";
                     }
                }
            }
            
        }else
        {
            for (UIView *sub in [_img5 subviews])
            {
                for (UIView *sub_subView in [sub subviews])
                {
                    if([sub_subView isKindOfClass:[UIImageView class]] && sub_subView.tag-10==sender.tag-1000)
                    {
                        //选中显示
                        
                        UIImageView *img=(UIImageView *)sub_subView;
                        NSLog(@"没选篮球");
                        BasprojectId=@"";
                        img.hidden=YES;
                    }
                }
            }

            
        }
        
    }else if (sender.tag-1000==1)
    {
        //NSLog(@"111");
        btnClickNum2 ++;
        if (btnClickNum2%2)
        {
            for (UIView *sub in [_img5 subviews])
            {
                for (UIView *sub_subView in [sub subviews])
                {
                    if([sub_subView isKindOfClass:[UIImageView class]] && sub_subView.tag-10==sender.tag-1000)
                    {
                        //选中显示
                        
                        UIImageView *img=(UIImageView *)sub_subView;
                        
                        img.hidden=NO;
                        ftbprojectId=@"2";
                        NSLog(@"选了足球");
                    }
                }
            }
            
        }else
        {
            for (UIView *sub in [_img5 subviews])
            {
                for (UIView *sub_subView in [sub subviews])
                {
                    if([sub_subView isKindOfClass:[UIImageView class]] && sub_subView.tag-10==sender.tag-1000)
                    {
                        //选中显示
                        
                        UIImageView *img=(UIImageView *)sub_subView;
                        NSLog(@"没选足球");
                        ftbprojectId=@"";
                        img.hidden=YES;
                    }
                }
            }
            
            
        }

    }else if (sender.tag-1000==2)
    {
        //NSLog(@"222");
        btnClickNum3 ++;
        if (btnClickNum3%2)
        {
            for (UIView *sub in [_img5 subviews])
            {
                for (UIView *sub_subView in [sub subviews])
                {
                    if([sub_subView isKindOfClass:[UIImageView class]] && sub_subView.tag-10==sender.tag-1000)
                    {
                        //选中显示
                        
                        UIImageView *img=(UIImageView *)sub_subView;
                        
                        img.hidden=NO;
                        badprojectId=@"3";
                        NSLog(@"选了羽毛球");
                    }
                }
            }
            
        }else
        {
            for (UIView *sub in [_img5 subviews])
            {
                for (UIView *sub_subView in [sub subviews])
                {
                    if([sub_subView isKindOfClass:[UIImageView class]] && sub_subView.tag-10==sender.tag-1000)
                    {
                        //选中显示
                        
                        UIImageView *img=(UIImageView *)sub_subView;
                        NSLog(@"没选羽毛球");
                        badprojectId=@"";
                        img.hidden=YES;
                    }
                }
            }
            
            
        }

        
    }else if (sender.tag-1000==3)
    {
        //NSLog(@"333");
        btnClickNum4 ++;
        if (btnClickNum4%2)
        {
            for (UIView *sub in [_img5 subviews])
            {
                for (UIView *sub_subView in [sub subviews])
                {
                    if([sub_subView isKindOfClass:[UIImageView class]] && sub_subView.tag-10==sender.tag-1000)
                    {
                        //选中显示
                        
                        UIImageView *img=(UIImageView *)sub_subView;
                        
                        img.hidden=NO;
                        tennisprojectId=@"4";
                        NSLog(@"选了网球");
                    }
                }
            }
            
        }else
        {
            for (UIView *sub in [_img5 subviews])
            {
                for (UIView *sub_subView in [sub subviews])
                {
                    if([sub_subView isKindOfClass:[UIImageView class]] && sub_subView.tag-10==sender.tag-1000)
                    {
                        //选中显示
                        
                        UIImageView *img=(UIImageView *)sub_subView;
                        NSLog(@"没选网球");
                        tennisprojectId=@"";
                        img.hidden=YES;
                    }
                }
            }
            
            
        }

        
    }else if (sender.tag-1000==4)
    {
        //NSLog(@"444");
        btnClickNum5 ++;
        if (btnClickNum5%2)
        {
            for (UIView *sub in [_img5 subviews])
            {
                for (UIView *sub_subView in [sub subviews])
                {
                    if([sub_subView isKindOfClass:[UIImageView class]] && sub_subView.tag-10==sender.tag-1000)
                    {
                        //选中显示
                        
                        UIImageView *img=(UIImageView *)sub_subView;
                        
                        img.hidden=NO;
                        tabprojectId=@"5";
                        NSLog(@"选了桌球");
                    }
                }
            }
            
        }else
        {
            for (UIView *sub in [_img5 subviews])
            {
                for (UIView *sub_subView in [sub subviews])
                {
                    if([sub_subView isKindOfClass:[UIImageView class]] && sub_subView.tag-10==sender.tag-1000)
                    {
                        //选中显示
                        
                        UIImageView *img=(UIImageView *)sub_subView;
                        NSLog(@"没选桌球");
                        tabprojectId=@"";
                        img.hidden=YES;
                    }
                }
            }
            
            
        }

        
    }

    
}

-(void)dealBtnEvent:(UIButton *)sender
{
    if (sender.tag==0) {
        NSLog(@"111111");
        choose=1;
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        imagePicker.delegate =self;
        imagePicker.allowsEditing =YES;//自定义编辑页面就不需要编辑
        imagePicker.navigationBar.barTintColor=[UIColor blackColor];
        imagePicker.navigationBar.tintColor=[UIColor whiteColor];
        [self presentViewController:imagePicker animated:YES completion:^{
        }];

        
    }else if (sender.tag==1)
    {
        NSLog(@"22222");
        choose=2;
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        imagePicker.delegate =self;
        imagePicker.allowsEditing =YES;//自定义编辑页面就不需要编辑
        imagePicker.navigationBar.barTintColor=[UIColor blackColor];
        imagePicker.navigationBar.tintColor=[UIColor whiteColor];
        [self presentViewController:imagePicker animated:YES completion:^{
        }];

    }else if (sender.tag==2)
    {
        NSLog(@"33333");
        choose=3;
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        imagePicker.delegate =self;
        imagePicker.allowsEditing =YES;//自定义编辑页面就不需要编辑
        imagePicker.navigationBar.barTintColor=[UIColor blackColor];
        imagePicker.navigationBar.tintColor=[UIColor whiteColor];
        [self presentViewController:imagePicker animated:YES completion:^{
        }];

    }else if (sender.tag==3)
    {
        ChooseLocationViewController *vc=[[ChooseLocationViewController alloc]init];
        vc.title=@"选择地点";
        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag==4)
    {
        
        /*if (![_clubNameField.text isEqualToString:@""])
        {
            if (![clubImgUrl isEqualToString:@""]) {
                
                if (![clubCover1Url isEqualToString:@""]&&![clubCover2Url isEqualToString:@""]&&![clubCover3Url isEqualToString:@""]) {
                    
                    if (![lat1 isEqualToString:@""]&&![lng1 isEqualToString:@""]) {
                        
                        NSLog(@"创建成功");
                    }else
                    {
                        [self alertOnly:@"请选择俱乐部地点"];
                    }
                    
                }else
                {
                    [self alertOnly:@"上传俱乐部封面"];
                }
                
            }else
            {
                [self alertOnly:@"请上传俱乐部头像"];
            }
            
        }else
        {
            [self alertOnly:@"请输入俱乐部名称"];
        }
        
        */
        if (![_clubNameField.text isEqualToString:@""]) {
            if (![clubImgUrl isEqualToString:@""]) {
                if (![clubCover1Url isEqualToString:@""]||![clubCover2Url isEqualToString:@""]||![clubCover3Url isEqualToString:@""]) {
                    if (![lat1 isEqualToString:@""]&&![lng1 isEqualToString:@""]) {
                        if (![BasprojectId isEqualToString:@""]||![ftbprojectId isEqualToString:@""]||![badprojectId isEqualToString:@""]||![tennisprojectId isEqualToString:@""]||![tabprojectId isEqualToString:@""]) {
                            NSLog(@"===创建成功===");
                        } else {
                            [self alertOnly:@"请选择俱乐部项目"];
                        }
                        
                    } else {
                        [self alertOnly:@"请选择俱乐部地点"];
                    }
                    
                    
                } else {
                    [self alertOnly:@"上传俱乐部封面"];
                }
                
            } else {
                [self alertOnly:@"上传俱乐部头像"];
            }
            
        } else {
            
            [self alertOnly:@"请输入俱乐部名称"];
        }
    }else if (sender.tag==5)
    {
        NSLog(@"上传俱乐部头像");
        choose=0;
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        imagePicker.delegate =self;
        imagePicker.allowsEditing =YES;//自定义编辑页面就不需要编辑
        imagePicker.navigationBar.barTintColor=[UIColor blackColor];
        imagePicker.navigationBar.tintColor=[UIColor whiteColor];
        
        /*
         imagePicker.navigationBar.backgroundColor=[UIColor blackColor];
         
         
         imagePicker.title=nil;
         [[imagePicker navigationBar] setTintColor:[UIColor blackColor]];
         [imagePicker.navigationBar setBackgroundImage:IMAGE(@"logoTitle") forBarMetrics:UIBarMetricsDefault];
         */
        [self presentViewController:imagePicker animated:YES completion:^{
        }];
        

    }
    
}

#pragma -
#pragma - UIImagePickerControllerDelegate
//取消选择图片
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [picker dismissViewControllerAnimated:YES completion:^{
        //状态栏
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }];
    
}

//选择到imageview上
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // NSLog(@"info::%@",info);
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:@"public.image"])
    {
        
        //切忌不可直接使用originImage，因为这是没有经过格式化的图片数据，可能会导致选择的图片颠倒或是失真等现象的发生，从UIImagePickerControllerOriginalImage中的Origin可以看出，很原始，哈哈
        UIImage *originImage = [info objectForKey:UIImagePickerControllerEditedImage];
        
        
        [picker dismissViewControllerAnimated:YES completion:^{
            if (choose==0) {
                request=1;
                //[ToolLen ShowWaitingView:YES];
                clubImage.image=originImage;
                doneBtn.enabled=NO;//编辑按钮不可用
                [[self JsonFactory] uploadFile:originImage method:POSTMethod action:@"v3/attachments.json"];
            }else if (choose==1)
            {
            request=2;
            clubCover1.image=originImage;
            doneBtn.enabled=NO;//编辑按钮不可用
            [[self JsonFactory] uploadFile:originImage method:POSTMethod action:@"v3/attachments.json"];
            }else if (choose==2)
            {
                request=3;
                clubCover2.image=originImage;
                doneBtn.enabled=NO;//编辑按钮不可用
                [[self JsonFactory] uploadFile:originImage method:POSTMethod action:@"v3/attachments.json"];
            }else if (choose==3)
            {
                request=4;
                clubCover3.image=originImage;
                doneBtn.enabled=NO;//编辑按钮不可用
                [[self JsonFactory] uploadFile:originImage method:POSTMethod action:@"v3/attachments.json"];
            }
            
            
            
        }];
    }
}


-(void)JSONSuccess:(id)responseObject
{
    if (responseObject && [[responseObject objectForKey:@"code"] intValue]==0 && request==1) {
        clubImgUrl=[[responseObject objectForKey:@"data"] objectForKey:@"url"];
        [clubImage sd_setImageWithURL:[NSURL URLWithString:clubImgUrl]];
        doneBtn.enabled=YES;//编辑按钮不可用
        [self alertOnly:@"俱乐部头像上传成功"];
    }else if (responseObject && [[responseObject objectForKey:@"code"] intValue]==0 && request==2)
    {
        clubCover1Url=[[responseObject objectForKey:@"data"] objectForKey:@"url"];
        [clubCover1 sd_setImageWithURL:[NSURL URLWithString:clubCover1Url]];
        doneBtn.enabled=YES;//编辑按钮不可用
        [self alertOnly:@"俱乐部封面1上传成功"];
      
        
    }else if (responseObject && [[responseObject objectForKey:@"code"] intValue]==0 && request==3)
    {
        clubCover2Url=[[responseObject objectForKey:@"data"] objectForKey:@"url"];
        [clubCover2 sd_setImageWithURL:[NSURL URLWithString:clubCover2Url]];
        doneBtn.enabled=YES;//编辑按钮不可用
        [self alertOnly:@"俱乐部封面2上传成功"];
        
    }else if (responseObject && [[responseObject objectForKey:@"code"] intValue]==0 && request==4)
    {
        clubCover3Url=[[responseObject objectForKey:@"data"] objectForKey:@"url"];
        [clubImage sd_setImageWithURL:[NSURL URLWithString:clubCover3Url]];
        doneBtn.enabled=YES;//编辑按钮不可用
        [self alertOnly:@"俱乐部封面3上传成功"];
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
