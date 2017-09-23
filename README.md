# MKCircle
Circle with distance to showing in Center of MAPView.
We Use /*
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

and use MAPKit Delegate method
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
