//
//  C4CNewOrderFormViewController.m
//  Agronegocios
//
//  Created by David Almeciga on 11/8/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4CNewOrderFormViewController.h"

@interface C4CNewOrderFormViewController ()

@property (assign, nonatomic) NSInteger locationRequestID;

@end

@implementation C4CNewOrderFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    SAMHUDView *hud = [[SAMHUDView alloc] initWithTitle:@"Sembrando semillas!" loading:YES];
    
    C4COrderForm *orderForm = [[C4COrderForm alloc] init];
    [hud show];
    
    [self startLocationRequest:^(CLLocation *location, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
        if (status == INTULocationStatusSuccess) {
            self.location = location;
            [self loadAddressData:[NSString stringWithFormat:@"%@,%@", [[NSNumber numberWithDouble:location.coordinate.latitude] stringValue], [[NSNumber numberWithDouble:location.coordinate.longitude] stringValue]]
                                 :^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                     self.geoCodes = [mappingResult array];
                                     [hud dismiss];
                                 }];
        }
        else if (status == INTULocationStatusTimedOut) {
            C4CShowAlertWithError(@"Tiempo agotado para la solicitud de localización.");
            [hud dismiss];
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
            [hud dismiss];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
        self.locationRequestID = NSNotFound;
    }];
    
    self.formController.form = orderForm;
    
    UIColor *bgColor = [UIColor colorWithRed:1 green:0.91 blue:0.74 alpha:1];
    self.tableView.backgroundView.backgroundColor = bgColor;
    self.tableView.backgroundColor = bgColor;
    self.view.backgroundColor = bgColor;
    
    self.title = @"Nuevo Pedido";
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

- (void)submitOrderForm:(UITableViewCell<FXFormFieldCell> *)cell
{
    SAMHUDView *hud = [[SAMHUDView alloc] initWithTitle:@"Enviando!" loading:YES];
    [hud show];
    
    GeoCode *geoCode = [self.geoCodes firstObject];
    AddressComponent *address = [geoCode.addressComponents firstObject];
    AddressComponent *town = [geoCode.addressComponents objectAtIndex:1];
    AddressComponent *state = [geoCode.addressComponents objectAtIndex:2];
    AddressComponent *country = [geoCode.addressComponents lastObject];
    
    C4COrderForm *form = cell.field.form;
    NewOrder *order = [NewOrder new];
    
    if (form.fullName != nil && form.phone != nil && form.qty != nil) {
        
        order.stockId = _stock.stockId;
        order.fullName = form.fullName;
        order.phone = form.phone;
        order.qty = form.qty;
        order.latitude = [NSNumber numberWithDouble:self.location.coordinate.latitude];
        order.longitude = [NSNumber numberWithDouble:self.location.coordinate.longitude];
        order.address = address.longName;
        order.town = town.longName;
        order.state = state.longName;
        order.country = country.longName;
        
        RKObjectManager *objectManager = [RKObjectManager sharedManager];
        [objectManager.HTTPClient setDefaultHeader:@"Authorization" value:[NSString stringWithFormat:@"Bearer %@", [self accessToken]]];
        [objectManager postObject:order
                             path:ORDERS_PATH
                       parameters:nil
                          success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                              hud.textLabel.text = @"Listo!";
                              hud.loading = FALSE;
                              hud.successful = TRUE;
                              [self performSelector:@selector(returnToStockDetail:) withObject:hud afterDelay:1.5];
                              
                          }
                          failure:^(RKObjectRequestOperation *operation, NSError *error) {
                              RKErrorMessage *errorMessage =  [[error.userInfo objectForKey:RKObjectMapperErrorObjectsKey] firstObject];
                              C4CShowAlertWithError(errorMessage.errorMessage);
                              [hud dismiss];
                          }];
    } else {
        C4CShowAlertWithError(@"Todos los campos son requeridos.");
        [hud dismiss];
    }
}

- (void)returnToStockDetail :(SAMHUDView *)hud
{
    [self.navigationController popViewControllerAnimated:YES];
    [hud dismiss];
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