//
//  SetingsViewController.m
//  splitBanana
//
//  Created by Technical Staff on 11/27/15.
//  Copyright © 2015 EP. All rights reserved.
//

#import "FriendsViewController.h"

@interface FriendsViewController ()
@property (strong, nonatomic) UITableView *tableView;


@end

NSArray *tableData3;
int check;
NSString *friendName;

LGChatController *chatController;

@implementation FriendsViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSwipe];
    chatController = [LGChatController new];
    
    UIView *viewSetting = [[UIView alloc]init];
    self.tableView = [[UITableView alloc] init];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [viewSetting setBackgroundColor:[UIColor yellowColor]];
    [self setView:viewSetting];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.frame = CGRectMake(0, 20, self.view.frame.size.width,200);
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveChat:)
                                                 name:@"chat message"
                                               object:nil];
    
    
    [viewSetting addSubview:self.tableView];
    tableData3 = [NSArray arrayWithObjects:@"Ani",@"Budi",@"Joko",@"Toni",@"Jobs", nil];
    [self.tableView reloadData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)receiveChat:(NSNotification *) notification
{
    NSLog(@"marking");
    if ([[notification name] isEqualToString:@"chat message"])
    {
        NSDictionary *dic = [notification userInfo];
        NSLog(@"dic friend %@", [dic description]);
        LGChatMessage *helloWorld = [[LGChatMessage alloc] initWithContent:[dic description] sentByString:[LGChatMessage SentByOpponentString]];
        if (check != 1) {
            [chatController addNewMessage:helloWorld];
        }
        check = 0;
    }
    
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
    
    cell.textLabel.text = [tableData3 objectAtIndex:indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController * center;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    switch (indexPath.row) {
        case 0:
            [self launchChatController];
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
    return [tableData3 count];
}


#pragma mark - Launch Chat Controller

- (void)launchChatController
{
    chatController.opponentImage = [UIImage imageNamed:@"YourImageName"];
    chatController.title = @"<#YourTitle#>";
    LGChatMessage *helloWorld = [[LGChatMessage alloc] initWithContent:@"Hello World" sentByString:[LGChatMessage SentByUserString]];
    chatController.messages = @[helloWorld]; // Pass your messages here.
    chatController.delegate = self;
    [self.navigationController pushViewController:chatController animated:YES];
}

#pragma mark - LGChatControllerDelegate

- (void)chatController:(LGChatController *)chatController didAddNewMessage:(LGChatMessage *)message
{
    NSLog(@"Did Add Message: %@", message.content);
    //message.sentByString = [LGChatMessage SentByOpponentString];
    
}

- (BOOL)shouldChatController:(LGChatController *)chatController addMessage:(LGChatMessage *)message
{
    /*
     Use this space to prevent sending a message, or to alter a message.  For example, you might want to hold a message until its successfully uploaded to a server.
     */
    NSLog(@"tap?? %d", check);
    check = 1;
    message.sentByString = [LGChatMessage SentByUserString];
    [self.appd.socket emit:@"chat message" withItems:[NSArray arrayWithObjects:message.content,nil]];
   // message.sentByString = arc4random_uniform(2) == 0 ? [LGChatMessage SentByOpponentString] : [LGChatMessage SentByUserString];
    
    return YES;
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
