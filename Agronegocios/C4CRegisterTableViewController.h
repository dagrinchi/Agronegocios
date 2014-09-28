//
//  C4CRegisterTableViewController.h
//  Agronegocios
//
//  Created by David Almeciga on 9/28/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface C4CRegisterTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTxt;

@property (weak, nonatomic) IBOutlet UITextField *phoneTxt;

@property (weak, nonatomic) IBOutlet UITextField *addressTxt;

@property (weak, nonatomic) IBOutlet UITextField *emailTxt;

@property (weak, nonatomic) IBOutlet UITextField *passwordTxt;

@end
