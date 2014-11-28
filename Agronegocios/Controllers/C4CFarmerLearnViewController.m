//
//  C4CFarmerLearnViewController.m
//  Agronegocios
//
//  Created by David Almeciga on 11/27/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4CFarmerLearnViewController.h"

@interface C4CFarmerLearnViewController ()

@end

@implementation C4CFarmerLearnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:FARMER_LEARN_URL]]];
    [_webView.scrollView setZoomScale:1.8];

}

@end
