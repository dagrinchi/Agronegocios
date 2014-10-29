//
//  C4CRootFormViewController.m
//  Agronegocios
//
//  Created by David Almeciga on 9/28/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4CRootFormViewController.h"

@implementation C4CRootFormViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.formController.form = [[C4CRootForm alloc] init];
    
    UIColor *bgColor = [UIColor colorWithRed:1 green:0.91 blue:0.74 alpha:1];
    self.tableView.backgroundView.backgroundColor = bgColor;
    self.tableView.backgroundColor = bgColor;
    self.view.backgroundColor = bgColor;
    
    self.title = @"Iniciar sesión";
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

- (void)submitLoginForm:(UITableViewCell<FXFormFieldCell> *)cell
{
    //C4CLoginForm *form = cell.field.form;
    [[[UIAlertView alloc] initWithTitle:@"Login Form Submitted" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
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


/*
- (void)submitLoginForm:(UITableViewCell<FXFormFieldCell> *)cell {
    C4CLoginForm *form = cell.field.form;
    NSString *response;
    SAMHUDView *hud = [[SAMHUDView alloc] initWithTitle:@"Enviando" loading:YES];
    [hud show];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    if (form.identification != nil && form.password != nil) {
        [parameters setValue:GRANT_TYPE forKey:@"grant_type"];
        [parameters setValue:form.identification forKey:@"username"];
        [parameters setValue:form.password forKey:@"password"];
        
        response = [self login:parameters :hud];
        
        
    } else {
        hud.textLabel.text = @"Revise todos los campos!";
        hud.loading = FALSE;
        hud.successful = FALSE;
        [self performSelector:@selector(returnToLogin:) withObject:hud afterDelay:1];
    }
}

- (void)submitRegistrationForm:(UITableViewCell<FXFormFieldCell> *)cell {
    C4CRegistrationForm *form = cell.field.form;
    SAMHUDView *hud = [[SAMHUDView alloc] initWithTitle:@"Enviando registro" loading:YES];
    [hud show];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    if (form.name != nil && form.identification != nil && form.phone != nil && form.address != nil && form.email != nil && form.password != nil && form.repeatPassword != nil) {
        
        if ([form.password isEqualToString:form.repeatPassword]) {
            
            [parameters setValue:form.name forKey:@"Name"];
            [parameters setValue:form.identification forKey:@"Identification"];
            [parameters setValue:form.phone forKey:@"Phone"];
            [parameters setValue:form.address forKey:@"Address"];
            [parameters setValue:form.email forKey:@"Email"];
            [parameters setValue:form.password forKey:@"Password"];
            [parameters setValue:form.repeatPassword forKey:@"ConfirmPassword"];

            [self registration:parameters :hud];
        } else {
            hud.textLabel.text = @"Contraseñas no coinciden!";
            hud.loading = FALSE;
            hud.successful = FALSE;
            [self performSelector:@selector(returnToLogin:) withObject:hud afterDelay:1];
        }

    } else {
        hud.textLabel.text = @"Revise todos los campos!";
        hud.loading = FALSE;
        hud.successful = FALSE;
        [self performSelector:@selector(returnToLogin:) withObject:hud afterDelay:1];
    }
    
}

// REQUIRES AFNETWORKING 2

-(NSString *) login:(NSMutableDictionary *)parameters :(SAMHUDView *)hud {
    
    __block NSString * _result;
    
    AFHTTPRequestOperationManager *afmanager = [AFHTTPRequestOperationManager manager];
    afmanager.responseSerializer = [C4CJSONResponseSerializerWithData serializer];
    
    [afmanager
     POST: TOKEN_URL
     parameters: parameters
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
         _result = responseObject;
         NSLog(@"Success: %@", responseObject);
         
         hud.textLabel.text = @"Listo!";
         hud.loading = FALSE;
         hud.successful = TRUE;
         [self performSelector:@selector(goApp:) withObject:hud afterDelay:1];
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         id json = error.userInfo[JSONResponseSerializerWithDataKey];
         NSLog(@"Error %@", json);
         
         _result = json;
         
         hud.textLabel.text = json[@"error_description"];
         hud.loading = FALSE;
         hud.successful = FALSE;
         [self performSelector:@selector(returnToLogin:) withObject:hud afterDelay:1];
     }];
    
    return _result;
}

-(void) registration:(NSMutableDictionary *)parameters :(SAMHUDView *)hud {
    
    AFHTTPRequestOperationManager *afmanager = [AFHTTPRequestOperationManager manager];
    afmanager.requestSerializer = [AFJSONRequestSerializer serializer];
    afmanager.responseSerializer = [C4CJSONResponseSerializerWithData serializer];
    
    [afmanager
     POST: REGISTER_URL
     parameters: parameters
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         hud.textLabel.text = @"Listo!";
         hud.loading = FALSE;
         hud.successful = TRUE;
         [self performSelector:@selector(returnToLogin:) withObject:hud afterDelay:1];
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         id json = error.userInfo[JSONResponseSerializerWithDataKey];
         NSLog(@"Error %@", json);
         
         hud.textLabel.text = json[@"Message"];
         hud.loading = FALSE;
         hud.successful = FALSE;
         [self performSelector:@selector(returnToLogin:) withObject:hud afterDelay:1];
     }];

}

-(void) goApp:(SAMHUDView *)hud {
    [hud dismiss];
    C4CWhoamiTableViewController *whoami = [[C4CWhoamiTableViewController alloc] init];
    [self.navigationController pushViewController:whoami animated:TRUE];
}

-(void) returnToLogin:(SAMHUDView *)hud {
    [hud dismiss];
//    [self.navigationController popToRootViewControllerAnimated:TRUE];
}
*/
@end
