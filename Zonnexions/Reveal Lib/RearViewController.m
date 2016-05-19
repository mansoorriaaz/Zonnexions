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

*/

#import "Zonnexions-Swift.h"
#import "RearViewController.h"

#import "SWRevealViewController.h"
#import "FrontViewController.h"
#import "MapViewController.h"
#import "SetingsViewController.h"
#import "FriendsViewController.h"
#import "ChatViewController.h"

#import "ProfilSettingViewController.h"
#import "testingViewController.h"



@interface RearViewController() 
{
    NSInteger _presentedRow;
    UITableViewCell *cell;
}

@end

@implementation RearViewController
{
    
}

@synthesize rearTableView = _rearTableView;

/*
 * The following lines are crucial to understanding how the SWRevealViewController works.
 *
 * In this example, we show how a SWRevealViewController can be contained in another instance
 * of the same class. We have three scenarios of hierarchies as follows
 *
 * In the first scenario a FrontViewController is contained inside of a UINavigationController.
 * And the UINavigationController is contained inside of a SWRevealViewController. Thus the
 * following hierarchy is created:
 *
 * - SWRevealViewController is parent of:
 * - 1 UINavigationController is parent of:
 * - - 1.1 RearViewController
 * - 2 UINavigationController is parent of:
 * - - 2.1 FrontViewController
 *
 * In the second scenario a MapViewController is contained inside of a UINavigationController.
 * And the UINavigationController is contained inside of a SWRevealViewController. Thus the
 * following hierarchy is created:
 *
 * - SWRevealViewController is parent of:
 * - 1 UINavigationController is parent of:
 * - - 1.1 RearViewController
 * - 2 UINavigationController is parent of:
 * - - 1.2 MapViewController
 *
 * In the third scenario a SWRevealViewController is contained directly inside of another.
 * SWRevealController. Thus the following hierarchy is created:
 *
 * - SWRevealViewController is parent of:
 * - 1 UINavigationController is parent of:
 * - - 1.1 RearViewController
 * - 2 SWRevealViewController
 * - - ...
 *
 * The second SWRevealViewController on the third scenario can in turn contain anything.
 * On this example it may recursively contain any of the above, including again the third one
 */

- (void)viewDidLoad
{
	[super viewDidLoad];
    
    // We determine whether we have a grand parent SWRevealViewController, this means we are at least one level behind the hierarchy
    SWRevealViewController *parentRevealController = self.revealViewController;
    SWRevealViewController *grandParentRevealController = parentRevealController.revealViewController;
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"]
            style:UIBarButtonItemStyleBordered target:grandParentRevealController action:@selector(revealToggle:)];
    
    // if we have a reveal controller as a grand parent, this means we are are being added as a
    // child of a detail (child) reveal controller, so we add a gesture recognizer provided by our grand parent to our
    // navigation bar as well as a "reveal" button, we also set
//    UIImage *image;
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon.png"]];
    [img setContentMode:UIViewContentModeScaleAspectFit];
    self.navigationItem.title = @"Zonnexions";
    self.navigationItem.titleView = img;
//    self.navigationItem.titleView.

    if ( grandParentRevealController )
    {
        // to present a title, we count the number of ancestor reveal controllers we have, this is of course
        // only a hack for demonstration purposes, on a real project you would have a model telling this.
        NSInteger level=0;
        UIViewController *controller = grandParentRevealController;
        while( nil != (controller = [controller revealViewController]) )
            level++;
        
//        NSString *title = [NSString stringWithFormat:@"Detail Level %d", level];
        
        [self.navigationController.navigationBar addGestureRecognizer:grandParentRevealController.panGestureRecognizer];
        
        self.navigationItem.leftBarButtonItem = revealButtonItem;
    }
    
    // otherwise, we are in the top reveal controller, so we just add a title
    else
    {
//        self.navigationItem.title = @"Zonnexions";
//        self.navigationItem.titleView = img;
    }
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


- (void)viewProfile {
//    SignUpViewController *signup = [[SignUpViewController alloc] initWithNibName:nil bundle:nil];
//    [self presentModalViewController:signup animated:NO];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    SWRevealViewController *grandParentRevealController = self.revealViewController.revealViewController;
    grandParentRevealController.bounceBackOnOverdraw = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    SWRevealViewController *grandParentRevealController = self.revealViewController.revealViewController;
    grandParentRevealController.bounceBackOnOverdraw = YES;
}


#pragma mark - UITableView Data Source
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont fontWithName:@"Montserrat-Hairline" size:32];
    cell.textLabel.textColor = [UIColor whiteColor];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"Cell";
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSInteger row = indexPath.row;
    
	if (nil == cell)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
	}
	
    NSString *text = nil;
	if (row == 0)
	{
		text = @"Profile";
	}
	else if (row == 1)
	{
        text = @"Map";
    }
    else if (row == 2)
    {
        text = @"Friend";
    }
    else if (row == 3)
    {
        text = @"Setting";
    }
    else if (row == 4)
    {
        if (self.appd.isShared == true) {
            text = @"Hide Me";
        }else text = @"Show Me";
    }
    
    cell.textLabel.text = NSLocalizedString( text, nil );
    

	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"tap");
    // Grab a handle to the reveal controller, as if you'd do with a navigtion controller via self.navigationController.
    SWRevealViewController *revealController = self.revealViewController;
    
    // selecting row
    NSInteger row = indexPath.row;
    
    // if we are trying to push the same row or perform an operation that does not imply frontViewController replacement
    // we'll just set position and return
    if ( row == _presentedRow )
    {
        if (row != 4) {
            [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
            return;
        }
    }
    
    UIViewController *newFrontController = nil;

    switch (indexPath.row) {
        case 0:{
                    }
            break;
        case 1:{
            MapViewController *mapViewController = [[MapViewController alloc] init];
            //testingViewController *mapViewController = [[testingViewController alloc] init];
            newFrontController = [[UINavigationController alloc] initWithRootViewController:mapViewController];
        }
            break;
        case 2:{
            FriendsViewController *friendsViewController = [[FriendsViewController alloc] init];
            newFrontController = [[UINavigationController alloc] initWithRootViewController:friendsViewController];
        }
            break;
        case 3:{
            AppSettingViewController *settingViewController =[[AppSettingViewController alloc] init];
            newFrontController = [[UINavigationController alloc] initWithRootViewController:settingViewController];
        }
            break;
        case 4:{
            if (self.appd.isShared == true) {
                cell.textLabel.text = @"Show Me";
                self.appd.isShared = false;
            }else{
                cell.textLabel.text = @"Hide Me";
                self.appd.isShared = true;
            }
        }
            break;
        default:
            break;
    }
    
    
//    else if (row == 5)
//    {
//        [revealController setFrontViewPosition:FrontViewPositionRightMost animated:YES];
//        return;
//    }
//    else if (row == 6)
//    {
//        [revealController setFrontViewPosition:FrontViewPositionRight animated:YES];
//        return;
//    }

    // otherwise we'll create a new frontViewController and push it with animation

    
    if (row == 0)
    {
//        FrontViewController *frontViewController = [[FrontViewController alloc] init];
//        newFrontController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
        
        
    }
    
    else if (row == 1)
    {
//        ProfilSettingViewController *profilView = [[ProfilSettingViewController alloc] init];
//        newFrontController = [[UINavigationController alloc] initWithRootViewController:profilView];
    }
    
    else if ( row == 2 )
    {
//        FriendsViewController *friendsViewController = [[FriendsViewController alloc] init];
//        newFrontController = [[UINavigationController alloc] initWithRootViewController:friendsViewController];
    }
    else if (row == 3)
    {
        
//        AppSettingViewController *settingViewController =[[AppSettingViewController alloc] init];
//        newFrontController = [[UINavigationController alloc] initWithRootViewController:settingViewController];
        
    }
    else if (row >= 4)
    {
//        return;
//        ProfilSettingViewController *profilView = [[ProfilSettingViewController alloc] init];
//        newFrontController = [[UINavigationController alloc] initWithRootViewController:profilView];
    }
    
    if (indexPath.row != 4) {
        NSLog(@"not 4");
        [revealController pushFrontViewController:newFrontController animated:YES];
        
        _presentedRow = row;  // <- store the presented row
    }
}


@end
