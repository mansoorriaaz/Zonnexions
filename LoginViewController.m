//
//  LoginViewController.m
//  Zonnexions
//
//  Created by Eka Praditya GK on 12/31/15.
//  Copyright © 2015 EP. All rights reserved.
//

#import "LoginViewController.h"
#import "FrontViewController.h"
#import "RearViewController.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s", __PRETTY_FUNCTION__);
    if (self.appd.isAuthenticated) {
        [self idAuthenticated];
            }
    // Do any additional setup after loading the view from its nib.
    UIButton *myLoginButton=[UIButton buttonWithType:UIButtonTypeCustom];
    myLoginButton.backgroundColor=[UIColor darkGrayColor];
    myLoginButton.frame=CGRectMake(0,0,180,40);
    myLoginButton.center = self.view.center;
    
    [myLoginButton setTitle: @"My Login Button" forState: UIControlStateNormal];
    
    // Handle clicks on the button
    [myLoginButton
     addTarget:self
     action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    // Add the button to the view
    [self.view addSubview:myLoginButton];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) idAuthenticated{
//    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    self.appd.window = window;
//    
//    FrontViewController *frontViewController = [[FrontViewController alloc] init];
//    RearViewController *rearViewController = [[RearViewController alloc] init];
//    
//    UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
//    UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
//    
//    SWRevealViewController *mainRevealController = [[SWRevealViewController alloc]
//                                                    initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
//    
//    mainRevealController.delegate = self;
//    
//    self.appd.viewController = mainRevealController;
//    
//    //    self.window.rootViewController = self.viewController;
//    LoginViewController *viewAwal = [[LoginViewController alloc] init];
//    self.appd.window.rootViewController = viewAwal;
//    [self.appd.window makeKeyAndVisible];
}

-(void)loginButtonClicked
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile",@"email",@"user_education_history",@"user_work_history"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error %@", error);
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Logged in");
             NSLog(@"result : %@", [result description] );
             
             NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
             [parameters setValue:@"id,name,email" forKey:@"fields"];
             
             if ([FBSDKAccessToken currentAccessToken]) {
                 [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters]
                  startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                      if (!error) {
                          NSLog(@"fetched user:%@", result);
                          if (result != NULL) {
                              NSMutableDictionary *fbData = [[NSMutableDictionary alloc]init];
                              [fbData setObject:[result objectForKey:@"id"] forKey:@"socialID"];
                              [fbData setObject:[result objectForKey:@"name"] forKey:@"name"];
                              [fbData setObject:@"facebook" forKey:@"socialType"];
                              [fbData setObject:@"iOS" forKey:@"source"];
                              
                              //[fbData setObject:[result objectForKey:@"email"] forKey:@"email"];
                              NSString *customId = [NSString stringWithFormat:@"%@%@",[fbData objectForKey:@"socialID"],[fbData objectForKey:@"socialType"]];
                              [fbData setObject:customId forKey:@"customId"];
                              [[NSUserDefaults standardUserDefaults] setObject:fbData forKey:@"fbData"];
                              [[NSUserDefaults standardUserDefaults] setObject:customId forKey:@"custom id"];
                              [[NSNotificationCenter defaultCenter] postNotificationName:@"authentication" object:self userInfo:fbData];
                              NSLog(@"%@", [fbData description]);
                          }
                          
                      }
                  }];
             }
         }
     }];
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
