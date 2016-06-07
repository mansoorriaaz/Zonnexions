//
//  MapViewController.m
//  splitBanana
//
//  Created by Technical Staff on 11/27/15.
//  Copyright © 2015 EP. All rights reserved.
//

#import "MapViewController.h"

@import GoogleMaps;

@interface MapViewController ()

@end

@implementation MapViewController
{
    GMSMapView *mapView_;
    BOOL firstLocationUpdate_;
    CLLocation *location;
    CLLocationManager *locationManager;
    NSString *userName;
    People *user;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self funcForThought];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self callMap];
    user = [[People alloc] init];
    
    NSLog(@"limit %d", self.appd.limitDistance );
    self.appd = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(measureDistance:)
                                                 name:@"request user location"
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(friendMarking:)
                                                 name:@"friend near"
                                               object:nil];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init] ];
    //    [self.navigationController.navigationBar setTintColor:[UIColor clearColor]];
    
    //    self.navigationController.
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    img.image =[UIImage imageNamed:@"zonnexions-logo.png"];
    [img setContentMode:UIViewContentModeScaleAspectFit];
    self.navigationItem.titleView = img;
    
//    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:34.0/255.0
//                                                                              green:121.0/255.0
//                                                                               blue:182.0/255.0
//                                                                              alpha:1];
//    

    SWRevealViewController *revealController = [self revealViewController];
    
    [self.navigationController.navigationBar addGestureRecognizer:revealController.panGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"button-burger-circle.png"]
                                                                         style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.868
                                                            longitude:151.2086
                                                                 zoom:12];
    
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.settings.compassButton = YES;
    mapView_.settings.myLocationButton = YES;
    mapView_.delegate = self;
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

-(UIView *) mapView:(GMSMapView *)mapView markerInfoContents:(CustomMarker *)marker{
    CustomInfoWindow *infoWindow = [[[NSBundle mainBundle] loadNibNamed:@"InfoWindow" owner:self options:nil] objectAtIndex:0];
    infoWindow.name.text = marker.title;
    infoWindow.alamat.text = @"Location : xxx";
    userName = infoWindow.name.text;
    NSLog(@"masuk: %@", userName);
    return infoWindow;
}

- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(CustomMarker *)marker {
    NSLog(@"marker name : %@", marker.userName);
    NSLog(@"marker key : %@", marker.userKey);
    
    NSLog(@"nama user : %@", userName);
    ProfileViewController *profil = [[ProfileViewController alloc] init];
    profil.userName = marker.userName;
    profil.userKey = marker.userKey;
    profil.alamatUser.text = @"Location : xxx";
    [self.navigationController pushViewController:profil animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        
        CustomMarker *marker = [[CustomMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake(_lat,_long);
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.icon = [UIImage imageNamed:@"flag_icon"];
        marker.map = mapView_;
        marker.title = [dic objectForKey:@"responder"];
        marker.userName = [dic objectForKey:@"responder"];
        marker.userKey = [dic objectForKey:@"responderCustomId"];
        marker.snippet = @"test";
        marker.infoWindowAnchor = CGPointMake(0.44f, 0.45f);

    }
    
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
        
        if (self.appd.isAuthenticated) {
            [self.appd.socket emit:@"user location" withItems:[NSArray arrayWithObject:jsonLocation]];
        }
        
        
    }
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
    }
}

- (void)funcForThought
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [locationManager startUpdatingLocation];
    
    //Beda NSDictionary dengan MutabaleDictarny yaitu yang mutable bisa di kelola(hapus, tambah,edit) yang lawanya ga bisa.
    NSLog(@"lat func %f", location.coordinate.latitude);
    NSLog(@"long func %f", location.coordinate.longitude);
    
    NSMutableDictionary *json = [[NSMutableDictionary alloc]init];
    [json setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"custom id"] forKey:@"requester"];
    [json setObject:[NSNumber numberWithDouble:locationManager.location.coordinate.latitude] forKey:@"lat"];
    [json setObject:[NSNumber numberWithDouble:locationManager.location.coordinate.longitude] forKey:@"long"];
    if (self.appd.limitDistance > 0) {
        [json setObject: [NSNumber numberWithInt:self.appd.limitDistance] forKey:@"limit"];
        NSLog(@"limit sent");
    }
    
    NSLog(@"limit = %d", self.appd.limitDistance);
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
    if (self.appd.isAuthenticated) { [self.appd.socket emit:@"find friend" withItems:[NSArray arrayWithObject:json]]; }
}

@end
