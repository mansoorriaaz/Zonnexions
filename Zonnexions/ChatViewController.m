//
//  ChatViewController.m
//  Zonnexions
//
//  Created by Eka Praditya GK on 12/7/15.
//  Copyright © 2015 EP. All rights reserved.
//

#import "ChatViewController.h"
#import "AppDelegate.h"


//#import <Socket_IO_Client_Swift/Socket_IO_Client_Swift-Swift.h>

@interface ChatViewController () <LGChatControllerDelegate>

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setSwipe];
    UIView *viewSetting = [[UIView alloc]init];
    //[viewSetting setBackgroundColor:[UIColor yellowColor]];
    //[self setView:viewSetting];
}

- (void)viewDidAppear:(BOOL)animated
{
    
    NSLog(@"test");
    [self launchChatController];
    
}

- (void)setSwipe
{
    self.title = NSLocalizedString(@"Chat", nil);
    
    SWRevealViewController *revealController = [self revealViewController];
    
    [self.navigationController.navigationBar addGestureRecognizer:revealController.panGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"]
                                                                         style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
}

#pragma mark - Launch Chat Controller

- (void)launchChatController
{
    LGChatController *chatController = [LGChatController new];
    chatController.opponentImage = [UIImage imageNamed:@"<#YourImageName#>"];
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
}

- (BOOL)shouldChatController:(LGChatController *)chatController addMessage:(LGChatMessage *)message
{
    /*
     Use this space to prevent sending a message, or to alter a message.  For example, you might want to hold a message until its successfully uploaded to a server.
     */
    NSLog(@"tap? ");
    message.sentByString = arc4random_uniform(2) == 0 ? [LGChatMessage SentByOpponentString] : [LGChatMessage SentByUserString];
    
    return NO;
}



@end
