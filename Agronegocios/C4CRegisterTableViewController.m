//
//  C4CRegisterTableViewController.m
//  Agronegocios
//
//  Created by David Almeciga on 9/28/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4CRegisterTableViewController.h"

@interface C4CRegisterTableViewController ()

@end

@implementation C4CRegisterTableViewController

@synthesize nameTxt;
@synthesize phoneTxt;
@synthesize addressTxt;
@synthesize emailTxt;
@synthesize passwordTxt;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

// REQUIRES AFNETWORKING 2
/*
- (IBAction)saveBtn:(id)sender {
    
    SAMHUDView *hud = [[SAMHUDView alloc] initWithTitle:@"Enviando registro" loading:YES];
    [hud show];
    
    NSDictionary *parameters = @{ @"Name" : nameTxt.text,
                                  @"Phone" : phoneTxt.text,
                                  @"Address" : addressTxt.text,
                                  @"Email" : emailTxt.text,
                                  @"Password" : passwordTxt.text,
                                  @"ConfirmPassword" : passwordTxt.text };

    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    
//    [requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Accept"];
    
    AFHTTPRequestOperationManager *afmanager = [AFHTTPRequestOperationManager manager];
    afmanager.requestSerializer = requestSerializer;
    afmanager.responseSerializer = [C4CJSONResponseSerializerWithData serializer];
    
    [afmanager
        POST: REGISTER_URL
        parameters: parameters
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
            hud.textLabel.text = @"Listo!";
            hud.loading = FALSE;
            hud.successful = TRUE;
            [self performSelector:@selector(returnToLogin:) withObject:hud afterDelay:1.5];
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            id json = error.userInfo[JSONResponseSerializerWithDataKey];
            hud.textLabel.text = json[@"Message"];
            hud.loading = FALSE;
            hud.successful = FALSE;
            [self performSelector:@selector(returnToLogin:) withObject:hud afterDelay:2];
        }
     ];
    
}

-(void) returnToLogin:(SAMHUDView *)hud {
    [hud dismiss];
}*/


#pragma mark - Table view data source


/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
