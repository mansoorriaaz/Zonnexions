//
//  AppSettingViewController.m
//  Zonnexions
//
//  Created by Eka Praditya GK on 12/22/15.
//  Copyright © 2015 EP. All rights reserved.
//

#import "AppSettingViewController.h"

@interface AppSettingViewController ()
- (IBAction)sliderChanged:(id)sender;
@property (weak, nonatomic) IBOutlet UISlider *mySlider;
- (IBAction)sharingLocation:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *shareLoc;

@end

@implementation AppSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"1");
    NSLog(@"is shared ? %d", self.appd.isShared);
    if (self.appd.limitDistance) {
        self.mySlider.value = self.appd.limitDistance / 1000;
        self.distance.text = [NSString stringWithFormat:@"%d", (int)self.mySlider.value];
        NSLog(@"2");
    }
    NSLog(@"3");
    if (self.appd.isShared == true) {
        NSLog(@"5");
        [self.shareLoc isOn];
    }else{
        [self.shareLoc setOn:false];
        NSLog(@"false");
    }
    [self setSwipe];
    [self addSlider];
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
    
    SWRevealViewController *revealController = [self revealViewController];
    
    [self.navigationController.navigationBar addGestureRecognizer:revealController.panGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"button-burger-circle.png"]
                                                                         style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
}


-(void)addSlider{
    //[self.view addSubview:_mySlider];
    _mySlider.minimumValue = 1;
    _mySlider.maximumValue = 100;
    _mySlider.continuous = NO;
    
    //[_mySlider addTarget:self action:@selector(sliderChanged:)
      // forControlEvents:UIControlEventValueChanged];
}

- (IBAction)sliderChanged:(id)sender {
    self.distance.text = [NSString stringWithFormat:@"%d", (int)self.mySlider.value];
    self.appd.limitDistance = (int)self.mySlider.value * 1000;
}
- (IBAction)sharingLocation:(id)sender {
    if ([self.shareLoc isOn]) {
        self.appd.isShared = true;
    }else{
        self.appd.isShared = false;
        NSLog(@"isshared ?? %d", self.appd.isShared);
    }
}
@end
