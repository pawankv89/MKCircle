//
//  ViewController.m
//  MKCircle
//
//  Created by Pawan kumar on 9/23/17.
//  Copyright © 2017 Pawan Kumar. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface ViewController ()<CLLocationManagerDelegate,MKMapViewDelegate>
{
    IBOutlet MKMapView *objMapView;
    IBOutlet UIButton *btnStandard;
    IBOutlet UIButton *btnSatellite;
    IBOutlet UIButton *btnHybrid;
    IBOutlet UISlider *objSlider;
    CLLocationManager *objLocationManager;
    double latitude_UserLocation, longitude_UserLocation;
    int distance;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    distance = 150;
    objSlider.value = distance;
    [self loadUserLocation];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadUserLocation
{
    objLocationManager = [[CLLocationManager alloc] init];
    objLocationManager.delegate = self;
    //objLocationManager.distanceFilter = kCLDistanceFilterNone;
    //objLocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    if ([objLocationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [objLocationManager requestWhenInUseAuthorization];
    }
    [objLocationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *newLocation = [locations objectAtIndex:0];
    latitude_UserLocation = newLocation.coordinate.latitude;
    longitude_UserLocation = newLocation.coordinate.longitude;
    [objLocationManager stopUpdatingLocation];
    [self loadMapView];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    [objLocationManager stopUpdatingLocation];
}

/*
 Load Map With 500m Circle
 */
- (void) loadMapView
{
    CLLocationCoordinate2D objCoor2D = {.latitude = latitude_UserLocation, .longitude = longitude_UserLocation};
    
    //Remove Old OverLay on MAP View
    for (id overlay in objMapView.overlays) {
        if([overlay isKindOfClass:[MKCircle class]]) {
            //Removing past layouts from MapView
            [objMapView removeOverlay:(MKCircle *)overlay];
        }
    }
    
    
    [objMapView setShowsUserLocation:YES];
    [objMapView setDelegate:self ];
    MKCircle *circle = [MKCircle circleWithCenterCoordinate:objCoor2D radius:distance];
    [objMapView addOverlay:circle];
    
    //Set Region On MAP View
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(objCoor2D, distance*2,distance*2);
    [objMapView setRegion:region animated:YES];
}

- (IBAction)btnStandardTapped:(id)sender
{
    [btnStandard setBackgroundColor:[UIColor greenColor]];
    [btnSatellite setBackgroundColor:[UIColor clearColor]];
    [btnHybrid setBackgroundColor:[UIColor clearColor]];
    [objMapView setMapType:MKMapTypeStandard];
    [self loadUserLocation];
}
- (IBAction)btnSatelliteTapped:(id)sender
{
    [btnStandard setBackgroundColor:[UIColor clearColor]];
    [btnSatellite setBackgroundColor:[UIColor greenColor]];
    [btnHybrid setBackgroundColor:[UIColor clearColor]];
    [objMapView setMapType:MKMapTypeSatellite];
    [self loadUserLocation];
}
- (IBAction)btnHybridTapped:(id)sender
{
    [btnStandard setBackgroundColor:[UIColor clearColor]];
    [btnSatellite setBackgroundColor:[UIColor clearColor]];
    [btnHybrid setBackgroundColor:[UIColor greenColor]];
    [objMapView setMapType:MKMapTypeHybrid];
    [self loadUserLocation];
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay
{
    if([overlay isKindOfClass:[MKCircle class]]) {
        
        MKCircleRenderer *circleView = [[MKCircleRenderer alloc] initWithOverlay:overlay];
        circleView.strokeColor = [UIColor blueColor];
        circleView.fillColor = [[UIColor blueColor] colorWithAlphaComponent:0.4];
        circleView.lineWidth = 1.0f;
        return circleView;
    }
    return nil;
}

- (IBAction)sliderViewValueChange:(UISlider*)sliderView
{
    NSLog(@"%ld", (long)sliderView.value);
    
    distance = (int)sliderView.value;
    [self loadMapView];
}


@end
