//
//  AppDelegate.h
//  Zonnexions
//
//  Created by Technical Staff on 11/25/15.
//  Copyright © 2015 EP. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

#import "MMDrawerController.h"
#import "SWRevealViewController.h"
#import "Zonnexions-Swift.h"

#import <QuartzCore/QuartzCore.h>
#import <SimpleAuth/SimpleAuth.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import <CoreLocation/CoreLocation.h>



@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) MMDrawerController * drawerController;

@property int limitDistance;
@property BOOL isShared;
@property BOOL isBackGround;

@property SocketIOClient *socket;
@property bool isAuthenticated;
@property (strong, nonatomic) SWRevealViewController *viewController;

//@property (strong, nonatomic)


@end

