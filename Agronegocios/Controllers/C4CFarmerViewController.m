//
//  C4CFarmerViewController.m
//  Agronegocios
//
//  Created by David Almeciga on 11/27/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4CFarmerViewController.h"

@interface C4CFarmerViewController ()

@end

@implementation C4CFarmerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.tintColor = [UIColor colorWithRed:0 green:0.6 blue:0.8 alpha:1];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:12.0], NSFontAttributeName, nil] forState:UIControlStateNormal];
}

@end
