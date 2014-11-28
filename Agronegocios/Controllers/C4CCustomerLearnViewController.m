//
//  C4CCustomerLearnViewController.m
//  Agronegocios
//
//  Created by David Almeciga on 11/27/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4CCustomerLearnViewController.h"

@interface C4CCustomerLearnViewController ()

@end

@implementation C4CCustomerLearnViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:CUSTOMER_LEARN_URL]]];
    [_webView.scrollView setZoomScale:1.8];
}

@end
