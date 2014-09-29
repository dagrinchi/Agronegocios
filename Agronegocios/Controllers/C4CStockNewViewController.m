//
//  C4CStockNewViewController.m
//  Agronegocios
//
//  Created by David Almeciga on 9/28/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4CStockNewViewController.h"
#import "C4CStockForm.h"

@interface C4CStockNewViewController ()

@end

@implementation C4CStockNewViewController

- (void)awakeFromNib {
    self.formController.form = [[C4CStockForm alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
