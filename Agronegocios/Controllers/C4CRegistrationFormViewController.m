//
//  C4CRegistrationFormViewController.m
//  Agronegocios
//
//  Created by David Almeciga on 11/2/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4CRegistrationFormViewController.h"

@interface C4CRegistrationFormViewController ()

@end

@implementation C4CRegistrationFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super viewDidLoad];
    self.registrationForm = [[C4CRegistrationForm alloc] init];
    self.formController.form = self.registrationForm;
    
    UIColor *bgColor = [UIColor colorWithRed:1 green:0.91 blue:0.74 alpha:1];
    self.tableView.backgroundView.backgroundColor = bgColor;
    self.tableView.backgroundColor = bgColor;
    self.view.backgroundColor = bgColor;
    
    self.title = @"Regístrate";
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = self.tableView.backgroundColor = [UIColor colorWithRed:1 green:0.91 blue:0.74 alpha:1];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}


- (void)submitRegistrationForm:(UITableViewCell<FXFormFieldCell> *)cell {
    
    self.registrationForm.scenario = @"register";
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:hud];
    hud.detailsLabelText = @"¡Registrándote en Agronegocios!";
    hud.color = [UIColor colorWithRed:0.4 green:0.6 blue:0 alpha:0.9];
    
    if (![self.registrationForm validate]) {
        [self showErrors];
    } else {
        [hud show:YES];
        
        Registration *registration = [Registration new];
        registration.name = self.registrationForm.name;
        registration.identification = self.registrationForm.identification;
        registration.phone = self.registrationForm.phone;
        registration.address = self.registrationForm.address;
        registration.email = self.registrationForm.email;
        registration.password = self.registrationForm.password;
        registration.repeatPassword = self.registrationForm.repeatPassword;
        
        [[RKObjectManager sharedManager] postObject:registration
                                               path:REGISTER_PATH
                                         parameters:nil
                                            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                hud.detailsLabelText = @"¡Te has registrado en Agronegocios!";
                                                hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
                                                hud.mode = MBProgressHUDModeCustomView;
                                                [self performSelector:@selector(returnToLogin:) withObject:hud afterDelay:1.5];
                                                
                                            }
                                            failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                C4CShowAlertWithError(error.localizedDescription);
                                                [hud hide:YES];
                                            }];
    }
}

-(void)returnToLogin:(MBProgressHUD *) hud {
    [hud hide:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)showErrors {
    NSMutableString *message = [NSMutableString string];
    [self.registrationForm.errors enumerateKeysAndObjectsUsingBlock:^(NSString *attribute, NSArray *errors, BOOL *stop) {
        NSDictionary *field = [self.registrationForm getField:attribute];
        for(NSString *error in errors) {
            [message appendFormat:@"-%@ %@\n", [field objectForKey:@"title"], error];
        };
    }];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}


static void C4CShowAlertWithError(NSString *error)
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:error
                                                   delegate:nil
                                          cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

@end
