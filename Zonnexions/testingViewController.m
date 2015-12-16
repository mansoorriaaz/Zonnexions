//
//  testingViewController.m
//  Zonnexions
//
//  Created by Eka Praditya GK on 12/13/15.
//  Copyright © 2015 EP. All rights reserved.
//

#import "testingViewController.h"

@interface testingViewController ()

@end

@implementation testingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.appd = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    [self.appd.socket on:@"chat message" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSLog(@"from chat %@", data);
    }];

    [self funcForThought];
//    [appdtest.socket emit:@"find friend" withItems:[]];
//    [appdtest.socket emit:@"find friend" withItems:dict];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)funcForThought
{
    NSLog(@"func");
    //Beda NSDictionary dengan MutabaleDictarny yaitu yang mutable bisa di kelola(hapus, tambah,edit) yang lawanya ga bisa.
    NSMutableDictionary *json = [[NSMutableDictionary alloc]init];
    [json setObject:@"mansoorcool.cool@gmail.com" forKey:@"requester"];
    [json setObject:[NSNumber numberWithDouble:0] forKey:@"lat"];
    [json setObject:[NSNumber numberWithDouble:0] forKey:@"long"];
    /**
     Format yang di atas
     json { requester : "mansoorcool.cool@gmail.com",lat : 0,long : 0 }
     */
    [self.appd.socket on:@"chat message" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSLog(@"from func = %@", data);
    }];
    
    //Misal yang lebih complex(Misalkan ada object lagi dalamnya.. )
    NSMutableDictionary *geo = [[NSMutableDictionary alloc]init];
    [geo setObject:[NSNumber numberWithDouble:0] forKey:@"long"];
    [geo setObject:[NSNumber numberWithDouble:0] forKey:@"lat"];
    [json setObject:geo forKey:@"geo"];
    
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
    
    [self.appd.socket emit:@"find friend" withItems:[NSArray arrayWithObject:json]];
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
