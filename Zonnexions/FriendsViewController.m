//
//  SetingsViewController.m
//  splitBanana
//
//  Created by Technical Staff on 11/27/15.
//  Copyright © 2015 EP. All rights reserved.
//

#import "FriendsViewController.h"
#import "ProfileViewerViewController.h"
#import "SearchList.h"

@interface FriendsViewController ()
@property (strong, nonatomic) UITableView *tableView;


@end

NSMutableArray *tableData3;
NSMutableDictionary *tableDataUser;
int check;
NSString *friendName;
People *currentUser;
People *user;
CLLocation *location;
CLLocationManager *locationManager;
LGChatController *chatController;
CLLocationDistance *distance;

NSMutableURLRequest *requestGetPictureFV;
UIImage *imageForThumbnail;
NSString *pictureID;
NSMutableArray *findList;
RLMResults *peopleRLMDB;


@implementation FriendsViewController{
    SearchList *sL;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSUserDefaults standardUserDefaults]setObject:@"2" forKey:@"menu"];

    sL = [[SearchList alloc]init];
//    [self deleteWorkinRLM];
    
//    tableData3 = [[NSMutableArray alloc]init];
    [self setSwipe];
//    if (self.appd.isAuthenticated) { [self.appd.socket emit:@"user list" withItems:[NSArray array]]; }
    findList = [[NSMutableArray alloc]init];

    UIView *viewSetting = [[UIView alloc]init];
    self.tableView = [[UITableView alloc] init];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [viewSetting setBackgroundColor:[UIColor colorWithRed:34.0/255.0
                                                    green:121.0/255.0
                                                     blue:182.0/255.0
                                                    alpha:1]];
    [self setView:viewSetting];
    [self grabPeopleFromRLM];
//    [self grabFriend];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.frame = CGRectMake(0, 20, self.view.frame.size.width,200);


//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(userlist:)
//                                                 name:@"user list"
//                                               object:nil];

//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(friendMarking:)
//                                                 name:@"friend near"
//                                               object:nil];

    
    [viewSetting addSubview:self.tableView];
    //tableData3 = [NSArray arrayWithObjects:@"Ani",@"Budi",@"Joko",@"Toni",@"Jobs", nil];
    [self.tableView reloadData];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"view did appear");
    chatController = NULL;
    chatController = [LGChatController new];
//    [self.tableView reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)userlist:(NSNotification *) notification
{
    NSLog(@"USER LIST");
    NSLog(@"table3 1 : %@", [tableData3 description]);
    [tableData3 removeAllObjects];
    NSLog(@"table3 2 : %@", [tableData3 description]);
    
    NSDictionary *dic = [notification userInfo];
    NSLog(@"dic desc %@", [dic description]);
    for (NSString* key in dic){
    NSLog(@"user list");    
        user = [[People alloc] init];
        user.name = (NSString *)[dic objectForKey:key];
        user.customId = key;
        
        [tableData3 addObject:user];
    }
        NSLog(@"table 3  : %@", [tableData3 description]);
        [self.tableView reloadData];
}

- (void)grabFriend
{
    NSLog(@"GRAB FRIEND");
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [locationManager startUpdatingLocation];
    
    //Beda NSDictionary dengan MutabaleDictarny yaitu yang mutable bisa di kelola(hapus, tambah,edit) yang lawanya ga bisa.
    NSLog(@"lat func %f", location.coordinate.latitude);
    NSLog(@"long func %f", location.coordinate.longitude);
    
    NSMutableDictionary *json = [[NSMutableDictionary alloc]init];
    [json setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"custom id"] forKey:@"requester"];
    [json setObject:[NSNumber numberWithDouble:locationManager.location.coordinate.latitude] forKey:@"lat"];
    [json setObject:[NSNumber numberWithDouble:locationManager.location.coordinate.longitude] forKey:@"long"];
    if (self.appd.limitDistance > 0) {
        [json setObject: [NSNumber numberWithInt:self.appd.limitDistance] forKey:@"limit"];
        NSLog(@"limit sent");
    }
    
    NSLog(@"limit = %d", self.appd.limitDistance);
    /**
     Format yang di atas
     json {
     requester : "mansoorcool.cool@gmail.com",
     lat : 0,
     long : 0,
     geo : { lat : 0, long : 0 }
     }
     */
    //Emit terima data NsArray so kita masukin seluruh NsDictionary ke array.
    // json untuk emit balik location
    if (self.appd.isAuthenticated) { [self.appd.socket emit:@"find friend" withItems:[NSArray arrayWithObject:json]]; }
}

- (void)friendMarking:(NSNotification *) notification
{
    NSLog(@"marking");
    if ([[notification name] isEqualToString:@"friend near"])
    {
        NSLog(@"marking:");
        NSDictionary *dic = [notification userInfo];
        NSLog(@"marked : %@", [dic description]);
        tableDataUser = [[NSMutableDictionary alloc]initWithDictionary:dic];
        NSLog(@"user loc : %@", [tableDataUser description] );
//        int i;
//        for (NSObject* key in tableData3) {
//            People *user = (People *) [tableData3 objectAtIndex:i];
//            
//            if (user.name == [tableDataUser objectForKey:@"responder"]) {
//                user.name = [tableDataUser objectForKey:@"responder"];
//                user.customId = [tableDataUser objectForKey:@"responderCustomId"];
//                user.distance = [tableDataUser objectForKey:@"distance"];
//                [tableData3 addObject:user];
//            }
//            i++;
//        }
        
//        CLLocationDegrees _lat = [[dic objectForKey:@"lat"] doubleValue];
//        CLLocationDegrees _long = [[dic objectForKey:@"long"] doubleValue];
        
//        CustomMarker *marker = [[CustomMarker alloc] init];
//        marker.position = CLLocationCoordinate2DMake(_lat,_long);
//        marker.appearAnimation = kGMSMarkerAnimationPop;
//        marker.icon = [UIImage imageNamed:@"flag_icon"];
//        marker.map = mapView_;
//        marker.title = [dic objectForKey:@"responder"];
//        marker.userName = [dic objectForKey:@"responder"];
//        marker.userKey = [dic objectForKey:@"responderCustomId"];
//        marker.snippet = @"test";
//        marker.infoWindowAnchor = CGPointMake(0.44f, 0.45f);
        [self.tableView reloadData];
    }
    
}

- (void)receiveChat:(NSNotification *) notification
{
    NSLog(@"marking");
    if ([[notification name] isEqualToString:@"chat message"])
    {
        NSDictionary *dic = [notification userInfo];
        NSLog(@"dic friend %@", [dic description]);
        
        NSString *sender = [dic objectForKey:@"origin"];
        

        LGChatMessage *helloWorld = [[LGChatMessage alloc] initWithContent:[dic objectForKey:@"message"] sentByString:[LGChatMessage SentByOpponentString]];
        if ([sender isEqualToString:currentUser.customId]) {
            
//            Chat *c = [[Chat alloc] init];
//            
//            c.is_me = false;
//            c.chatWith = [NSString stringWithFormat:@"%@", [dic objectForKey:@"origin"]];
//            c.message = (NSString* ) [dic objectForKey:@"message"];
//            c.timeStamp = [NSString stringWithFormat:@"%@",[dic objectForKey:@"time_stamp"]] ;
//            
//            RLMRealm *realm = [RLMRealm defaultRealm];
//            [realm beginWriteTransaction];
//            [realm addObject:c];
//            [realm commitWriteTransaction];
//
            [chatController addNewMessage:helloWorld];
            NSLog(@"saving to db");
        }
        
    }
    
}

- (void)setSwipe
{
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init] ];
    //    [self.navigationController.navigationBar setTintColor:[UIColor clearColor]];
    
    //    self.navigationController.
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    img.image =[UIImage imageNamed:@"zonnexions-logo.png"];
    [img setContentMode:UIViewContentModeScaleAspectFit];
    self.navigationItem.titleView = img;
    
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:34.0/255.0
                                                                              green:121.0/255.0
                                                                               blue:182.0/255.0
                                                                              alpha:1];
    
    SWRevealViewController *revealController = [self revealViewController];
    
    [self.navigationController.navigationBar addGestureRecognizer:revealController.panGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"button-burger-circle.png"]
                                                                         style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"============= test masuk =============");
    static NSString *simpleTableIdentifier= @"settingsTableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(5,-10, 95, 95)];
    if (!(imageForThumbnail == nil)) {
        imv.image=imageForThumbnail;
    }else{
        imv.image=[UIImage imageNamed:@"icon.png"];
    }
    if (cell) {
        cell = nil;
        [cell removeFromSuperview];
    }

    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        NSLog(@"cell : ");
    }
    
    People *user = (People *) [tableData3 objectAtIndex:indexPath.row];
    NSLog(@"table data user %@", [tableDataUser description]);
    NSString * text = user.name;

//    if (tableDataUser) {
//        int i;
//        for (NSString *key in tableDataUser) {
//            if (user.name == [tableDataUser objectForKey:@"responder"]) {
//                text = [tableDataUser valueForKey:@"distance"];
//            }
//            i++;
//        }
//    }
    
//    NSDictionary *dict = [tableDataUser objectForKey:@"responder"];
//    NSDictionary *dict=[tableDataUser valueForKeyPath:user.name][5];
//    NSString *dict=[[tableDataUser valueForKeyPath:user.name][0] objectForKey:@"distance"];
//    NSLog(@"dict data %@", [dict description]);
//    NSLog(@"dict data %@", dict);

//    NSString *locationData = [tableDataUser objectForKey:user.name];
    
    
    UIFont * customFont = [UIFont fontWithName:@"Montserrat-ultralight" size:14]; //custom font
    
    CGSize labelSize = [text sizeWithFont:customFont constrainedToSize:CGSizeMake(380, 20) lineBreakMode:NSLineBreakByTruncatingTail];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(105, 10, 380, 40)];
    nameLabel.text = user.name;
    nameLabel.font = [UIFont fontWithName:@"Montserrat-regular" size:18];
    nameLabel.numberOfLines = 1;
    nameLabel.baselineAdjustment = UIBaselineAdjustmentAlignBaselines; // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
    nameLabel.adjustsFontSizeToFitWidth = YES;
    nameLabel.adjustsLetterSpacingToFitWidth = YES;
    nameLabel.minimumScaleFactor = 10.0f/12.0f;
    nameLabel.clipsToBounds = YES;
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    
    
    UILabel *rangeLabel = [[UILabel alloc]initWithFrame:CGRectMake(91, 45, 400, labelSize.height)];
    NSString *jarak;
    rangeLabel.text = @"approx 100 meters";
    rangeLabel.font = customFont;
    rangeLabel.numberOfLines = 1;
    rangeLabel.baselineAdjustment = UIBaselineAdjustmentAlignBaselines; // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
    rangeLabel.adjustsFontSizeToFitWidth = YES;
    rangeLabel.adjustsLetterSpacingToFitWidth = YES;
    rangeLabel.minimumScaleFactor = 10.0f/12.0f;
    rangeLabel.clipsToBounds = YES;
    rangeLabel.backgroundColor = [UIColor clearColor];
    rangeLabel.textColor = [UIColor blackColor];
    rangeLabel.textAlignment = NSTextAlignmentLeft;
    NSLog(@"people count : %lu", (unsigned long)peopleRLMDB.count);
    if (peopleRLMDB.count > 0) {
//        NSLog(@"education list :%@", [eduRLMDB description]);
        SearchList *sLst = [peopleRLMDB objectAtIndex:indexPath.row];
        //        NSLog(@"chat object = %@",[ch description]);
        if (sLst.friendID == nil) {
//            [peopleRLMDB ]
        }
        nameLabel.text = sLst.friendName;
        
        if (!(sLst.friendPicture == nil)) {
            NSLog(@"friend pict : %@", sLst.friendPicture);
            pictureID = sLst.friendPicture;
            NSLog(@"pict id : %@", pictureID);
            [self grabImage];
            imageForThumbnail = nil;
        }
        [findList insertObject:sLst.friendID atIndex:indexPath.row];
//        NSLog(@"school : %@", edu.educationName);
    }
    
    [cell addSubview:imv];
    [cell addSubview:nameLabel];
    [cell addSubview:rangeLabel];
//    cell.textLabel.text = user.name;
//    cell.textLabel.text = user.name;

    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UIViewController * center;
////    NSLog(@"choice : %@" self.tableView.tableData3);
////    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    People *user = (People *) [tableData3 objectAtIndex:indexPath.row];
//    NSLog(@"user %@", [user description]);
//    currentUser = user;
//    NSLog(@"custom id = %@",currentUser.customId);
////    [chatController setMessages:[NSArray<LGChatMessage *> array]];
//    
//    
//    chatController.opponentImage = [UIImage imageNamed:@"YourImageName"];
//    chatController.title = user.name;
//    chatController.delegate = self;
//    
//    
//    RLMResults *chatResult = [[Chat objectsWhere:[NSString stringWithFormat:@"chatWith = '%@'", currentUser.customId]] sortedResultsUsingProperty:@"timeStamp" ascending:YES];
//    
//
//    NSMutableArray<LGChatMessage *> *messages = [[NSMutableArray alloc] init];
//    for (int i =0; i < [chatResult count]; i++) {
//        Chat *ch = [chatResult objectAtIndex:i];
////        NSLog(@"chat object = %@",[ch description]);
//        LGChatMessage *message;
//        if (ch.is_me) {
////            NSLog(@"is this me??? %i",ch.is_me);
//             message = [[LGChatMessage alloc] initWithContent:ch.message sentByString:[LGChatMessage SentByUserString]];
//        }else{
////                        NSLog(@"is this me? %i",ch.is_me);
//                message= [[LGChatMessage alloc] initWithContent:ch.message sentByString:[LGChatMessage SentByOpponentString]];
//        }
//        [messages addObject:message];
//    }
//    [chatController setMessages:messages];
//    [self.navigationController pushViewController:chatController animated:YES];
    
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@", [findList objectAtIndex:indexPath.row]] forKey:@"friendID"];
    
    SWRevealViewController *revealController = self.revealViewController;

    UIViewController *newFrontController = nil;

    ProfileViewerViewController *profileView = [[ProfileViewerViewController alloc] init];
    newFrontController = [[UINavigationController alloc] initWithRootViewController:profileView];
    
    [revealController pushFrontViewController:newFrontController animated:YES];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [peopleRLMDB count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95;
}
#pragma mark - Launch Chat Controller

- (void)launchChatController{
    
}

#pragma mark - LGChatControllerDelegate

- (void)chatController:(LGChatController *)chatController didAddNewMessage:(LGChatMessage *)message{
    NSLog(@"Did Add Message: %@", message.content);
    
}

- (void) grabPeopleFromRLM{
    peopleRLMDB = [SearchList allObjects];
    NSLog(@"list grab people : %@", [peopleRLMDB description]);
    [self.tableView reloadData];
}


-(void)grabImage{
    NSString *urlOnline = [NSString stringWithFormat:
                           @"http://103.23.22.6:9000/users/getProfilePicture"];
    
    
    NSString *stringUrl =[urlOnline stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    requestGetPictureFV = [[NSMutableURLRequest alloc] initWithURL:
                        [NSURL URLWithString:stringUrl]];
    
    NSLog(@"test %@", requestGetPictureFV);
    
    [requestGetPictureFV setHTTPMethod:@"POST"];
    
    
    NSString *postData = [[NSString alloc]initWithString:[NSString stringWithFormat:@"fd=%@",pictureID]];
    NSLog(@"post data :%@ ", postData);
    [requestGetPictureFV setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-type"];
    
    //                              [request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)[content length]]forHTTPHeaderField:@"Content-length"];
    
    [requestGetPictureFV setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error;
    
    NSURLResponse *response;
    
    //    NSData *urlData=[NSURLConnection sendSynchronousRequest:requestGetWork returningResponse:&response error:&error];
    //
    //    NSDictionary *str =[NSJSONSerialization JSONObjectWithData:urlData options:kNilOptions error:&error];
    //    //            [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    //
    
    
    __block NSMutableData *fragmentData = [NSMutableData data];
    
    [[NSOperationQueue mainQueue] cancelAllOperations];
    
    
    [NSURLConnection sendAsynchronousRequest:requestGetPictureFV queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
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
             NSLog(@"=========================== Image  ==========================");
             NSData *image = data;
             if (image == nil) {
                 NSLog(@"image nil");
             }else{
                 NSLog(@"image here?");
                 
                 UIImage *topImage = [UIImage imageNamed:@"cover_white.png"];
                 
                 CGSize size = CGSizeMake(topImage.size.width, topImage.size.height);// + profilImage.size.height);
                 
                 UIGraphicsBeginImageContextWithOptions(size,false,0.0);
                 
                 [[UIImage imageWithData:image] drawInRect:CGRectMake(0,0,size.width, topImage.size.height)];
                 [topImage drawInRect:CGRectMake(0,0,size.width,size.height)];//, profilImage.size.height)];
                 
                 UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
                 
                 UIGraphicsEndImageContext();

                 imageForThumbnail = finalImage;
                 [self.tableView reloadData];
             }
             NSDictionary *str =[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
             NSLog(@"str : %@", [str description] );
             
         }
     }];
    
    //    NSLog(@"str : %@", [str description] );
    //    NSLog(@"status : %@, message : %@ ", [str objectForKey:@"status"], [str objectForKey:@"msg"]);
    //
    
}

- (void) deleteWorkinRLM{
    RLMRealm *realm = [RLMRealm defaultRealm];
    NSLog(@"deleting now");
    [realm beginWriteTransaction];
    [realm deleteObject:sL];
    [realm commitWriteTransaction];
}

- (BOOL)shouldChatController:(LGChatController *)chatController addMessage:(LGChatMessage *)message{
    /**
     *Use this space to prevent sending a message, or to alter a message.
     *For example, you might want to hold a message until its successfully uploaded to a server.
     **/
    message.sentByString = [LGChatMessage SentByUserString];
    NSMutableDictionary *chatConfig = [[NSMutableDictionary alloc]init];
    [chatConfig setObject:currentUser.customId forKey:@"target"];
    [chatConfig setObject:message.content forKey:@"message"];
    if (self.appd.isAuthenticated) {
        NSArray *a = [NSArray arrayWithObject:chatConfig];
//        [self.appd.socket emit:@"send chat" withItems:[NSArray arrayWithObject:chatConfig] ];
        [self.appd.socket emitWithAck:@"send chat" withItems:a](0,^(NSArray* data){
            NSMutableDictionary *dic = (NSMutableDictionary*) [data objectAtIndex:0];
            bool success = (Boolean) [dic objectForKey:@"success"];
            if (success) {
//                NSLog(@"SEMua aman gan.... lancar dech....yeee");
                Chat *c = [[Chat alloc] init];
                
                [c setIs_me:true];
                c.chatWith = [NSString stringWithFormat:@"%@", [chatConfig objectForKey:@"target"]];
                c.message = (NSString* ) [chatConfig objectForKey:@"message"];
                c.timeStamp = [NSString stringWithFormat:@"%@",[dic objectForKey:@"time_stamp"]] ;
                RLMResults *result = [Chat allObjects];
//                NSLog(@"total chat is = %lu",(unsigned long)[result count]);
                RLMRealm *realm = [RLMRealm defaultRealm];
                [realm beginWriteTransaction];
                [realm addObject:c];
                [realm commitWriteTransaction];
                
                RLMResults *result2 = [Chat allObjects];
//                NSLog(@"total chat is = %lu",(unsigned long)[result2 count]);
//                NSLog(@"chat object when sending = %@",[c description]);
            }else{
                NSLog(@"sorry bro pesan ga ke kirim error.. norak bgt dah");
            }
        });
    
    }
    return YES;
}
@end
