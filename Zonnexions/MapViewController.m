//
//  MapViewController.m
//  splitBanana
//
//  Created by Technical Staff on 11/27/15.
//  Copyright © 2015 EP. All rights reserved.
//

#import "MapViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@import GoogleMaps;

@interface MapViewController ()

@end

@implementation MapViewController
{
    GMSMapView *mapView_;
    BOOL firstLocationUpdate_;
    CLLocation *location;
    CLLocationManager *locationManager;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self funcForThought];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self callMap];
    self.appd = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(measureDistance:)
                                                 name:@"request user location"
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(friendMarking:)
                                                 name:@"friend near"
                                               object:nil];
    
    
    self.title = NSLocalizedString(@"Map View", nil);
    
    SWRevealViewController *revealController = [self revealViewController];
    
    [self.navigationController.navigationBar addGestureRecognizer:revealController.panGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"]
                                                                         style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.868
                                                            longitude:151.2086
                                                                 zoom:12];
    
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.settings.compassButton = YES;
    mapView_.settings.myLocationButton = YES;
    
    // Listen to the myLocation property of GMSMapView.
    [mapView_ addObserver:self
               forKeyPath:@"myLocation"
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
    
    self.view = mapView_;
    
    // Ask for My Location data after the map has already been added to the UI.
    dispatch_async(dispatch_get_main_queue(), ^{
        mapView_.myLocationEnabled = YES;
    });
    //[self friendMarking];
    //[self friendMarking2];
        // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) callMap
{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                            longitude:151.20
                                                                 zoom:6];
    
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    //mapView_.frame = CGRectMake(0, 0, width, height / 2);
    //self.view.frame = mapView_.frame;
    mapView_.settings.compassButton = YES;
    mapView_.settings.myLocationButton = YES;
    
    // Listen to the myLocation property of GMSMapView.
    [mapView_ addObserver:self
               forKeyPath:@"myLocation"
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
    self.view = mapView_;
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        mapView_.myLocationEnabled = YES;
    });
    
    /* Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
    marker.title = @"Sydney";
    marker.snippet = @"Australia";
    marker.map = mapView_;
     */
    
}

- (void)friendMarking:(NSNotification *) notification
{
    NSLog(@"marking");
    if ([[notification name] isEqualToString:@"friend near"])
    {
        NSLog(@"marking:");
        NSDictionary *dic = [notification userInfo];
        
        CLLocationDegrees _lat = [[dic objectForKey:@"lat"] doubleValue];
        CLLocationDegrees _long = [[dic objectForKey:@"long"] doubleValue];
        
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake(_lat,_long);
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.icon = [UIImage imageNamed:@"flag_icon"];
        marker.map = mapView_;
    }
    
}

- (void)friendMarking2
{
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(-6.266921, 106.778602);
    GMSMarker *marker = [GMSMarker markerWithPosition:position];
    marker.title = @"Hello World";
    marker.map = mapView_;
    
}

- (void) measureDistance:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:@"request user location"])
    {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest; // highes
        [locationManager startUpdatingLocation];
        
        NSLog(@"lati %f", locationManager.location.coordinate.latitude);
        NSLog(@"longi %f", locationManager.location.coordinate.longitude);
        NSDictionary *dic = [notification userInfo];
        
        NSMutableDictionary *jsonLocation = [[NSMutableDictionary alloc]init];
        [jsonLocation setObject:[dic objectForKey:@"requester"] forKey:@"requester"];
        [jsonLocation setObject:@"entah lah" forKey:@"responder"];
        [jsonLocation setObject:[NSNumber numberWithDouble:locationManager.location.coordinate.latitude] forKey:@"lat"];
        [jsonLocation setObject:[NSNumber numberWithDouble:locationManager.location.coordinate.longitude] forKey:@"long"];
        [jsonLocation setObject:@"ios" forKey:@"mobile"];
        
        CLLocationDegrees _lat = [[dic objectForKey:@"lat"] doubleValue];
        CLLocationDegrees _long = [[dic objectForKey:@"long"] doubleValue];
        
        // get CLLocation fot both addresses
        CLLocation *locationRequest = [[CLLocation alloc] initWithLatitude:_lat longitude:_long];
        
        // calculate distance between them
        CLLocationDistance distance = [locationRequest distanceFromLocation:locationManager.location];
        
        [jsonLocation setObject:[NSNumber numberWithDouble:distance] forKey:@"distance"];
        
        
        NSLog(@"JSon %@", [jsonLocation description]);
        
        
        [self.appd.socket emit:@"user location" withItems:[NSArray arrayWithObject:jsonLocation]];
        
    }
    /*
    NSLog(@"measure %f", locationManager.location.coordinate.latitude);

    NSMutableDictionary *json = [[NSMutableDictionary alloc]init];
    [json setObject:@"mansoorcool.cool@gmail.com" forKey:@"requester"];
    [json setObject:[NSNumber numberWithDouble:locationManager.location.coordinate.latitude] forKey:@"lat"];
    [json setObject:[NSNumber numberWithDouble:locationManager.location.coordinate.longitude] forKey:@"long"];
    /**
     Format yang di atas
     json { requester : "mansoorcool.cool@gmail.com",lat : 0,long : 0 }
     
    [self.appd.socket on:@"chat message" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSLog(@"from func = %@", data);
    }];
    
    //Misal yang lebih complex(Misalkan ada object lagi dalamnya.. )
    NSMutableDictionary *geo = [[NSMutableDictionary alloc]init];
    [geo setObject:[NSNumber numberWithDouble:locationManager.location.coordinate.longitude] forKey:@"long"];
    [geo setObject:[NSNumber numberWithDouble:locationManager.location.coordinate.latitude] forKey:@"lat"];
    [json setObject:geo forKey:@"geo"];
    
    
     */
}

- (void)dealloc {
    [mapView_ removeObserver:self
                  forKeyPath:@"myLocation"
                     context:NULL];
}

#pragma mark - KVO updates

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if (!firstLocationUpdate_) {
        // If the first location update has not yet been recieved, then jump to that
        // location.
        firstLocationUpdate_ = YES;
        location = [change objectForKey:NSKeyValueChangeNewKey];
        mapView_.camera = [GMSCameraPosition cameraWithTarget:location.coordinate
                                                         zoom:14];
        NSLog(@"lat observe %f", location.coordinate.latitude);
        NSLog(@"long observe %f", location.coordinate.longitude);
        //[self funcForThought];
    }
}

- (void)funcForThought
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [locationManager startUpdatingLocation];
    
    NSLog(@"func");
    //Beda NSDictionary dengan MutabaleDictarny yaitu yang mutable bisa di kelola(hapus, tambah,edit) yang lawanya ga bisa.
    NSLog(@"lat func %f", location.coordinate.latitude);
    NSLog(@"long func %f", location.coordinate.longitude);
    
    NSMutableDictionary *json = [[NSMutableDictionary alloc]init];
    [json setObject:@"mansoorcool.cool@gmail.com" forKey:@"requester"];
    [json setObject:[NSNumber numberWithDouble:locationManager.location.coordinate.latitude] forKey:@"lat"];
    [json setObject:[NSNumber numberWithDouble:locationManager.location.coordinate.longitude] forKey:@"long"];
    /**
     Format yang di atas
     json {
     requester : "mansoorcool.cool@gmail.com",
     lat : 0,
     long : 0,
     geo : { lat : 0, long : 0 }
     }
     */
    //Emit terima data NsArray so kita masukin seluruh NsDictionary ke array.
    
    // json untuk emit balik location
    
    
    
    [self.appd.socket emit:@"find friend" withItems:[NSArray arrayWithObject:json]];
    
    
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
