//
//  ProfileViewController.m
//  Zonnexions
//
//  Created by Eka Praditya GK on 12/22/15.
//  Copyright © 2015 EP. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

NSString *friendName1;
People *currentUser1;
LGChatController *chatController1;


@implementation ProfileViewController

- (IBAction)chatFriend:(id)sender {
    
    NSLog(@"sender %@", sender);
    //chatController1.opponentImage = [UIImage imageNamed:@"YourImageName"];
    chatController1.title = self.userName;
    chatController1.delegate = self;
    
    NSLog(@"user key %@", self.userKey);
    RLMResults *chatResult = [Chat objectsWhere:[NSString stringWithFormat:@"chatWith = '%@'", self.userKey]];
    
    
    NSMutableArray<LGChatMessage *> *messages = [[NSMutableArray alloc] init];
    for (int i =0; i < [chatResult count]; i++) {
        Chat *ch = [chatResult objectAtIndex:i];
        //        NSLog(@"chat object = %@",[ch description]);
        LGChatMessage *message;
        if (ch.is_me) {
            //            NSLog(@"is this me??? %i",ch.is_me);
            message = [[LGChatMessage alloc] initWithContent:ch.message sentByString:[LGChatMessage SentByUserString]];
        }else{
            //                        NSLog(@"is this me? %i",ch.is_me);
            message= [[LGChatMessage alloc] initWithContent:ch.message sentByString:[LGChatMessage SentByOpponentString]];
        }
        [messages addObject:message];
    }
    [chatController1 setMessages:messages];
    [self.navigationController pushViewController:chatController1 animated:YES];
    

}


- (void)chatController:(LGChatController *)chatController didAddNewMessage:(LGChatMessage *)message{
    NSLog(@"Did Add Message: %@", message.content);
    
}

- (BOOL)shouldChatController:(LGChatController *)chatController addMessage:(LGChatMessage *)message{
    /**
     *Use this space to prevent sending a message, or to alter a message.
     *For example, you might want to hold a message until its successfully uploaded to a server.
     **/
    message.sentByString = [LGChatMessage SentByUserString];
    NSMutableDictionary *chatConfig = [[NSMutableDictionary alloc]init];
    [chatConfig setObject:self.userKey forKey:@"target"];
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


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.namaUser.text = self.userName;
    self.alamatUser.text = self.userKey;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveChat:)
                                                 name:@"chat message"
                                               object:nil];
    
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"view did appear");
    chatController1 = NULL;
    chatController1 = [LGChatController new];
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
        if ([sender isEqualToString:self.userKey]) {
            
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
            [chatController1 addNewMessage:helloWorld];
            NSLog(@"saving to db");
        }
        
    }
    
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
