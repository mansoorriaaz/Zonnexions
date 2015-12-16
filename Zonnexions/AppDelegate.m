//
//  AppDelegate.m
//  Zonnexions
//
//  Created by Technical Staff on 11/25/15.
//  Copyright © 2015 EP. All rights reserved.
//

#import "AppDelegate.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>


#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"
#import "LeftDrawerViewController.h"

#import "FrontViewController.h"
#import "RearViewController.h"

#import <QuartzCore/QuartzCore.h>

#import <SimpleAuth/SimpleAuth.h>


@import GoogleMaps;

@interface AppDelegate ()
@end

@implementation AppDelegate
{
    CLLocationManager *locationManager;
}

@synthesize window = _window;
@synthesize viewController = _viewController;


- (void)configureAuthorizaionProviders {
    
    // consumer_key and consumer_secret are required
    SimpleAuth.configuration[@"twitter"] = @{};
    SimpleAuth.configuration[@"twitter-web"] = @{};
    
    // client_id and redirect_uri are required
    SimpleAuth.configuration[@"instagram"] = @{};
    
    // app_id is required
    SimpleAuth.configuration[@"facebook"] = @{};
    SimpleAuth.configuration[@"facebook-web"] = @{};
    
    // client_id and redirect_uri are required
    SimpleAuth.configuration[@"meetup"] = @{};
    
    // consumer_key and consumer_secret are required
    SimpleAuth.configuration[@"tumblr"] = @{};
    
    // client_id and redirect_uri are required
    SimpleAuth.configuration[@"foursquare-web"] = @{};
    
    // client_id and redirect_uri are required
    SimpleAuth.configuration[@"dropbox-web"] = @{};
    
    // client_id, client_secret, and redirect_uri are required
    SimpleAuth.configuration[@"linkedin-web"] = @{};
    
    // client_id, client_secret, and redirect_uri are required
    SimpleAuth.configuration[@"trello-web"] = @{};
    
    // client_id and client_secret are required
    SimpleAuth.configuration[@"sinaweibo-web"] = @{};
    
    // client_id and client_secret are required
    SimpleAuth.configuration[@"google-web"] = @{};
    
    // client_id, client_secret and redirect_uri are required
    SimpleAuth.configuration[@"strava-web"] = @{};
    
    // consumer_key and consumer_secret are required
    SimpleAuth.configuration[@"tripit"] = @{};
    
    // client_id and client_secret are required
    SimpleAuth.configuration[@"box-web"] = @{};
    
    // client_id and client_secret are required
    SimpleAuth.configuration[@"onedrive-web"] = @{};
}

- (void) updateLocation
{
    locationManager = [[CLLocationManager alloc] init];
    //locationManager.delegate = self;
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)
    {
        [locationManager requestAlwaysAuthorization];
    }
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 9)
    {
        locationManager.allowsBackgroundLocationUpdates = YES;
    }
    locationManager.distanceFilter = kCLDistanceFilterNone;
    //locationManager.desiredAccuracy = kCLLocationAccuracyBest; // highes
    [locationManager startUpdatingLocation];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Fabric with:@[[Crashlytics class]]];

    [GMSServices provideAPIKey:@"AIzaSyBwYzW4g0L-UHVeIHEiulOZXlMtgfrYn2k"];
    [self configureAuthorizaionProviders];
    
    [self updateLocation];
    
    self.socket = [[SocketIOClient alloc] initWithSocketURL:@"103.23.21.217:3000" options:NULL];
    
    [self.socket on:@"authenticated" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSLog(@"welcome %@", data);
    }];
    
    [self.socket on:@"hello" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSLog(@"socket connected %@", data);
        NSMutableDictionary *jsonAuth = [[NSMutableDictionary alloc]init];
        [jsonAuth setObject:@"ekapradityagk@icloud.com" forKey:@"email"];
        
        [self.socket emit:@"authentication" withItems:[NSArray arrayWithObject:jsonAuth]];
    }];
    
    
    // Override point for customization after application launch.
    /*
    UIViewController * leftDrawer = [[LeftDrawerViewController alloc] init];
    //UIViewController * leftDrawer = [[UIViewController alloc] init];
    UIViewController * center = [[UIViewController alloc] init];
    UIViewController * rightDrawer = [[UIViewController alloc] init];
    
    self.drawerController = [[MMDrawerController alloc]
                             initWithCenterViewController:center
                             leftDrawerViewController:leftDrawer
                             rightDrawerViewController:rightDrawer];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [leftDrawer.view setBackgroundColor:[UIColor blueColor]];
    [rightDrawer.view setBackgroundColor:[UIColor orangeColor]];
    [center.view setBackgroundColor:[UIColor redColor]];
    
    UIColor * tintColor = [UIColor colorWithRed:29.0/255.0
                                          green:173.0/255.0
                                           blue:234.0/255.0
                                          alpha:1.0];
    
    [self.drawerController setShowsShadow:YES];
    [self.drawerController setRestorationIdentifier:@"MMDrawer"];
    //[self.drawerController setMaximumRightDrawerWidth:200.0];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeBezelPanningCenterView];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    [self.window setTintColor:tintColor];
    [self.window setRootViewController:self.drawerController];
    */
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window = window;
    
    FrontViewController *frontViewController = [[FrontViewController alloc] init];
    RearViewController *rearViewController = [[RearViewController alloc] init];
    
    UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
    UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
    
    SWRevealViewController *mainRevealController = [[SWRevealViewController alloc]
                                                    initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
    
    mainRevealController.delegate = self;
    
    self.viewController = mainRevealController;
    
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    [self.socket on:@"request user location" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSMutableDictionary *dic = (NSMutableDictionary*)[data objectAtIndex:0];
        
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
        
        
        [self.socket emit:@"user location" withItems:[NSArray arrayWithObject:jsonLocation]];
        
        
        /*
         NSMutableDictionary *jsonLocation = [[NSMutableDictionary alloc]init];
        [jsonLocation setObject:[dic objectForKey:@"requester"] forKey:@"requester"];
        [jsonLocation setObject:@"entah lah" forKey:@"responder"];
        //[jsonLocation setObject:[NSNumber numberWithDouble:location.coordinate.latitude] forKey:@"lat"];
        //[jsonLocation setObject:[NSNumber numberWithDouble:location.coordinate.longitude] forKey:@"long"];
        [jsonLocation setObject:@"ios" forKey:@"mobile"];
        [jsonLocation setObject:[NSNumber numberWithDouble:77] forKey:@"distance"];
        */
        
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"request user location" object:self userInfo:dic];
       
        
        //[self.socket emit:@"user location" withItems:[NSArray arrayWithObject:jsonLocation]];
        
        NSLog(@"request user location %@", data);
    }];
    //[self measureDistance];
    [self.socket on:@"friend near" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSLog(@"friend near %@", data);
        
        NSMutableDictionary *dic = (NSMutableDictionary*)[data objectAtIndex:0];
        /*
        CLLocationDegrees _lat = [[dic objectForKey:@"lat"] doubleValue];
        CLLocationDegrees _long = [[dic objectForKey:@"long"] doubleValue];
        
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake(_lat,_long);
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.icon = [UIImage imageNamed:@"flag_icon"];
        marker.map = mapView_;
        */
        [[NSNotificationCenter defaultCenter] postNotificationName:@"friend near" object:self userInfo:dic];
        
    }];
    
    [self.socket on:@"chat message" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSLog(@"from chat %@", data);
        NSMutableDictionary *dic = (NSMutableDictionary*)[data objectAtIndex:0];
        NSLog(@"dic %@", [dic description]);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"chat message" object:self userInfo:dic];        
    }];
    
    
    [self.socket connect];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
