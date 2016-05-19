//
//  ProfilSettingViewController.m
//  Zonnexions
//
//  Created by Eka Praditya GK on 1/18/16.
//  Copyright © 2016 EP. All rights reserved.
//

#import "ProfilSettingViewController.h"

@interface ProfilSettingViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageViewProfile;

@end

@implementation ProfilSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"1 :%f", _imageViewProfile.frame.size.height);
    NSLog(@"2 :%f", _imageViewProfile.bounds.size.height);
    
//    _imageViewProfile.layer.cornerRadius = _imageViewProfile.frame.size.height / 2;
//    _imageViewProfile.clipsToBounds = YES;
//    self.imageViewProfile.layer.borderWidth = 1;
    
    _imageViewProfile.backgroundColor = [UIColor redColor];
//    self.imageViewProfile.layer.backgroundColor = (__bridge CGColorRef _Nullable)([UIColor brownColor]);
//    self.imageViewProfile.layer.masksToBounds = YES;
    // Do any additional setup after loading the view from its nib.
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
