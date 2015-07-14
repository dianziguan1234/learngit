//
//  ChooseLocationViewController.h
//  cospo
//
//  Created by gwc on 15/7/5.
//  Copyright (c) 2015年 gwc. All rights reserved.
//

#import "BaseViewController.h"
#import "BMapKit.h"
#import "AppDelegate.h"
@interface ChooseLocationViewController : BaseViewController<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
{
    BMKMapView  *_mapView;
    BMKLocationService *_locService;
    
    CLLocationCoordinate2D coor;
    BMKPointAnnotation *pointAnnotation;
    UILabel *_mapLabel;
    UITextField *_cityField;
    UITextField *_addField;
    UIView *_searchView;
}

@end
