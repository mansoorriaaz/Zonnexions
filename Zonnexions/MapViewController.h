//
//  MapViewController.h
//  splitBanana
//
//  Created by Technical Staff on 11/27/15.
//  Copyright © 2015 EP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "SWRevealViewController.h"
#import "CustomInfoWindow.h"
#import <GoogleMaps/GoogleMaps.h>
#import "ProfileViewController.h"
#import "People.h"
#import "CustomMarker.h"

@interface MapViewController : ViewController <UIGestureRecognizerDelegate, GMSMapViewDelegate>

@end
