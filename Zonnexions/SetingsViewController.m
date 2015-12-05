//
//  SetingsViewController.m
//  splitBanana
//
//  Created by Technical Staff on 11/27/15.
//  Copyright © 2015 EP. All rights reserved.
//

#import "SetingsViewController.h"

@interface SetingsViewController ()
@property (strong, nonatomic) UITableView *tableView;

@end

NSArray *tableData2;



@implementation SetingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSwipe];
    UIView *viewSetting = [[UIView alloc]init];
    self.tableView = [[UITableView alloc] init];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [viewSetting setBackgroundColor:[UIColor yellowColor]];
    [self setView:viewSetting];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.frame = CGRectMake(0, 20, self.view.frame.size.width,200);
    
    [viewSetting addSubview:self.tableView];
    tableData2 = [NSArray arrayWithObjects:@"Nama",@"Location",@"Company",@"HighSchool",@"Pekerjaan", nil];
    [self.tableView reloadData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setSwipe
{
    self.title = NSLocalizedString(@"Profile", nil);
    
    SWRevealViewController *revealController = [self revealViewController];
    
    [self.navigationController.navigationBar addGestureRecognizer:revealController.panGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"]
                                                                         style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"test masuk");
    static NSString *simpleTableIdentifier= @"settingsTableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [tableData2 objectAtIndex:indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController * center;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    switch (indexPath.row) {
        case 0:
            center = [[UIViewController alloc]init];
            [center.view setBackgroundColor:[UIColor blackColor]];
            break;
        case 1:
            center = [[MapViewController alloc] init];
            //center = [[UIViewController alloc] init];
            break;
        case 2:
            center = [[UIViewController alloc]init];
            [center.view setBackgroundColor:[UIColor purpleColor]];
            break;
            
        default:
            break;
    }
    [appDelegate.drawerController setCenterViewController:center];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData2 count];
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
