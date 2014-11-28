//
//  C4CCustomerViewController.m
//  Agronegocios
//
//  Created by David Almeciga on 11/27/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4CCustomerViewController.h"

@interface C4CCustomerViewController ()

@end

@implementation C4CCustomerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.tintColor = [UIColor colorWithRed:1 green:0.27 blue:0.27 alpha:1];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:12.0], NSFontAttributeName, nil] forState:UIControlStateNormal];
}

@end
