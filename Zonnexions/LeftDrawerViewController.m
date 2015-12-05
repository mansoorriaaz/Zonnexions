//
//  LeftDrawerViewController.m
//  splitBanana
//
//  Created by Technical Staff on 11/27/15.
//  Copyright © 2015 EP. All rights reserved.
//

#import "LeftDrawerViewController.h"

@interface LeftDrawerViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

NSArray *tableData;

@implementation LeftDrawerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor grayColor]];
    [self.tableView setBackgroundColor:[UIColor grayColor]];
    
    tableData = [NSArray arrayWithObjects:@"Setting",@"Map",@"etc", nil];
    
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier= @"Simple_Table_Item";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor whiteColor]];
    bgColorView.layer.cornerRadius = 10;
    [cell setBackgroundColor:[UIColor grayColor]];
    [cell setSelectedBackgroundView:bgColorView];
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController * center;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    switch (indexPath.row) {
        case 0:
            center = [[SetingsViewController alloc]init];
            break;
        case 1:
            center = [[MapViewController alloc] init];
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
    return 3;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
