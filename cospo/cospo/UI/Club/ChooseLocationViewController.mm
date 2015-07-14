//
//  ChooseLocationViewController.m
//  cospo
//
//  Created by gwc on 15/7/5.
//  Copyright (c) 2015年 gwc. All rights reserved.
//

#import "ChooseLocationViewController.h"

@interface ChooseLocationViewController ()

@end

@implementation ChooseLocationViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    
    //self.navigationController.navigationBarHidden=YES;
    [[self rdv_tabBarController] setTabBarHidden:YES animated:NO];
    //baiduditu
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:NO];
    self.navigationController.navigationBarHidden=NO;
    [[self rdv_tabBarController] setTabBarHidden:NO animated:NO];
    //baiduditu
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=kUIColorFromRGB(0xeeeeee);
    /*UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 568)];
    view.backgroundColor=[UIColor clearColor];
     */
    [self.view addSubview:[self searchView:@"长按地图选择位置或者输入地址"]];
    
    UIView *rgtView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
    rgtView.backgroundColor=[UIColor clearColor];
    
    /*
     UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(0,(42-28)/2,42, 28)];
     img.image=IMAGE(@"btn_clear");
     [rgtView addSubview:img];
     */
    [rgtView addSubview:[self customLabel:CGRectMake(0, (rgtView.frame.size.height-20)/2, rgtView.frame.size.width/2, 20) color:[UIColor whiteColor] text:@"清空" alignment:0 font:15.0]];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, rgtView.frame.size.width/2, rgtView.frame.size.height);
    [btn addTarget:self action:@selector(item1) forControlEvents:UIControlEventTouchUpInside];
    [rgtView addSubview:btn];
    /*
     UIImageView *img1=[[UIImageView alloc] initWithFrame:CGRectMake(50,(42-28)/2,42, 28)];
     img1.image=IMAGE(@"btn_done");
     [rgtView addSubview:img1];
     */
    [rgtView addSubview:[self customLabel:CGRectMake(rgtView.frame.size.width/2, (rgtView.frame.size.height-20)/2, rgtView.frame.size.width/2, 20) color:[UIColor whiteColor] text:@"确定" alignment:0 font:15.0]];
    UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame=CGRectMake(rgtView.frame.size.width/2, 0, rgtView.frame.size.width/2, rgtView.frame.size.height);
    [btn1 addTarget:self action:@selector(item2) forControlEvents:UIControlEventTouchUpInside];
    [rgtView addSubview:btn1];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:rgtView];
    self.navigationItem.rightBarButtonItem=item;
    
    //顶部视图，搜索
    /*_searchView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    _searchView.backgroundColor=[UIColor clearColor];
    [_searchView addSubview:[self customImageView:CGRectMake(0, 0, WIDTH, 40) image:IMAGE(@"activity_alpha")]];
    [_searchView addSubview:[self customImageView:CGRectMake(160-20, (40-23)/2, 21, 23) image:IMAGE(@"icon_search")]];
    [_searchView addSubview:[self customLabel:CGRectMake(165, 10, 100, 20) color:[UIColor whiteColor] text:@"搜索" alignment:-1 font:16.0]];
    UIButton *searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame=_searchView.bounds;
    [searchBtn addTarget:self action:@selector(searchBtn) forControlEvents:UIControlEventTouchUpInside];
    [_searchView addSubview:searchBtn];
    
    [self.view addSubview:_searchView];
     */
    

    _mapView=[[BMKMapView alloc]initWithFrame:CGRectMake(0, 40, WIDTH, 568-40-44-20-40)];
    _mapView.zoomLevel=19.0;
    _mapView.delegate=self;
    
    coor.latitude = [[AppDelegate setGlobal].lat floatValue];
    coor.longitude = [[AppDelegate setGlobal].lng floatValue];
    
    //坐标点的半径，地图的范围 越小越精确
    BMKCoordinateSpan theSpan;
    theSpan.latitudeDelta=0.03;
    theSpan.longitudeDelta=0.03;
    
    BMKCoordinateRegion region;
    region.center=coor;
    region.span=theSpan;
    BMKCoordinateRegion adjustedRegion = [_mapView regionThatFits:region];
    [_mapView setRegion:adjustedRegion animated:NO];
    
    
    pointAnnotation = [[BMKPointAnnotation alloc]init];
    pointAnnotation.coordinate = coor;
    pointAnnotation.title = @"您当前的位置";
    
    [_mapView addAnnotation:pointAnnotation];
    //geo
    BMKGeoCodeSearch * _geoCodeSearch = [[BMKGeoCodeSearch alloc]init];
    _geoCodeSearch.delegate = self;
    BMKReverseGeoCodeOption *reverseGeoCodeOption= [[BMKReverseGeoCodeOption alloc] init];
    reverseGeoCodeOption.reverseGeoPoint = coor;
    [_geoCodeSearch reverseGeoCode:reverseGeoCodeOption];
    
    
    //方法1:长按地图，添加标注
    UILongPressGestureRecognizer *lpress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    lpress.minimumPressDuration = 0.5;//按0.5秒响应longPress方法
    lpress.allowableMovement = 10.0;
    [_mapView addGestureRecognizer:lpress];//m_mapView是MKMapView的实例


    
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(0, 568-40-64, 320, 40)];
    view2.backgroundColor=[UIColor clearColor];
    [view2 addSubview:[self customImageView:CGRectMake(5, 9, 21, 23) image:IMAGE(@"icon_pin")]];
    _mapLabel=[self customLabel:CGRectMake(21+5, 0, 300, 40) color:kUIColorFromRGB(0x3f2a26) text:@"" alignment:-1 font:17];
    [view2 addSubview:_mapLabel];
    
    
    [self.view addSubview:view2];

    [self.view addSubview:_mapView];

    
    

   

    
}

-(void)item1
{
    NSLog(@"清除");
    _mapLabel.text=@"";
    
}
-(void)item2
{
    NSLog(@"确定");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshAddressPoint" object:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%f",coor.latitude],[NSString stringWithFormat:@"%f",coor.longitude],_mapLabel.text, nil]];
    [self.navigationController popViewControllerAnimated:YES];
}


    
    
    
    
    

/*-(void)dealBtnEvent:(UIButton *)sender
{
    if (sender.tag==0) {
        BMKGeoCodeSearch * _geoCodeSearch = [[BMKGeoCodeSearch alloc]init];
        _geoCodeSearch.delegate = self;
        BMKGeoCodeSearchOption *geocodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];

        geocodeSearchOption.address = searchTextField.text;
        BOOL flag = [_geoCodeSearch geoCode:geocodeSearchOption];
        if(flag)
        {
            NSLog(@"geo检索发送成功");
        }
        else
        {
            NSLog(@"geo检索发送失败");
        }

    }
    
}*/
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [searchTextField resignFirstResponder];
    BMKGeoCodeSearch * _geoCodeSearch = [[BMKGeoCodeSearch alloc]init];
    _geoCodeSearch.delegate = self;
    BMKGeoCodeSearchOption *geocodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
        geocodeSearchOption.address = searchTextField.text;
    BOOL flag = [_geoCodeSearch geoCode:geocodeSearchOption];
    if(flag)
    {
        NSLog(@"geo检索发送成功");
        
        
        _mapLabel.text=searchTextField.text;
    }
    else
    {
        NSLog(@"geo检索发送失败");
    }

    return YES;
}
- (void)longPress:(UIGestureRecognizer*)gestureRecognizer
{
    
    if (gestureRecognizer.state==UIGestureRecognizerStateBegan)
    {
        [_mapView removeAnnotation:pointAnnotation];
        
        //坐标转换
        CGPoint touchPoint = [gestureRecognizer locationInView:_mapView];
        coor =
        [_mapView convertPoint:touchPoint toCoordinateFromView:_mapView];
        
        
        pointAnnotation = [[BMKPointAnnotation alloc]init];
        pointAnnotation.coordinate = coor;
        pointAnnotation.title = @"您选取的位置";
        [_mapView addAnnotation:pointAnnotation];
        
        
        BMKGeoCodeSearch * _geoCodeSearch = [[BMKGeoCodeSearch alloc]init];
        _geoCodeSearch.delegate = self;
        BMKReverseGeoCodeOption *reverseGeoCodeOption= [[BMKReverseGeoCodeOption alloc] init];
        reverseGeoCodeOption.reverseGeoPoint = coor;
        [_geoCodeSearch reverseGeoCode:reverseGeoCodeOption];
    }
    
    
    
}


#pragma mark -
#pragma mark implement BMKMapViewDelegate
-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation{
    
    //[_mapView removeAnnotation:annotation];
    
    if ([annotation isKindOfClass:[BMKPointAnnotation class]])
    {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        
        newAnnotationView.pinColor = BMKPinAnnotationColorRed;//蓝色
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        
        return newAnnotationView;
        
    }
    return nil;
}

//3.逆地理编码有一个监听方法，获取逆地理编码之后的地理位置
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    
    // BMKReverseGeoCodeResult类中的属性值就是逆地理编码之后的结果
    
    /*
     NSLog(@"result::%@",result.address);
     
     NSLog(@"province::%@",result.addressDetail.province);
     NSLog(@"_streetName::%@",result.addressDetail.streetName);
     NSLog(@"_streetNumber::%@",result.addressDetail.streetNumber);
     NSLog(@"_district::%@",result.addressDetail.district);
     NSLog(@"_city::%@",result.addressDetail.city);
     */
    _mapLabel.text=result.address;
    NSLog(@"-----------%@",_mapLabel.text);
    }
//根据地名选择位置
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == 0) {
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate = result.location;
        coor=result.location;
        item.title = result.address;
        [_mapView addAnnotation:item];
        _mapView.centerCoordinate = result.location;
        
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
