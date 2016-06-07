//
//  SetingsViewController.m
//  splitBanana
//
//  Created by Technical Staff on 11/27/15.
//  Copyright © 2015 EP. All rights reserved.
//

#import "SetingsViewController.h"
#import "WorkingExperience.h"
#import "EducationHistory.h"
#import "HobbyList.h"


@interface SetingsViewController ()
@property (strong, nonatomic) UITableView *tableView;

@end

NSDictionary *settingCategory;
NSArray *categorySetting;
NSMutableArray *tableDataSetting;
UITableViewCell *cellSetting;
UISlider *distanceSlider;
UILabel *distanceLabel;
UIImageView *imv;

NSString *urlSettingShare;
NSString *postSettingShare;

int sectionSettingTapped;

NSMutableURLRequest *requestSettingGetWork;
NSMutableURLRequest *requestSettingGetHobby;
NSMutableURLRequest *requestSettingGetEdu;
NSMutableURLRequest *requestSettingShare;

//UIButton *settingButton;
RLMResults *workRLMDBSetting;
RLMResults *eduRLMDBSetting;
RLMResults *hobbyRLMDBSetting;

@implementation SetingsViewController{
    WorkingExperience *w;
    EducationHistory *e;
    HobbyList *h;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    tableDataSetting = [[NSMutableArray alloc]init];
    [self setSwipe];
    
    //    [self deleteWorkinRLM];
    
    //    [self grabWork];
    [self grabWorkFromRLM];
    //    [self grabEdu];
    [self grabEduFromRLM];
    //    [self grabHobby];
    [self grabHobbiesFromRLM];
    
    UIView *viewSetting = [[UIView alloc]init];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    
    [viewSetting setBackgroundColor:[UIColor colorWithRed:34.0/255.0
                                                    green:121.0/255.0
                                                     blue:182.0/255.0
                                                    alpha:1]];
    
    [self setView:viewSetting];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.frame = CGRectMake(0, 20, self.view.frame.size.width,2);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:34.0/255.0
                                                     green:121.0/255.0
                                                      blue:182.0/255.0
                                                     alpha:1];
    //    self.tableView.backgroundColor = [UIColor greenColor];
    
    [viewSetting addSubview:self.tableView];
    tableDataSetting = [NSArray arrayWithObjects:@"Ani",@"Budi",@"Joko",@"Toni",@"Jobs", nil];
    
    settingCategory = @{@"" : @[@"Bear"],
                      @"Share Location" : @[@"Camel"],
                      @"Share Profile" : @[@"Camel"]};
    
    categorySetting = [NSArray arrayWithObjects:@"",@"Share Location",@"Share Profile",nil];

    [self.tableView reloadData];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [categorySetting count];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 30)];
    label.font = [UIFont fontWithName:@"Montserrat-Regular" size:28];
    [label setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1]];
    NSString *string =[categorySetting objectAtIndex:section];
    /* Section header is in 0th index... */
    [label setText:string];
//    NSLog(@"string : %@", string);
//    NSLog(@"category : %@", [categorySetting description]);
    
//    button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.titleLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:20];
//    button.titleLabel.textColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6];
//    //    button.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
//    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [button setTitle:string forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//    button.tag = section;
//    button.frame = CGRectMake(5.0, 0.0, view.frame.size.width, view.frame.size.height);
//    
//    [view addSubview:button];
    [view addSubview:label];
    [view setBackgroundColor:[UIColor clearColor]]; //your background color...
    return view;
}

-(void)buttonAction:(id)sender{
//    
//    UIButton *clickedButton = (UIButton*)sender;
//    NSLog(@"section : %li",(long)clickedButton.tag);
//    
//    switch (clickedButton.tag) {
//        case 4:{
//            WorkInputViewController *signup = [[WorkInputViewController alloc] initWithNibName:nil bundle:nil];
//            [self presentViewController:signup animated:YES completion:nil];
//        }
//            break;
//        case 5:{
//            EducationInputViewController *signup = [[EducationInputViewController alloc] initWithNibName:nil bundle:nil];
//            [self presentViewController:signup animated:YES completion:nil];
//        }
//        case 6:{
//            HobbiesInputViewController *signup = [[HobbiesInputViewController alloc] initWithNibName:nil bundle:nil];
//            [self presentViewController:signup animated:YES completion:nil];
//        }
//        default:
//            break;
//    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"reload ??");
    static NSString *simpleTableIdentifier= @"settingsTableItem";
    cellSetting = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    //
//    NSLog(@"width : %f",self.view.frame.size.width);
//    NSLog(@"height : %f",self.view.frame.size.height);
    
    if (cellSetting == nil) {
        cellSetting = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        NSLog(@"cell : ");
    }
    
    cellSetting.backgroundColor = [UIColor clearColor];
    cellSetting.textLabel.font = [UIFont fontWithName:@"Montserrat-Hairline" size:18];
    cellSetting.textLabel.textColor = [UIColor whiteColor];
    cellSetting.contentView.backgroundColor = [UIColor clearColor];
    
    switch (indexPath.section) {
        case 0:{
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, -10, tableView.frame.size.width, 35)];
            label.font = [UIFont fontWithName:@"Montserrat-Regular" size:30];
            [label setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1]];
            NSString *string =@"Settings";
            [label setText:string];

            label.textAlignment = NSTextAlignmentCenter;
            [cellSetting addSubview:label];
        }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:{
                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 2, tableView.frame.size.width - 80, 25)];
                    label.font = [UIFont fontWithName:@"Montserrat-Regular" size:18];
                    [label setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6]];
                    NSString *string =@"Distance";
                    [label setText:string];
//                    label.textAlignment = NSTextAlignmentCenter;

                    
                    distanceSlider = [[UISlider alloc]initWithFrame:CGRectMake(10, 35, tableView.frame.size.width - 20, 20)];
                    distanceSlider.minimumValue = 0;
                    distanceSlider.maximumValue = 100;
//                    [distanceSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
                    [distanceSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventAllEvents];

                    distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(tableView.frame.size.width - 60, 2, 50, 20)];
                    [distanceLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6]];
                    distanceLabel.textAlignment = NSTextAlignmentRight;
                    int a = (int)ceilf(distanceSlider.value);
                    [distanceLabel setText:[NSString stringWithFormat:@"%d",a]];
                    
                    [cellSetting addSubview:label];
                    [cellSetting addSubview:distanceLabel];
                    [cellSetting addSubview:distanceSlider];
                }
                    break;
                default:
                    break;
            }
            break;
        case 2:{
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, cellSetting.frame.size.height / 2 - 11, tableView.frame.size.width - 60, 20)];
                                label.font = [UIFont fontWithName:@"Montserrat-Regular" size:18];
            [label setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6]];
            imv = [[UIImageView alloc]initWithFrame:CGRectMake(tableView.frame.size.width - 40, cellSetting.frame.size.height / 2 - 10, 20, 20)];
            NSString *string;
            if (workRLMDBSetting.count > 0) {
                if (indexPath.row < workRLMDBSetting.count) {
//                    NSLog(@"edu : %ld", (long)indexPath.row);
//                    NSLog(@"education list :%@", [workRLMDBSetting description]);
                    WorkingExperience *wrk = [workRLMDBSetting objectAtIndex:indexPath.row];
                    string = wrk.companyName;
                    if (wrk.isShare) {
                        imv.image=[UIImage imageNamed:@"button-tick-on.png"];
                    }else if(!(wrk.isShare)){
                        imv.image=[UIImage imageNamed:@"button-tick-off.png"];
                    }
                }else {
                    if (eduRLMDBSetting.count > 0) {
                        if (indexPath.row < eduRLMDBSetting.count + workRLMDBSetting.count) {
//                            NSLog(@"edu : %ld", (long)indexPath.row);
//                            NSLog(@"education list :%@", [eduRLMDBSetting description]);
                            EducationHistory *edu = [eduRLMDBSetting objectAtIndex:indexPath.row - workRLMDBSetting.count];
                            string = edu.educationName;
                            if (edu.isShare) {
                                imv.image=[UIImage imageNamed:@"button-tick-on.png"];
                            }else if(!(edu.isShare)){
                                imv.image=[UIImage imageNamed:@"button-tick-off.png"];                            }
                        }else{
//                            NSLog(@"jumlah hobi : %ld", hobbyRLMDBSetting.count);
                            if (hobbyRLMDBSetting.count > 0) {
//                                NSLog(@"jumlah hobi : %ld", hobbyRLMDBSetting.count);
                                if (indexPath.row < hobbyRLMDBSetting.count + workRLMDBSetting.count + eduRLMDBSetting.count) {
//                                    NSLog(@"hobby : %ld", (long)indexPath.row);
//                                    NSLog(@"hobby list :%@", [hobbyRLMDBSetting description]);
                                    HobbyList *hby = [hobbyRLMDBSetting objectAtIndex:indexPath.row - workRLMDBSetting.count - eduRLMDBSetting.count];
                                    //        NSLog(@"chat object = %@",[ch description]);
                                    string = hby.hobbyName;
                                    if (hby.isShare) {
                                        imv.image=[UIImage imageNamed:@"button-tick-on.png"];
                                    }else if (!(hby.isShare)){
                                        imv.image=[UIImage imageNamed:@"button-tick-off.png"];
                                    }
//                                    NSLog(@"hobby : %@", hby.hobbyName);
                                }
                            }
                        }
                    }
                }
                [label setText:string];

                [cellSetting addSubview:label];
                [cellSetting addSubview:imv];
            }
            }
            break;
        default:
            break;
    }
    return cellSetting;
    
}

- (IBAction)sliderValueChanged:(id)sender{
    NSLog(@"float : %f",distanceSlider.value);
    int a = (int)ceilf(distanceSlider.value);
    NSLog(@"int : %d", a);
    [distanceLabel setText:[NSString stringWithFormat:@"%d",a]];
    NSLog(@"label : %@", distanceLabel.text );
}
//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [categorySetting objectAtIndex:section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"row = %ld", (long)indexPath.row);
//    NSLog(@"section = %ld", (long)indexPath.section);
    sectionSettingTapped = indexPath.section;
    NSString *shared;
    switch (indexPath.section) {
        case 2:
            
            if (workRLMDBSetting.count > 0) {
                if (indexPath.row < workRLMDBSetting.count) {
                    WorkingExperience *wrk = [workRLMDBSetting objectAtIndex:indexPath.row];
                    
                    if (wrk.isShare) {
                        shared = @"false";
                    }else {
                        shared = @"true";
                    }
                    urlSettingShare=[NSString stringWithFormat:@"http://103.23.22.6:9000/work/share"];
                    postSettingShare = [[NSString alloc]initWithString:[NSString stringWithFormat:@"share=%@&workId=%@", shared,wrk.companyID]];
//                    NSLog(@"url and post share : %@ & %@", urlSettingShare, postSettingShare);
                    
                    w = [[WorkingExperience alloc] init];
                    
                    w.companyID = wrk.companyID;
                    w.companyName = wrk.companyName;
                    w.companyLocation = wrk.companyLocation;
                    w.year = wrk.year;
                    w.isShare = !(wrk.isShare);
                    cellSetting.tag = 1;
                    [self shareList];
//                    NSLog(@"work : %ld", workRLMDBSetting.count);
                }else {
                    if (eduRLMDBSetting.count > 0) {
                        if (indexPath.row < eduRLMDBSetting.count + workRLMDBSetting.count) {
                            EducationHistory *edu = [eduRLMDBSetting objectAtIndex:indexPath.row - workRLMDBSetting.count];
                            
                            if (edu.isShare) {
                                shared = @"false";
                            }else shared = @"true";
                            
                            urlSettingShare=[NSString stringWithFormat:@"http://103.23.22.6:9000/education/share"];
                            postSettingShare = [[NSString alloc]initWithString:[NSString stringWithFormat:@"share=%@&educationId=%@", shared,edu.educationID]];
//                            NSLog(@"url and post share : %@ & %@", urlSettingShare, postSettingShare);
                            
                            e = [[EducationHistory alloc] init];
                            
                            e.educationID = edu.educationID;
                            e.educationLevel = edu.educationLevel;
                            e.educationName = edu.educationName;
                            e.educationLocation = edu.educationLocation;
                            e.year = edu.year;
                            e.isShare = !(edu.isShare);
                            cellSetting.tag = 2;
                            [self shareList];
//                            NSLog(@"edu : %ld", eduRLMDBSetting.count);
                        }else{
                            if (hobbyRLMDBSetting.count > 0) {
//                                NSLog(@"jumlah hobi : %ld", hobbyRLMDBSetting.count);
                                if (indexPath.row < hobbyRLMDBSetting.count + workRLMDBSetting.count + eduRLMDBSetting.count) {
                                    HobbyList *hby = [hobbyRLMDBSetting objectAtIndex:indexPath.row - workRLMDBSetting.count - eduRLMDBSetting.count];
                                    
                                    if (hby.isShare) {
                                        shared = @"false";
                                    }else shared = @"true";
                                    
                                    urlSettingShare=[NSString stringWithFormat:@"http://103.23.22.6:9000/hobby/share"];
                                    postSettingShare = [[NSString alloc]initWithString:[NSString stringWithFormat:@"share=%@&hobbyId=%@", shared,hby.hobbyID]];
//                                    NSLog(@"url and post share : %@ & %@", urlSettingShare, postSettingShare);
                                    
                                    h = [[HobbyList alloc]init];
                                    
                                    h.hobbyID = hby.hobbyID;
                                    h.hobbyName = hby.hobbyName;
                                    h.isShare = !(hby.isShare);
                                    cellSetting.tag = 3;
                                    [self shareList];
//                                    NSLog(@"hobi : %ld", hobbyRLMDBSetting.count);
                                }
                            }
                        }
                    }
                }
            }
            break;
            
        default:
            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSString *judulSection = [categorySetting objectAtIndex:section];
    NSArray *isiSection = [settingCategory objectForKey:judulSection];
    switch (section){
        case 0:{
            return 1;
        }
            break;
        case 1:{
            return 1;
        }
            break;
        case 2:{
            int a = (int)workRLMDBSetting.count + (int)eduRLMDBSetting.count + (int)hobbyRLMDBSetting.count;
            return a;
        }
            break;
        default:{
            return [isiSection count];
        }
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 40;
    }else return 44;
}

-(void)grabWork{
    NSString *urlOnline = [NSString stringWithFormat:
                           @"http://103.23.22.6:9000/work/get"];
    
    
    NSString *stringUrl =[urlOnline stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    requestSettingGetWork = [[NSMutableURLRequest alloc] initWithURL:
                      [NSURL URLWithString:stringUrl]];
    
    NSLog(@"test %@", requestSettingGetWork);
    
    [requestSettingGetWork setHTTPMethod:@"POST"];
    
    NSString *postData = [[NSString alloc]initWithString:[NSString stringWithFormat:@"user_id=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userID"]]];
    
    [requestSettingGetWork setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-type"];
    
    //                              [request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)[content length]]forHTTPHeaderField:@"Content-length"];
    
    [requestSettingGetWork setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error;
    
    NSURLResponse *response;
    
    //    NSData *urlData=[NSURLConnection sendSynchronousRequest:requestSettingGetWork returningResponse:&response error:&error];
    //
    //    NSDictionary *str =[NSJSONSerialization JSONObjectWithData:urlData options:kNilOptions error:&error];
    //    //            [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    //
    
    
    __block NSMutableData *fragmentData = [NSMutableData data];
    
    [[NSOperationQueue mainQueue] cancelAllOperations];
    
    
    [NSURLConnection sendAsynchronousRequest:requestSettingGetWork queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
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
                 
                 NSLog(@"=========================== WORK  ==========================");
                 
                 NSLog(@"str : %@", [str description] );
                 NSLog(@"status : %@, message : %@ ", [str objectForKey:@"status"], [str objectForKey:@"msg"]);
                 
                 
                 NSString *serverRplyLoginString = [[NSString alloc] initWithData:fragmentData/*responseData*/ encoding:NSASCIIStringEncoding];
                 
                 NSDictionary *dictobj=[NSJSONSerialization JSONObjectWithData:fragmentData/*responseData*/ options:kNilOptions error:&error];
                 
                 NSLog(@"Login Response Is :%@",serverRplyLoginString);
                 
                 NSLog(@"dictobj :%@",dictobj);
             }
             // if fragmentDatas length is not equal to server response's expectedContentLength
             // that means it is a chunked data and the other half of the data will be reloaded and `[fragmentData appendData:data];` will handle that
         }
     }];
    
    //    NSLog(@"str : %@", [str description] );
    //    NSLog(@"status : %@, message : %@ ", [str objectForKey:@"status"], [str objectForKey:@"msg"]);
    //
    
}

-(void)grabEdu{
    NSString *urlOnline = [NSString stringWithFormat:
                           @"http://103.23.22.6:9000/education/get"];
    
    NSString *stringUrl =[urlOnline stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    requestSettingGetEdu = [[NSMutableURLRequest alloc] initWithURL:
                     [NSURL URLWithString:stringUrl]];
    
    NSLog(@"test %@", requestSettingGetEdu);
    
    [requestSettingGetEdu setHTTPMethod:@"POST"];
    
    NSLog(@"user id : %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]);
    
    NSString *postData = [[NSString alloc]initWithString:[NSString stringWithFormat:@"user_id=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userID"]]];
    
    [requestSettingGetEdu setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-type"];
    
    //                              [request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)[content length]]forHTTPHeaderField:@"Content-length"];
    
    [requestSettingGetEdu setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error;
    
    NSURLResponse *response;
    
    //    NSData *urlData=[NSURLConnection sendSynchronousRequest:requestSettingGetEdu returningResponse:&response error:&error];
    //
    //    NSDictionary *str =[NSJSONSerialization JSONObjectWithData:urlData options:kNilOptions error:&error];
    //    //            [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    
    __block NSMutableData *fragmentData = [NSMutableData data];
    
    [[NSOperationQueue mainQueue] cancelAllOperations];
    
    
    [NSURLConnection sendAsynchronousRequest:requestSettingGetEdu queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
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
                 
                 NSLog(@"=========================== EDU  ==========================");
                 
                 
                 NSLog(@"str : %@", [str description] );
                 NSLog(@"status : %@, message : %@ ", [str objectForKey:@"status"], [str objectForKey:@"msg"]);
                 
                 
                 NSString *serverRplyLoginString = [[NSString alloc] initWithData:fragmentData/*responseData*/ encoding:NSASCIIStringEncoding];
                 
                 NSDictionary *dictobj=[NSJSONSerialization JSONObjectWithData:fragmentData/*responseData*/ options:kNilOptions error:&error];
                 
                 NSLog(@"Login Response Is :%@",serverRplyLoginString);
                 
                 NSLog(@"dictobj :%@",dictobj);
             }
             // if fragmentDatas length is not equal to server response's expectedContentLength
             // that means it is a chunked data and the other half of the data will be reloaded and `[fragmentData appendData:data];` will handle that
         }
     }];
    
    //
    //    NSLog(@"str : %@", [str description] );
    //    NSLog(@"status : %@, message : %@ ", [str objectForKey:@"status"], [str objectForKey:@"msg"]);
    //
    
}

-(void)grabHobby{
    NSString *urlOnline = [NSString stringWithFormat:
                           @"http://103.23.22.6:9000/hobby/get"];
    
    NSString *stringUrl =[urlOnline stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    requestSettingGetHobby = [[NSMutableURLRequest alloc] initWithURL:
                       [NSURL URLWithString:stringUrl]];
    
    NSLog(@"test %@", requestSettingGetHobby);
    
    [requestSettingGetHobby setHTTPMethod:@"POST"];
    
    NSString *postData = [[NSString alloc]initWithString:[NSString stringWithFormat:@"user_id=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userID"]]];
    
    [requestSettingGetHobby setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-type"];
    
    //                              [request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)[content length]]forHTTPHeaderField:@"Content-length"];
    
    [requestSettingGetHobby setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error;
    
    NSURLResponse *response;
    
    //    NSData *urlData=[NSURLConnection sendSynchronousRequest:requestSettingGetHobby returningResponse:&response error:&error];
    //
    //    NSDictionary *str =[NSJSONSerialization JSONObjectWithData:urlData options:kNilOptions error:&error];
    //    //            [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    //
    
    
    __block NSMutableData *fragmentData = [NSMutableData data];
    
    [[NSOperationQueue mainQueue] cancelAllOperations];
    
    
    [NSURLConnection sendAsynchronousRequest:requestSettingGetHobby queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
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
                 
                 NSLog(@"=========================== HOBBY  ==========================");
                 
                 
                 NSLog(@"str : %@", [str description] );
                 NSLog(@"status : %@, message : %@ ", [str objectForKey:@"status"], [str objectForKey:@"msg"]);
                 
                 
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

- (void) grabWorkFromRLM{
    workRLMDBSetting = [[WorkingExperience allObjects] sortedResultsUsingProperty:@"year" ascending:YES];
}

- (void) grabEduFromRLM{
    eduRLMDBSetting = [[EducationHistory allObjects] sortedResultsUsingProperty:@"year" ascending:YES];
}

- (void) grabHobbiesFromRLM{
    hobbyRLMDBSetting = [HobbyList allObjects];
}

- (void) shareList{
    
    NSString *stringUrl =[urlSettingShare stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    requestSettingShare = [[NSMutableURLRequest alloc] initWithURL:
                    [NSURL URLWithString:stringUrl]];
    
    [requestSettingShare setHTTPMethod:@"POST"];
    
    [requestSettingShare setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-type"];
    
    [requestSettingShare setHTTPBody:[postSettingShare dataUsingEncoding:NSUTF8StringEncoding]];
    
    __block NSMutableData *fragmentData = [NSMutableData data];
    
    [[NSOperationQueue mainQueue] cancelAllOperations];
    
    
    [NSURLConnection sendAsynchronousRequest:requestSettingShare queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
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
             if ([fragmentData length] == [response expectedContentLength])
             {
                 NSDictionary *str =[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                 
//                 NSLog(@"=========================== share  ==========================");
                 
                 
//                 NSLog(@"str : %@", [str description] );
//                 NSLog(@"status : %@, message : %@ ", [str objectForKey:@"status"], [str objectForKey:@"msg"]);
//                 [self.tableView reloadData];

                 NSDictionary *detailObj = [str objectForKey:@"d"];
                 
                 if ([[str objectForKey:@"status"] intValue] == 1) {
                     RLMRealm *realm = [RLMRealm defaultRealm];
                     [realm beginWriteTransaction];
                     switch (cellSetting.tag) {
                         case 1:
                             [realm addOrUpdateObject:w];
                             break;
                         case 2:
                             [realm addOrUpdateObject:e];
                             break;
                         case 3:
                             [realm addOrUpdateObject:h];
                             break;
                         default:
                             break;
                     }
                     [realm commitWriteTransaction];
                 }
                 
                 NSString *serverRplyLoginString = [[NSString alloc] initWithData:fragmentData/*responseData*/ encoding:NSASCIIStringEncoding];
                 
                 NSDictionary *dictobj=[NSJSONSerialization JSONObjectWithData:fragmentData/*responseData*/ options:kNilOptions error:&error];
                 
//                 NSLog(@"Login Response Is :%@",serverRplyLoginString);
                 
//                 NSLog(@"dictobj :%@",dictobj);
                 
                 [self.tableView reloadData];
             }
         }
     }];
    
}

- (void)setSwipe
{
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init] ];
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(-100, 0, 30, 30)];
    img.image =[UIImage imageNamed:@"zonnexions-logo.png"];
    [img setContentMode:UIViewContentModeScaleAspectFit];
    self.navigationItem.titleView = img;
    
    
    SWRevealViewController *revealController = [self revealViewController];
    
    [self.navigationController.navigationBar addGestureRecognizer:revealController.panGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"button-burger-circle.png"]
                                                                         style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
}


- (void) deleteWorkinRLM{
    RLMRealm *realm = [RLMRealm defaultRealm];
    NSLog(@"deleting now");
    [realm beginWriteTransaction];
    [realm deleteAllObjects];
    [realm commitWriteTransaction];
}

@end
