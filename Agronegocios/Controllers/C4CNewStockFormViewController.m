//
//  C4CNewStockFormViewController.m
//  Agronegocios
//
//  Created by David Almeciga on 11/2/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4CNewStockFormViewController.h"

@interface C4CNewStockFormViewController ()

@property (assign, nonatomic) NSInteger locationRequestID;

@end

@implementation C4CNewStockFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:hud];
    hud.detailsLabelText = @"¡Preparando productos para la placita!";
    hud.color = [UIColor colorWithRed:0 green:0.6 blue:0.8 alpha:0.9];
    [hud show:YES];
    
    self.stockForm = [[C4CStockForm alloc] init];
    [self startLocationRequest:^(CLLocation *location, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
        if (status == INTULocationStatusSuccess) {
            self.location = location;
            [self loadAddressData:[NSString stringWithFormat:@"%@,%@", [[NSNumber numberWithDouble:location.coordinate.latitude] stringValue], [[NSNumber numberWithDouble:location.coordinate.longitude] stringValue]]
                                 :^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                     self.geoCodes = [mappingResult array];
                                     [hud hide:YES];
                                 }];
        }
        else if (status == INTULocationStatusTimedOut) {
            C4CShowAlertWithError(@"Tiempo agotado para la solicitud de localización.");
            [hud hide:YES];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else {
            if (status == INTULocationStatusServicesNotDetermined) {
                C4CShowAlertWithError(@"En los ajustes, están apagados los servicios de localización para esta aplicación.");
            } else if (status == INTULocationStatusServicesDenied) {
                C4CShowAlertWithError(@"En los ajustes, está prohibido el uso de los servicios de localización para esta aplicación.");
            } else if (status == INTULocationStatusServicesRestricted) {
                C4CShowAlertWithError(@"En los ajustes, están las restricciones en el uso de privacidad con el uso de la localización para esta aplicación.");
            } else if (status == INTULocationStatusServicesDisabled) {
                C4CShowAlertWithError(@"En los ajustes, están apagados los servicios de localización para todas las aplicaciones de este dispositivo.");
            } else {
                C4CShowAlertWithError(@"Se presenta un error desconocido, reintente más tarde.");
            }
            [hud hide:YES];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
        self.locationRequestID = NSNotFound;
    }];
    
    self.formController.form = self.stockForm;
    
    UIColor *bgColor = [UIColor colorWithRed:1 green:0.91 blue:0.74 alpha:1];
    self.tableView.backgroundView.backgroundColor = bgColor;
    self.tableView.backgroundColor = bgColor;
    self.view.backgroundColor = bgColor;
    
    self.title = @"Nuevo Inventario";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Atras" style:UIBarButtonItemStylePlain target:nil action:nil];
    
}

- (NSString *)accessToken
{
    NSError *error = nil;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Token"];
    [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"issuedAt" ascending:NO]]];
    NSArray *result = [[RKObjectManager sharedManager].managedObjectStore.mainQueueManagedObjectContext executeFetchRequest:fetchRequest error:&error];
    Token *lastToken = [result lastObject];
    return lastToken.accessToken;
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

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)submitStockForm:(UITableViewCell<FXFormFieldCell> *)cell
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:hud];
    hud.labelText = @"¡Pesando productos!";
    hud.color = [UIColor colorWithRed:0 green:0.6 blue:0.8 alpha:0.9];
    [hud show:YES];
    
    GeoCode *geoCode = [self.geoCodes firstObject];
    AddressComponent *address = [geoCode.addressComponents firstObject];
    AddressComponent *town = [geoCode.addressComponents objectAtIndex:1];
    AddressComponent *state = [geoCode.addressComponents objectAtIndex:2];
    AddressComponent *country = [geoCode.addressComponents lastObject];
    
    self.stockForm.scenario = @"createNewStock";
    
    if (![self.stockForm validate]) {
        [hud hide:YES];
        [self showErrors];
    } else {
        RKObjectManager *objectManager = [RKObjectManager sharedManager];
        NSManagedObjectContext *context = objectManager.managedObjectStore.mainQueueManagedObjectContext;
        MyStock *stock = [NSEntityDescription insertNewObjectForEntityForName:@"MyStock" inManagedObjectContext:context];
        
        stock.productId = self.stockForm.product.productId;
        stock.unitId = self.stockForm.unit.unitId;
        stock.qty = self.stockForm.qty;
        stock.pricePerUnit = self.stockForm.pricePerUnit;
        stock.expiresAt = self.stockForm.expiresAt;
        stock.latitude = [NSNumber numberWithDouble:self.location.coordinate.latitude];
        stock.longitude = [NSNumber numberWithDouble:self.location.coordinate.longitude];
        stock.address = address.longName;
        stock.town = town.longName;
        stock.state = state.longName;
        stock.country = country.longName;
        
        [objectManager.HTTPClient setDefaultHeader:@"Authorization" value:[NSString stringWithFormat:@"Bearer %@", [self accessToken]]];
        [objectManager postObject:stock
                             path:STOCKS_PATH
                       parameters:nil
                          success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                              hud.labelText = @"¡Inventario creado!";
                              hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
                              hud.mode = MBProgressHUDModeCustomView;
                              [self performSelector:@selector(returnToFarmer:) withObject:hud afterDelay:1.5];
                              
                          }
                          failure:^(RKObjectRequestOperation *operation, NSError *error) {
                              C4CShowAlertWithError(error.localizedDescription);
                              [hud hide:YES];
                          }];
    }
    
}

- (void)returnToFarmer :(MBProgressHUD *)hud
{
    [self.navigationController popViewControllerAnimated:YES];
    [hud hide:YES];
}

-(void)loadAddressData :(NSString *)latLon :(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
{
    RKObjectMapping *addressMapping = [RKObjectMapping mappingForClass:[AddressComponent class]];
    [addressMapping addAttributeMappingsFromDictionary:@{@"long_name" :@"longName",
                                                         @"short_name":@"shortName"}];
    RKObjectMapping *geoCodeMapping = [RKObjectMapping mappingForClass:[GeoCode class]];
    [geoCodeMapping addAttributeMappingsFromDictionary:@{@"formatted_address" :@"formattedAddress"}];
    RKRelationshipMapping *relationShipMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"address_components"
                                                                                             toKeyPath:@"addressComponents"
                                                                                           withMapping:addressMapping];
    
    [geoCodeMapping addPropertyMapping:relationShipMapping];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:GOOGLE_MAPS_BASE_URL]];
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:httpClient];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:geoCodeMapping
                                                                                            method:RKRequestMethodGET
                                                                                       pathPattern:GEOCODE_PATH
                                                                                           keyPath:@"results"
                                                                                       statusCodes:[NSIndexSet indexSetWithIndex:200]];
    [objectManager addResponseDescriptor:responseDescriptor];
    [objectManager getObjectsAtPath:GEOCODE_PATH
                         parameters:@{@"latlng":latLon}
                            success:success
                            failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                RKLogError(@"Error: %@", error);
                                C4CShowAlertWithError([error localizedDescription]);
                            }];
}

static void C4CShowAlertWithError(NSString *error)
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:error
                                                   delegate:nil
                                          cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

-(void)showErrors {
    NSMutableString *message = [NSMutableString string];
    
    [self.stockForm.errors enumerateKeysAndObjectsUsingBlock:^(NSString *attribute, NSArray *errors, BOOL *stop) {
        for(NSString *error in errors) {
            [message appendFormat:@"- %@\n", error];
        };
    }];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!"
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

# pragma mark  - LOCATION SERVICES

- (void) startLocationRequest :(void (^)(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status))block
{
   
    INTULocationManager *locMgr = [INTULocationManager sharedInstance];
    self.locationRequestID = [locMgr requestLocationWithDesiredAccuracy:INTULocationAccuracyCity
                                                                timeout:20
                                                   delayUntilAuthorized:YES
                                                                  block:block];
}


@end
