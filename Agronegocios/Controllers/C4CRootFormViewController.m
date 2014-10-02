//
//  C4CRootFormViewController.m
//  Agronegocios
//
//  Created by David Almeciga on 9/28/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4CRootFormViewController.h"
#import "C4CRootForm.h"
#import "C4CRegistrationForm.h"
#import "C4CLoginForm.h"
#import "C4CWhoamiTableViewController.h"

@implementation C4CRootFormViewController

- (void)awakeFromNib {
    self.formController.form = [[C4CRootForm alloc] init];
}

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

@end
