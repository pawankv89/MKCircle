
MKCircle
=========

## Find 500m Range of your current location

[![](https://github.com/pawankv89/MKCircle/blob/master/images/screen_1.PNG)](https://github.com/pawankv89/MKCircle/blob/master/images/screen_2.PNG)
[![](https://github.com/pawankv89/MKCircle/blob/master/images/screen_3.PNG)]
[![](https://cloud.githubusercontent.com/assets/91322/26737574/95128ef6-477f-11e7-8b3a-456b2b585e75.png)](https://cloud.githubusercontent.com/assets/91322/26737572/94a137a6-477f-11e7-9778-6266006f2dba.png)
[![](https://cloud.githubusercontent.com/assets/91322/26737576/951cc0c4-477f-11e7-9bc4-891cbbe70f80.png)](https://cloud.githubusercontent.com/assets/91322/26737575/95178c6c-477f-11e7-8df9-03aeeca5d39d.png)
[![](https://cloud.githubusercontent.com/assets/91322/26737577/9523169a-477f-11e7-83d9-c1a55b724c0a.png)](https://cloud.githubusercontent.com/assets/91322/26737578/95235920-477f-11e7-9968-9ecf506aba06.png)
[![](https://cloud.githubusercontent.com/assets/91322/26737579/954371ce-477f-11e7-85f8-660807a7f35e.png)](https://cloud.githubusercontent.com/assets/91322/26737573/95048432-477f-11e7-8f1d-4d5736b10488.png)
[![](https://cloud.githubusercontent.com/assets/91322/26737581/954e3c9e-477f-11e7-93d9-2a8e2e0e7dd0.png)](https://cloud.githubusercontent.com/assets/91322/26737580/954aff70-477f-11e7-9634-5802daea2dee.png)
[![](https://cloud.githubusercontent.com/assets/91322/26737583/955ba17c-477f-11e7-93aa-d952fb0bbce3.png)](https://cloud.githubusercontent.com/assets/91322/26737582/9552886c-477f-11e7-8e90-46acd9a8527c.png)
[![](https://cloud.githubusercontent.com/assets/91322/26737585/95a31822-477f-11e7-9ca6-b33ceb3a3f49.png)](https://cloud.githubusercontent.com/assets/91322/26737584/956392f6-477f-11e7-918f-717a42758156.png)

## Usage
------------
You can add this method in your `UICollectionView`.

```objective-c
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
```
## License

This code is distributed under the terms and conditions of the [MIT license](LICENSE).

## Change-log

A brief summary of each MBProgressHUD release can be found in the [CHANGELOG](CHANGELOG.mdown). 
