//
//  UnderlinedTextField.m
//  Zonnexions
//
//  Created by Eka Praditya GK on 5/26/16.
//  Copyright © 2016 EP. All rights reserved.
//

#import "UnderlinedTextField.h"

@implementation UnderlinedTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)drawRect:(CGRect)rect{
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, self.frame.size.height - 1, self.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6].CGColor;
    [self.layer addSublayer:bottomBorder];
}

@end
