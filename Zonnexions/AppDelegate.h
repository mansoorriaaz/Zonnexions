//
//  AppDelegate.h
//  Zonnexions
//
//  Created by Technical Staff on 11/25/15.
//  Copyright © 2015 EP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMDrawerController.h"
#import "SWRevealViewController.h"
#import "Zonnexions-Swift.h"
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) MMDrawerController * drawerController;

@property SocketIOClient *socket;
@property (strong, nonatomic) SWRevealViewController *viewController;

//@property (strong, nonatomic)


@end

