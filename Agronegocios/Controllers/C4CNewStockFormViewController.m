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
    
    NSManagedObjectContext *managedObjectContext = [RKObjectManager sharedManager].managedObjectStore.mainQueueManagedObjectContext;
    SAMHUDView *hud = [[SAMHUDView alloc] initWithTitle:@"Regando cultivos!" loading:YES];

    C4CStockForm *stockForm = [[C4CStockForm alloc] init];
    [hud show];
    [self loadProductsData:self.accessToken :^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        [self loadUnitsData:self.accessToken :^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
            [self startLocationRequest:^(CLLocation *location, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
                if (status == INTULocationStatusSuccess) {
                    [self loadAddressData:[NSString stringWithFormat:@"%@,%@", [[NSNumber numberWithDouble:location.coordinate.latitude] stringValue], [[NSNumber numberWithDouble:location.coordinate.longitude] stringValue]]
                                         :^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                             self.geoCodes = [mappingResult array];
                                             [hud dismiss];
                                         }];
                }
                else if (status == INTULocationStatusTimedOut) {
                    C4CShowAlertWithError(@"Tiempo agotado para la solicitud de localiazición.");
                }
                else {
                    if (status == INTULocationStatusServicesNotDetermined) {
                        C4CShowAlertWithError(@"Tienes apagados los servicios de localización para esta aplicación.");
                    } else if (status == INTULocationStatusServicesDenied) {
                        C4CShowAlertWithError(@"Tienes prohibido el uso de los servicios de localización para esta aplicación.");
                    } else if (status == INTULocationStatusServicesRestricted) {
                        C4CShowAlertWithError(@"Tienes restricciones en el uso de privacidad con el uso de la localización para esta aplicación.");
                    } else if (status == INTULocationStatusServicesDisabled) {
                        C4CShowAlertWithError(@"Tienes apagado los servicios de localización para todas las aplicaciones de este dispositivo.");
                    } else {
                        C4CShowAlertWithError(@"Se presenta un error desconocido, reintente más tarde.");
                    }
                }
                
                self.locationRequestID = NSNotFound;
            }];
        }];
    }];
    
    NSFetchRequest *productsFetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Product"];
    [productsFetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
    stockForm.products = [managedObjectContext executeFetchRequest:productsFetchRequest error:nil];
    
    NSFetchRequest *unitsFetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Unit"];
    [unitsFetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
    stockForm.units = [managedObjectContext executeFetchRequest:unitsFetchRequest error:nil];
    self.formController.form = stockForm;
    
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
    SAMHUDView *hud = [[SAMHUDView alloc] initWithTitle:@"Enviando!" loading:YES];
    //C4CStockForm *form = cell.field.form;
    
}

- (void)loadProductsData :(NSString *)tokenString :(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success {
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [objectManager.HTTPClient setDefaultHeader:@"Authorization" value:[NSString stringWithFormat:@"Bearer %@", tokenString]];
    [objectManager getObjectsAtPath:PRODUCTS_PATH
                         parameters:nil
                            success:success
                            failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                RKLogError(@"Error: %@", error);
                                C4CShowAlertWithError([error localizedDescription]);
                            }];
    
}

- (void)loadUnitsData :(NSString *)tokenString :(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success {
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [objectManager.HTTPClient setDefaultHeader:@"Authorization" value:[NSString stringWithFormat:@"Bearer %@", tokenString]];
    [objectManager getObjectsAtPath:UNITS_PATH
                         parameters:nil
                            success:success
                            failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                RKLogError(@"Error: %@", error);
                                C4CShowAlertWithError([error localizedDescription]);
                            }];
    
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
