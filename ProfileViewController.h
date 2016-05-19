//
//  ProfileViewController.h
//  Zonnexions
//
//  Created by Eka Praditya GK on 12/22/15.
//  Copyright © 2015 EP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "People.h"
#import "Chat.h"
#import "ViewController.h"

@interface ProfileViewController : ViewController
@property (weak, nonatomic) IBOutlet UILabel *namaUser;
@property (weak, nonatomic) IBOutlet UILabel *alamatUser;

@property NSString *userName;
@property NSString *userKey;

@end
