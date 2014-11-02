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
    self.formController.form = [[C4CRegistrationForm alloc] init];
    
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
    
    C4CRegistrationForm *form = cell.field.form;
    SAMHUDView *hud = [[SAMHUDView alloc] initWithTitle:@"Enviando" loading:YES];
    
    if (form.name != nil && form.identification != nil && form.phone != nil && form.address != nil && form.email != nil && form.password != nil && form.repeatPassword != nil) {
        
        if ([form.password isEqualToString:form.repeatPassword]) {
            
            [hud show];
            
            Registration *registration = [Registration new];
            registration.name = form.name;
            registration.identification = form.identification;
            registration.phone = form.phone;
            registration.address = form.address;
            registration.email = form.email;
            registration.password = form.password;
            registration.repeatPassword = form.repeatPassword;
            
            [[RKObjectManager sharedManager] postObject:registration
                                                   path:REGISTER_PATH
                                             parameters:nil
                                                success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                    hud.textLabel.text = @"Listo!";
                                                    hud.loading = FALSE;
                                                    hud.successful = TRUE;
                                                    [self performSelector:@selector(returnToLogin:) withObject:hud afterDelay:1.5];
                                                    
                                                }
                                                failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                    RKErrorMessage *errorMessage =  [[error.userInfo objectForKey:RKObjectMapperErrorObjectsKey] firstObject];
                                                    C4CShowAlertWithError(errorMessage.errorMessage);
                                                    [hud dismiss];
                                                    
                                                }];
            
            
        } else {
            [hud dismiss];
            C4CShowAlertWithError(@"Las claves no coinciden");
        }
        
    } else {
        [hud dismiss];
        C4CShowAlertWithError(@"Todos los campos son obligatorios");
    }
    
}

-(void)returnToLogin:(SAMHUDView *) hud {
    [hud dismiss];
    [self.navigationController popViewControllerAnimated:YES];
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
