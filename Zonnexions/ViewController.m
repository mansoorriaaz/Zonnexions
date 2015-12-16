//
//  ViewController.m
//  Zonnexions
//
//  Created by Technical Staff on 11/25/15.
//  Copyright © 2015 EP. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end


@implementation ViewController
{

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.appd = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [self.appd.socket on:@"hello" callback:^(NSArray * data, SocketAckEmitter * ack) {
        NSLog(@"ths is an response from server =  %@",data);
    }];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
