//
//  ClubViewController.m
//  Gwc
//
//  Created by gwc on 15/7/2.
//  Copyright (c) 2015年 gwc. All rights reserved.
//

#import "ClubViewController.h"
#import "ChoosePlatformViewController.h"
#import "ScreenViewController.h"
#import "CreateClubViewController.h"
#import "ClubTableViewCell.h"
@interface ClubViewController ()

@end

@implementation ClubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"俱乐部";
    btnClickNum1=0;
    btnClickNum2=0;
    btnClickNum3=0;
    btnClickNum4=0;
    btnClickNum5=0;
    btnClickNum6=0;
    self.view.backgroundColor=kUIColorFromRGB(0xeeeeee);
    [self.view addSubview:[self searchView:@"请输入你想查看的俱乐部"]];
    
    self.navigationItem.leftBarButtonItem=[self customBarButtonItem:IMAGE(@"screening")];
    self.navigationItem.rightBarButtonItem=[self customRightBarButtonItem:IMAGE(@"createClub")];
    
    self.sideBar = [[CDRTranslucentSideBar alloc] init];
    self.sideBar.sideBarWidth = 280;
    self.sideBar.translucentStyle=UIBarStyleBlack;
    self.sideBar.translucentAlpha=0.5;
    self.sideBar.translucentTintColor=[UIColor yellowColor];
    self.sideBar.delegate = self;
    self.sideBar.tag = 0;
    // Add PanGesture to Show SideBar by PanGesture
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [self.view addGestureRecognizer:panGestureRecognizer];
    
    // Create Content of SideBar
    
    UIView *viewSelect = [[UIScrollView alloc] init];
    
    //取消
    [viewSelect addSubview:[self customLabel:CGRectMake(10, 26, 40, 30) color:kUIColorFromRGB(0xc6c6c6) text:@"取消" alignment:-1 font:17]];
    [viewSelect addSubview:[self customButton:CGRectMake(10, 26, 40, 30) backgroungImageNormal:nil backgrounImageSelect:nil title:nil tag:0 titleColor:nil]];
    //筛选
    [viewSelect addSubview:[self customLabel:CGRectMake(120, 26, 40, 30) color:kUIColorFromRGB(0x919191) text:@"筛选" alignment:-1 font:20]];
    //确定
    [viewSelect addSubview:[self customLabel:CGRectMake(230, 26, 40, 30) color:kUIColorFromRGB(0xc6c6c6) text:@"确定" alignment:-1 font:17]];
    [viewSelect addSubview:[self customButton:CGRectMake(230, 25, 40, 40) backgroungImageNormal:nil backgrounImageSelect:nil title:nil tag:1 titleColor:nil]];
    
    UIView *backView1=[[UIView alloc]initWithFrame:CGRectMake(0, 65, 280, 270)];
    backView1.backgroundColor=[UIColor clearColor];
    [backView1 addSubview:[self drawLinebg:CGRectMake(0, -1, 280, 1) lineColor:kUIColorFromRGB(0x919191)]];
    [backView1 addSubview:[self customLabel:CGRectMake(34, 8, 71, 29) color:kUIColorFromRGB(0x919191) text:@"足球项目" alignment:-1 font:17]];
    [backView1 addSubview:[self drawLinebg:CGRectMake(34, 45, 212, 1) lineColor:kUIColorFromRGB(0x919191)]];
    [backView1 addSubview:[self customImageView:CGRectMake(222, 11, 24, 24) image:IMAGE(@"slectK")]];
    [backView1 addSubview:[self customButton:CGRectMake(0, 0, 280, 45) backgroungImageNormal:nil backgrounImageSelect:nil title:nil tag:2 titleColor:[UIColor clearColor]]];
    _check1=[self customImageView:CGRectMake(222, 11, 24, 24) image:IMAGE(@"check")];
    _check1.hidden=YES;
    [backView1 addSubview:_check1];
    
    //篮球
    [backView1 addSubview:[self customLabel:CGRectMake(34, 54, 71, 29) color:kUIColorFromRGB(0x919191) text:@"篮球项目" alignment:-1 font:17]];
    [backView1 addSubview:[self drawLinebg:CGRectMake(34, 90, 212, 1) lineColor:kUIColorFromRGB(0x919191)]];
    [backView1 addSubview:[self customImageView:CGRectMake(222, 57, 24, 24) image:IMAGE(@"slectK")]];
    [backView1 addSubview:[self customButton:CGRectMake(0, 45, 280, 45) backgroungImageNormal:nil backgrounImageSelect:IMAGE(@"screenSelect") title:nil tag:3 titleColor:nil]];
    _check2=[self customImageView:CGRectMake(222, 57, 24, 24) image:IMAGE(@"check")];
    _check2.hidden=YES;
    [backView1 addSubview:_check2];
    
    //桌球
    [backView1 addSubview:[self customLabel:CGRectMake(34, 99, 71, 29) color:kUIColorFromRGB(0x919191) text:@"桌球项目" alignment:-1 font:17]];
    [backView1 addSubview:[self drawLinebg:CGRectMake(34, 135, 212, 1) lineColor:kUIColorFromRGB(0x919191)]];
    [backView1 addSubview:[self customImageView:CGRectMake(222, 102, 24, 24) image:IMAGE(@"slectK")]];
    [backView1 addSubview:[self customButton:CGRectMake(0, 90, 280, 45) backgroungImageNormal:nil backgrounImageSelect:IMAGE(@"screenSelect") title:nil tag:4 titleColor:nil]];
    _check3=[self customImageView:CGRectMake(222, 102, 24, 24) image:IMAGE(@"check")];
    _check3.hidden=YES;
    [backView1 addSubview:_check3];
    
    //yumaoqiu
    [backView1 addSubview:[self customLabel:CGRectMake(34, 144, 87, 29) color:kUIColorFromRGB(0x919191) text:@"羽毛球项目" alignment:-1 font:17]];
    [backView1 addSubview:[self drawLinebg:CGRectMake(34, 180, 212, 1) lineColor:kUIColorFromRGB(0x919191)]];
    [backView1 addSubview:[self customImageView:CGRectMake(222, 102+45, 24, 24) image:IMAGE(@"slectK")]];
    [backView1 addSubview:[self customButton:CGRectMake(0, 135, 280, 45) backgroungImageNormal:nil backgrounImageSelect:IMAGE(@"screenSelect") title:nil tag:5 titleColor:nil]];
    _check4=[self customImageView:CGRectMake(222, 102+45, 24, 24) image:IMAGE(@"check")];
    _check4.hidden=YES;
    [backView1 addSubview:_check4];
    
    //网球
    [backView1 addSubview:[self customLabel:CGRectMake(34, 144+45, 87, 29) color:kUIColorFromRGB(0x919191) text:@"网球项目" alignment:-1 font:17]];
    [backView1 addSubview:[self drawLinebg:CGRectMake(34, 180+45, 212, 1) lineColor:kUIColorFromRGB(0x919191)]];
    [backView1 addSubview:[self customImageView:CGRectMake(222, 102+45+45, 24, 24) image:IMAGE(@"slectK")]];
    [backView1 addSubview:[self customButton:CGRectMake(0, 135+45, 280, 45) backgroungImageNormal:nil backgrounImageSelect:IMAGE(@"screenSelect") title:nil tag:6 titleColor:nil]];
    _check5=[self customImageView:CGRectMake(222, 102+45+45, 24, 24) image:IMAGE(@"check")];
    _check5.hidden=YES;
    [backView1 addSubview:_check5];
    
    //jianshen
    [backView1 addSubview:[self customLabel:CGRectMake(34, 144+45+45, 87, 29) color:kUIColorFromRGB(0x919191) text:@"健身项目" alignment:-1 font:17]];
    [backView1 addSubview:[self drawLinebg:CGRectMake(34, 180+45+45, 212, 1) lineColor:kUIColorFromRGB(0x919191)]];
    [backView1 addSubview:[self customImageView:CGRectMake(222, 102+45+45+45, 24, 24) image:IMAGE(@"slectK")]];
    [backView1 addSubview:[self customButton:CGRectMake(0, 135+45+45, 280, 45) backgroungImageNormal:nil backgrounImageSelect:IMAGE(@"screenSelect") title:nil tag:7 titleColor:nil]];
    _check6=[self customImageView:CGRectMake(222, 102+45+45+45, 24, 24) image:IMAGE(@"check")];
    _check6.hidden=YES;
    [backView1 addSubview:_check6];
    
    
    UIView *backView2=[[UIView alloc]initWithFrame:CGRectMake(0, 380, 280, 100)];
    backView2.backgroundColor=[UIColor clearColor];
    [backView2 addSubview:[self customLabel:CGRectMake(34, 13, 71, 29) color:kUIColorFromRGB(0x919191) text:@"热门排序" alignment:-1 font:17]];
    [backView2 addSubview:[self customLabel:CGRectMake(34, 55, 71, 29) color:kUIColorFromRGB(0x919191) text:@"距离排序" alignment:-1 font:17]];
    _swith1=[[UISwitch alloc]initWithFrame:CGRectMake(201, 13, 51, 31)];
    _swith1.onTintColor=kUIColorFromRGB(0xf18353);
    _swith1.tintColor=kUIColorFromRGB(0xf18353);
    _swith1.tag=1;
    _swith1.on=NO;
    [_swith1 addTarget:self action:@selector(changSw:) forControlEvents:UIControlEventValueChanged];
    [backView2 addSubview:_swith1];
    
    //_swith2
    _swith2=[[UISwitch alloc]initWithFrame:CGRectMake(201, 55, 51, 31)];
    _swith2.onTintColor=kUIColorFromRGB(0xf18353);
    _swith2.tintColor=kUIColorFromRGB(0xf18353);
    _swith2.tag=2;
//    _swith2.tag=NO;
    _swith2.on=YES;
    [_swith2 addTarget:self action:@selector(changSw:) forControlEvents:UIControlEventValueChanged];
    

    [backView2 addSubview:_swith2];

    

    
    

    

    
    
    

    [viewSelect addSubview:backView2];
    [viewSelect addSubview:backView1];
    [self.sideBar setContentViewInSideBar:viewSelect];
    
    ClubTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 40, WIDTH, self.view.frame.size.height-20-44-40)];
    ClubTableView.delegate=self;
    ClubTableView.dataSource=self;
    ClubTableView.backgroundView=nil;
    ClubTableView.backgroundColor=[UIColor clearColor];
    ClubTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:ClubTableView];
    
    clubArray=@[@"管维诚的俱乐部1",@"管维诚的俱乐部2",@"管维诚的俱乐部3",@"管维诚的俱乐部4",@"管维诚的俱乐部5",@"管维诚的俱乐部6"];
    UIImage *image1=[UIImage imageNamed:@"1406876286332.jpg"];
    UIImage *image2=[UIImage imageNamed:@"1406876350984.jpg"];
    
    UIImage *image3=[UIImage imageNamed:@"1415929455944.jpg"];
    //IMAGE(@"1415929455944.jpg");
    UIImage *image4=[UIImage imageNamed:@"1415929469230.jpg"];

    //IMAGE(@"1415929469230.jpg");
    UIImage *image5=[UIImage imageNamed:@"1431065306372.jpg"];
    //IMAGE(@"1431065306372.jpg");
    UIImage *image6=[UIImage imageNamed:@"1433300902233.jpg"];
    //IMAGE(@"1433300902233.jpg");
    imageArray=@[image1,image2,image3,image4,image5,image6];
    //进行下拉刷新
    NSArray *array1=@[image6,image1,image3];
     NSArray *array2=@[image5,image2,image5];
     NSArray *array3=@[image4,image3,image6];
     NSArray *array4=@[image3,image4,image2];
     NSArray *array5=@[image2,image5,image4];
     NSArray *array6=@[image1,image6,image1];
    
    imageCoverArray=@[array1,array2,array3,array4,array5,array6];
    _header = [[MJRefreshHeaderView alloc] init];
    _header.delegate = self;
    _header.scrollView = ClubTableView;
    
    //进行上拉加载
    _footer = [[MJRefreshFooterView alloc] init];
    _footer.delegate = self;
    _footer.scrollView = ClubTableView;
}
-(void)changSw:(UISwitch *)sw
{
    //是否可见
    if (sw.tag==1) {
        if (sw.on)
        {
            //is_private=@"0";//公开
            _swith2.on=NO;
        }
        else
        {
            //is_private=@"1";//不公开
            _swith2.on=YES;
        }
    }
    else if (sw.tag==2){
        NSLog(@"tag222222");
        if (sw.on)
        {
            //is_private=@"0";//公开
            _swith1.on=NO;
            //_swith2.on=YES;
            
        }
        else
        {
            //is_private=@"1";//不公开
            _swith1.on=YES;
            //_swith2.on=NO;
        }
    
    }
    
  
        
}

-(void)dealBtnEvent:(UIButton *)sender
{
  
   /* if (sender.tag==0) {
        [self.sideBar dismissAnimated:YES];
    }else if (sender.tag==1)
    {
        NSLog(@"确定");
    }else if (sender.tag==2)
    {
        _check1.hidden=NO;
        
        }
    }*/
    if (sender.tag==2) {
        btnClickNum1++;
        if (btnClickNum1%2) {
            _check1.hidden=NO;
            NSLog(@"足球项目");
            
        }else
        {
            
            _check1.hidden=YES;
           
        }
        
        
    }else if (sender.tag==3)
    {
        btnClickNum2 ++;
        if (btnClickNum2%2) {
            _check2.hidden=NO;
            NSLog(@"篮球项目");
            
        }else
        {
            _check2.hidden=YES;
            
        }
        
    }else if (sender.tag==4)
    {
        btnClickNum3 ++;
        if (btnClickNum3%2) {
            _check3.hidden=NO;
            NSLog(@"桌球项目");
           
        }else
        {
            _check3.hidden=YES;
            
        }
        
        
    }else if (sender.tag==5)
    {
        btnClickNum4 ++;
        if (btnClickNum4%2) {
            _check4.hidden=NO;
            NSLog(@"羽毛球项目");
            
        }else
        {
            _check4.hidden=YES;
            
        }
        
    }else if (sender.tag==6)
    {
        btnClickNum5 ++;
        if (btnClickNum5%2) {
            _check5.hidden=NO;
            NSLog(@"网球项目");
            
        }else
        {
            _check5.hidden=YES;
            
        }
        
    }else if (sender.tag==7)
    {
        btnClickNum6 ++;
        if (btnClickNum6%2) {
            _check6.hidden=NO;
            NSLog(@"健身项目");
            
        }else
        {
            _check6.hidden=YES;
            
        }
        
    }else if (sender.tag==0)
    {
        [self.sideBar dismissAnimated:YES];
    }else if (sender.tag==1)
    {
        NSLog(@"确定");
    }else if (sender.tag==10)
    {
        ChoosePlatformViewController *vc=[[ChoosePlatformViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
 
    
    
   
}
-(void)barBtn
{

     [self.sideBar show];
}
-(void)RightbarBtn
{
    CreateClubViewController *vc=[[CreateClubViewController alloc]init];
    vc.title=@"创建俱乐部";
    [_header endRefreshing];
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark - Gesture Handler
- (void)handlePanGesture:(UIPanGestureRecognizer *)recognizer
{
    
    // if you have left and right sidebar, you can control the pan gesture by start point.
    /*if (recognizer.state == UIGestureRecognizerStateBegan) {
     CGPoint startPoint = [recognizer locationInView:self.view];
     
     // Left SideBar
     if (startPoint.x < self.view.bounds.size.width / 2.0) {
     self.sideBar.isCurrentPanGestureTarget = YES;
     }
     // Right SideBar
     else {
     self.rightSideBar.isCurrentPanGestureTarget = YES;
     }
     }
     
     [self.sideBar handlePanGestureToShow:recognizer inView:self.view];
     [self.rightSideBar handlePanGestureToShow:recognizer inView:self.view];
     */
    // if you have only one sidebar, do like following
    
    self.sideBar.isCurrentPanGestureTarget = YES;
    [self.sideBar handlePanGestureToShow:recognizer inView:self.view];
}
#pragma mark - CDRTranslucentSideBarDelegate
- (void)sideBar:(CDRTranslucentSideBar *)sideBar didAppear:(BOOL)animated
{
    NSLog(@"Left SideBar didAppear");}

- (void)sideBar:(CDRTranslucentSideBar *)sideBar willAppear:(BOOL)animated
{
    NSLog(@"Left SideBar willAppear");
}

- (void)sideBar:(CDRTranslucentSideBar *)sideBar didDisappear:(BOOL)animated
{
    NSLog(@"Left SideBar did disappear");
}

- (void)sideBar:(CDRTranslucentSideBar *)sideBar willDisappear:(BOOL)animated
{
    NSLog(@"Left SideBar willDisappear");
}
-(void)refreshMoreData
{
    
}
-(void)refreshData
{
    
}
#pragma mark - 刷新的代理方法---进入下拉刷新\上拉加载更多都有可能调用这个方法
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (refreshView == _footer)
    {
        [self refreshMoreData];//上拉加载更多
        
    }
    else
    {
        [self refreshData];//下拉刷新数据
    }
}
#pragma uitableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

{
    return clubArray.count;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180.0;
    
}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 20)];
//    view.backgroundColor=kUIColorFromRGB(0xeeeeee);
//    return view;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
//{
//    return 20;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndefiner=@"ClubTableViewCell";
    
    ClubTableViewCell *cell=(ClubTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIndefiner];
    
    if (cell==nil)
    {
        NSArray *xib=[[NSBundle mainBundle]loadNibNamed:@"ClubTableViewCell" owner:self options:nil];
        cell=[xib objectAtIndex:0];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }

    cell.backgroundColor=kUIColorFromRGB(0xeeeeee);
    cell.club_BG.backgroundColor=[UIColor whiteColor];
    cell.club_image.image=[imageArray objectAtIndex:indexPath.row];
    cell.club_name.text=[clubArray objectAtIndex:indexPath.row];
    cell.botton_view.backgroundColor=kUIColorFromRGB(0xeeeeee);

    cell.clbu_cover_one.image=[[imageCoverArray objectAtIndex:indexPath.row] objectAtIndex:0];
    cell.club_cover_two.image=[[imageCoverArray objectAtIndex:indexPath.row] objectAtIndex:1];
    cell.club_cover_three.image=[[imageCoverArray objectAtIndex:indexPath.row] objectAtIndex:2];
    

    
    

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"cell_________________%d",indexPath.row);
    NSLog(@"cellSection__________%d",indexPath.section);
    NSLog(@"------------%d",tableView.tag);
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
