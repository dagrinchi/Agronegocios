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
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Atras" style:UIBarButtonItemStylePlain target:nil action:nil];
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
    C4CLoginForm *form = cell.field.form;
    SAMHUDView *hud = [[SAMHUDView alloc] initWithTitle:@"Enviando" loading:YES];
    
    if (form.identification != nil && form.password != nil) {
        [hud show];
        
        Login *login = [Login new];
        login.grantType = GRANT_TYPE;
        login.username = form.identification;
        login.password = form.password;
        
        [[RKObjectManager sharedManager] postObject:login
                                               path:TOKEN_PATH
                                         parameters:nil
                                            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                hud.textLabel.text = @"Listo!";
                                                hud.loading = FALSE;
                                                hud.successful = TRUE;
                                                [self performSelector:@selector(goApp:) withObject:hud afterDelay:1.5];
                                            }
                                            failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                RKErrorMessage *errorMessage =  [[error.userInfo objectForKey:RKObjectMapperErrorObjectsKey] firstObject];
                                                C4CShowAlertWithError(errorMessage.errorMessage);
                                                [hud dismiss];                                                
                                            }];
        
    } else {
        C4CShowAlertWithError(@"Digita tu usuario y clave");
    }
}

-(void) goApp:(SAMHUDView *)hud {
    [hud dismiss];
    [self.navigationController pushViewController:[[C4CWhoamiTableViewController alloc] init] animated:TRUE];
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
