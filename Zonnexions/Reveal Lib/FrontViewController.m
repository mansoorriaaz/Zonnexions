/*

 Copyright (c) 2013 Joan Lluch <joan.lluch@sweetwilliamsl.com>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is furnished
 to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.

 Original code:
 Copyright (c) 2011, Philip Kluz (Philip.Kluz@zuui.org)
*/

#import "FrontViewController.h"
#import "SWRevealViewController.h"
#import "SignUpViewController.h"


@interface FrontViewController()

// Private Methods:
- (IBAction)pushExample:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *lala;
//@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;
- (IBAction)connect:(id)sender;

@end

@implementation FrontViewController

#pragma mark - View lifecycle

- (IBAction)CreateAccount:(id)sender {
    SignUpViewController *signup = [[SignUpViewController alloc] initWithNibName:nil bundle:nil];
    [self presentModalViewController:signup animated:NO];
}

- (void)viewDidLoad{
	[super viewDidLoad];
    
    
        /*
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.center = self.view.center;
    [self.view addSubview:loginButton];
    */
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
//    [self.view addSubview:myLoginButton];
    
    
    self.title = NSLocalizedString(@"Zonnexions", nil);
    
    
    SWRevealViewController *revealController = [self revealViewController];
    
    [self.navigationController.navigationBar addGestureRecognizer:revealController.panGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"]
        style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(givePermission)
                                                 name:@"authentication"
                                               object:nil];
    
    [self checkPermission];
}

-(void)viewDidAppear:(BOOL)animated{
    
}

-(void)givePermission{
    self.navigationItem.leftBarButtonItem.enabled = YES;
}

-(void)checkPermission{
    NSLog(@"checking %d", self.appd.isAuthenticated);
//    if (self.appd.isAuthenticated == YES) {
//        NSLog(@"authenticated");
//        self.navigationItem.leftBarButtonItem.enabled = YES;
//    }else self.navigationItem.leftBarButtonItem.enabled = NO;
            self.navigationItem.leftBarButtonItem.enabled = YES;
//    NSLog(@"nope");
}

#pragma mark - Example Code

- (IBAction)pushExample:(id)sender
{
//	UIViewController *stubController = [[UIViewController alloc] init];
//	stubController.view.backgroundColor = [UIColor whiteColor];
//	[self.navigationController pushViewController:stubController animated:YES];
//    NSLog(@"start");
//    UILocalNotification *localNotif = [[UILocalNotification alloc]init];
//    localNotif.fireDate = [NSDate dateWithTimeIntervalSinceNow:7];
//    localNotif.alertBody = @"this is local notification";
//    localNotif.timeZone = [NSTimeZone localTimeZone];
//    localNotif.soundName = UILocalNotificationDefaultSoundName;
//    localNotif.applicationIconBadgeNumber = 10;
//    
//    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
//    NSLog(@"end");

    
//    NSArray *data = [[NSArray alloc]init];
//    [self.appd.socket emit:@"disconnect" withItems:data];
    
//    [self.appd.socket disconnect];
//    [self.appd.socket off:@"hello"];
//    [self.appd.socket off:@"request user location"];
//    [self.appd.socket off:@"friend near"];
//    [self.appd.socket off:@"authenticated"];
//    [self.appd.socket off:@"user list"];
//    [self.appd.socket off:@"send chat"];
//    
    
}

- (IBAction)FBlogin:(id)sender {
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
                              [self checkPermission];
                          }
                          
                      }
                  }];
             }
         }
     }];
}

-(void)loginButtonClicked
{
    
}



@end