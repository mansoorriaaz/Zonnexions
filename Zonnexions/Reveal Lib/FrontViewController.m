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
#import "MZFormSheetPresentationViewController.h"
#import "MZFormSheetPresentationViewControllerSegue.h"


#import "SWRevealViewController.h"
#import "SignUpViewController.h"
#import "SignInViewController.h"

#import "WorkInputViewController.h"
#import "EducationInputViewController.h"
#import "HobbiesInputViewController.h"

@interface FrontViewController()

// Private Methods:
- (IBAction)pushExample:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *lala;
//@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;
- (IBAction)connect:(id)sender;

@end

@implementation FrontViewController
NSMutableURLRequest *requestSocial;

#pragma mark - View lifecycle

- (IBAction)CreateAccount:(id)sender {
    SignUpViewController *signup = [[SignUpViewController alloc] initWithNibName:nil bundle:nil];
//    WorkInputViewController *signup = [[WorkInputViewController alloc] initWithNibName:nil bundle:nil];
//    EducationInputViewController *signup = [[EducationInputViewController alloc] initWithNibName:nil bundle:nil];
//    HobbiesInputViewController *signup = [[HobbiesInputViewController alloc] initWithNibName:nil bundle:nil];
    [self presentViewController:signup animated:YES completion:nil];
    
    
//    SWRevealViewController *revealController = self.revealViewController;
//    [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
//    UIViewController *newFrontController = nil;
//    SignUpViewController *profileView = [[SignUpViewController alloc] init];
//    newFrontController = [[UINavigationController alloc] initWithRootViewController:profileView];
//    
//    [revealController pushFrontViewController:newFrontController animated:YES];
    
    
//    UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"formSheetController"];
    
    
//    MZFormSheetPresentationViewController *formSheetController = [[MZFormSheetPresentationViewController alloc] initWithContentViewController:signup];
//    formSheetController.presentationController.portraitTopInset = 0;
//    formSheetController.presentationController.contentViewSize = CGSizeMake(self.view.frame.size.width -30 , self.view.frame.size.height -60); // or pass in UILayoutFittingCompressedSize to size automatically with auto-layout
//    
//    [self presentViewController:formSheetController animated:YES completion:nil];
    
}

- (void)viewDidLoad{
	[super viewDidLoad];
    
    
        /*
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.center = self.view.center;
    [self.view addSubview:loginButton];
    */
//    UIButton *myLoginButton=[UIButton buttonWithType:UIButtonTypeCustom];
//    myLoginButton.backgroundColor=[UIColor darkGrayColor];
//    myLoginButton.frame=CGRectMake(0,0,180,40);
//    myLoginButton.center = self.view.center;
//    
//    [myLoginButton setTitle: @"My Login Button" forState: UIControlStateNormal];
    
    // Handle clicks on the button
//    [myLoginButton
//     addTarget:self
//     action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    // Add the button to the view
//    [self.view addSubview:myLoginButton];
    
//    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init] ];
//    [self.navigationController.navigationBar setTintColor:[UIColor clearColor]];
    
//    self.navigationController.
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    img.image =[UIImage imageNamed:@"zonnexions-logo.png"];
    [img setContentMode:UIViewContentModeScaleAspectFit];
    self.navigationItem.titleView = img;
    
    SWRevealViewController *revealController = [self revealViewController];
    
    [self.navigationController.navigationBar addGestureRecognizer:revealController.panGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"button-burger-circle.png"]
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
//    [self.appd.socket off:@"requestSocial user location"];
//    [self.appd.socket off:@"friend near"];
//    [self.appd.socket off:@"authenticated"];
//    [self.appd.socket off:@"user list"];
//    [self.appd.socket off:@"send chat"];
//    
    
}

- (IBAction)gPlusLogin:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"G+ Login"
                                                    message:@"Coming Soon"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
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

                              NSLog(@"test %@", [result objectForKey:@"id"]);
                              NSLog(@"test %@", [result objectForKey:@"name"]);

                              NSString *urlOnline = [NSString stringWithFormat:
                                                     @"https://103.23.22.6:9000/users/registerWithSocial?"];
                              
                              NSString *stringUrl =[urlOnline stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                              
                              
                              requestSocial = [[NSMutableURLRequest alloc] initWithURL:
                                             [NSURL URLWithString:stringUrl]];
                              
                              NSLog(@"test %@", requestSocial);
                              
                              [requestSocial setHTTPMethod:@"POST"];
                              
                              NSString *postData = [[NSString alloc]initWithString:[NSString stringWithFormat:@"socialType=facebook&socialID=%@&name=%@&source=iOS",
                                    [result objectForKey:@"id"],
                                    [result objectForKey:@"name"]]];
                              
                              [requestSocial setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-type"];
                              
                              //                              [request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)[content length]]forHTTPHeaderField:@"Content-length"];
                              
                              [requestSocial setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
                              
                              NSError *error;
                              
                              NSURLResponse *response;
                              
                              //        NSData *urlData=[NSURLConnection sendSynchronousRequest:requestWork returningResponse:&response error:&error];
                              
                              //        NSData *urlData = [NSURLConnection sendAsynchronousRequest:requestWork queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                              //            if (error || data == nil) {
                              //                // handle the error
                              //            } else {
                              //                // process the response data
                              //            }
                              //        }];
                              
                              
                              __block NSMutableData *fragmentData = [NSMutableData data];
                              
                              [[NSOperationQueue mainQueue] cancelAllOperations];
                              
                              
                              [NSURLConnection sendAsynchronousRequest:requestSocial queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
                               {
                                   //in case your data is chunked
                                   [fragmentData appendData:data];
                                   
                                   if ([data length] == 0 && error == nil)
                                   {
                                       NSLog(@"No response from server");
                                   }
                                   else if (error != nil && error.code == NSURLErrorTimedOut)
                                   {
                                       NSLog(@"Request time out");
                                   }
                                   else if (error != nil)
                                   {
                                       NSLog(@"Unexpected error occur: %@", error.localizedDescription);
                                   }
                                   // response of the server without error will be handled here
                                   else if ([data length] > 0 && error == nil)
                                   {
                                       // if all the data was successfully gather without error
                                       if ([fragmentData length] == [response expectedContentLength])
                                       {
                                           // finished loading all your data
                                           
                                           // handle your response data here, in this example it's `fragmentData`
                                           NSDictionary *str =[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                           //            [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                                           
                                           NSLog(@"str : %@", [str description] );
                                           NSLog(@"status : %@, message : %@ ", [str objectForKey:@"status"], [str objectForKey:@"msg"]);
                                           
                                           NSDictionary *detailObj = [str objectForKey:@"d"];
                                           
                                           NSLog(@"detail : %@", [detailObj description]);
                                           if ([[str objectForKey:@"status"] intValue] == 1) {
                                               NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                               
                                               [defaults setObject:[result objectForKey:@"name"] forKey:@"name"];
                                           }
                                           
                                           NSString *serverRplyLoginString = [[NSString alloc] initWithData:fragmentData/*responseData*/ encoding:NSASCIIStringEncoding];
                                           
                                           NSDictionary *dictobj=[NSJSONSerialization JSONObjectWithData:fragmentData/*responseData*/ options:kNilOptions error:&error];
                                           
                                           NSLog(@"Login Response Is :%@",serverRplyLoginString);
                                           
                                           NSLog(@"dictobj :%@",dictobj);
                                       }
                                       // if fragmentDatas length is not equal to server response's expectedContentLength
                                       // that means it is a chunked data and the other half of the data will be reloaded and `[fragmentData appendData:data];` will handle that
                                   }
                               }];

                          }
                          
                      }
                  }];
             }
         }
     }];
}

- (void)tempCode{
//    NSString *urlOnline = [NSString stringWithFormat:
//                           @"http://103.23.22.6:9000/users/registerWithSocial?socialType=facebook&socialID=1231321241&name=ekkke&source=iOS"];
//    
//    NSString *stringUrl =[urlOnline stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    
//    
//    requestSocial = [[NSMutableURLRequest alloc] initWithURL:
//                     [NSURL URLWithString:stringUrl]];
//    
//    NSLog(@"test %@", requestSocial);
//    
//    [requestSocial setHTTPMethod:@"POST"];
//    
//    //                              [requestSocial setValue:@"text/xml" forHTTPHeaderField:@"Content-type"];
//    
//    //                              [requestSocial setValue:[NSString stringWithFormat:@"%lu",(unsigned long)[content length]]forHTTPHeaderField:@"Content-length"];
//    
//    //                              [request setHTTPBody:[NSData dataWithBytes:[content UTF8String] length:[content length]]];
//    
//    NSError *error;
//    
//    NSURLResponse *response;
//    
//    NSData *urlData=[NSURLConnection sendSynchronousRequest:requestSocial returningResponse:&response error:&error];
//    
//    NSString *str =[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
//    NSLog(@"str : %@", str);
//    
//    
//    //                              [[NSNotificationCenter defaultCenter] postNotificationName:@"authentication" object:self userInfo:fbData];
//    //                              NSLog(@"%@", [fbData description]);
//    //                              [self checkPermission];
}

- (IBAction)emailLogin:(id)sender {
    SignInViewController *signin = [[SignInViewController alloc] initWithNibName:nil bundle:nil];
    [self presentViewController:signin animated:YES completion:nil];
}



@end