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

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) MMDrawerController * drawerController;

@property (strong, nonatomic) SWRevealViewController *viewController;


@end

