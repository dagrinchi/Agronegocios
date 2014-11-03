//
//  C4CAppDelegate.m
//  Agronegocios
//
//  Created by David Almeciga on 7/6/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4CAppDelegate.h"

@implementation C4CAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSError *error = nil;
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] mutableCopy];
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    
    //PRICE MAPPING
    RKEntityMapping *priceMapping = [RKEntityMapping mappingForEntityForName:@"Price" inManagedObjectStore:managedObjectStore];
    [priceMapping addAttributeMappingsFromDictionary:@{@"Id"                :@"priceId",
                                                       @"Product.Code"      :@"productCode",
                                                       @"Product.Name"      :@"productName",
                                                       @"Unit.Code"         :@"unitCode",
                                                       @"Unit.Name"         :@"unitName",
                                                       @"Location"          :@"location",
                                                       @"PriceMaxPerUnit"   :@"priceMaxPerUnit",
                                                       @"PriceMinPerUnit"   :@"priceMinPerUnit",
                                                       @"PriceAvgPerUnit"   :@"priceAvgPerUnit",
                                                       @"Created"           :@"createdAt",
                                                       @"Updated"           :@"updatedAt"}];
    priceMapping.identificationAttributes = @[@"priceId"];
    [managedObjectStore addSearchIndexingToEntityForName:@"Price"
                                            onAttributes:@[@"productName", @"location"]];
    
    //PRODUCT RESPONSE MAPPING
    RKEntityMapping *productMapping = [RKEntityMapping mappingForEntityForName:@"Product" inManagedObjectStore:managedObjectStore];
    [productMapping addAttributeMappingsFromDictionary:@{@"Id"      :@"productId",
                                                         @"Code"    :@"code",
                                                         @"Name"    :@"name"}];
    productMapping.identificationAttributes = @[@"productId"];
    
    //UNIT RESPONSE MAPPING
    RKEntityMapping *unitMapping = [RKEntityMapping mappingForEntityForName:@"Unit" inManagedObjectStore:managedObjectStore];
    [unitMapping addAttributeMappingsFromDictionary:@{@"Id"  :@"unitId",
                                                      @"Code":@"code",
                                                      @"Name":@"name"}];
    unitMapping.identificationAttributes = @[@"unitId"];
    
    //STOCK REPONSE MAPPING
    RKEntityMapping *stockRpMapping = [RKEntityMapping mappingForEntityForName:@"Stock" inManagedObjectStore:managedObjectStore];
    [stockRpMapping addAttributeMappingsFromDictionary:@{@"Id"                      :@"stockId",
                                                         @"Product.Id"              :@"productId",
                                                         @"Product.Code"            :@"productCode",
                                                         @"Product.Name"            :@"productName",
                                                         @"Unit.Id"                 :@"unitId",
                                                         @"Unit.Code"               :@"unitCode",
                                                         @"Unit.Name"               :@"unitName",
                                                         @"Qty"                     :@"qty",
                                                         @"PricePerUnit"            :@"pricePerUnit",
                                                         @"ExpiresAt"               :@"expiresAt",
                                                         @"GeoPoint.Latitude"       :@"latitude",
                                                         @"GeoPoint.Longitude"      :@"longitude",
                                                         @"GeoPoint.Address"        :@"address",
                                                         @"GeoPoint.Town"           :@"town",
                                                         @"GeoPoint.State"          :@"state",
                                                         @"GeoPoint.Country"        :@"country",
                                                         @"User.Email"              :@"userEmail",
                                                         @"User.User.Name"          :@"userName",
                                                         @"User.User.Identification":@"userIdentidication",
                                                         @"User.User.Phone"         :@"userPhone",
                                                         @"Created"                 :@"createdAt",
                                                         @"Updated"                 :@"updatedAt"}];
    
    //STOCK REQUEST MAPPING
    RKObjectMapping *stockRqMapping = [RKObjectMapping requestMapping];
    [stockRqMapping addAttributeMappingsFromDictionary:@{@"Product.Id"              :@"productId",
                                                         @"Unit.Id"                 :@"unitId",
                                                         @"Qty"                     :@"qty",
                                                         @"PricePerUnit"            :@"pricePerUnit",
                                                         @"ExpiresAt"               :@"expiresAt",
                                                         @"GeoPoint.Latitude"       :@"latitude",
                                                         @"GeoPoint.Longitude"      :@"longitude",
                                                         @"GeoPoint.Address"        :@"address",
                                                         @"GeoPoint.Town"           :@"town",
                                                         @"GeoPoint.State"          :@"state",
                                                         @"GeoPoint.Country"        :@"country"}];
    
    //REGISTRATION REQUEST MAPPING
    RKObjectMapping *registrationRqMapping = [RKObjectMapping requestMapping];
    [registrationRqMapping addAttributeMappingsFromDictionary:@{@"name"          :@"Name",
                                                                @"identification":@"Identification",
                                                                @"phone"         :@"Phone",
                                                                @"address"       :@"Address",
                                                                @"email"         :@"Email",
                                                                @"password"      :@"Password",
                                                                @"repeatPassword":@"ConfirmPassword"}];
    
    //REGISTRATION RESPONSE MAPPING
    RKObjectMapping *registrationRpMapping = [RKObjectMapping mappingForClass:[Registration class]];
    [registrationRpMapping addAttributeMappingsFromDictionary:@{@"name"          :@"User.Name",
                                                                @"identification":@"User.Identification",
                                                                @"phone"         :@"User.Phone",
                                                                @"email"         :@"Email"}];
    
    //LOGIN REQUEST MAPPING
    RKObjectMapping *loginRqMapping = [RKObjectMapping requestMapping];
    [loginRqMapping addAttributeMappingsFromDictionary:@{@"grantType":@"grant_type",
                                                         @"username" :@"username",
                                                         @"password" :@"password"}];
    
    //TOKEN RESPONSE MAPPING
    RKEntityMapping *tokenMapping = [RKEntityMapping mappingForEntityForName:@"Token" inManagedObjectStore:managedObjectStore];
    [tokenMapping addAttributeMappingsFromDictionary:@{@"access_token"  :@"accessToken",
                                                       @"token_type"    :@"tokenType",
                                                       @"expires_in"    :@"expiresIn",
                                                       @"userName"      :@"userName",
                                                       @".issued"       :@"expiresAt",
                                                       @".expires"      :@"issuedAt"}];
    
    //ERROR MAPPING RESPONSE
    RKObjectMapping *errorMapping = [RKObjectMapping mappingForClass:[RKErrorMessage class]];
    [errorMapping addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:nil toKeyPath:@"errorMessage"]];

    
    
    // CORE DATA INITIALIZATION
    BOOL success = RKEnsureDirectoryExistsAtPath(RKApplicationDataDirectory(), &error);
    if (! success) {
        RKLogError(@"Failed to create Application Data Directory at path '%@': %@", RKApplicationDataDirectory(), error);
    }
    NSString *path = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"Agronegocios.sqlite"];
    NSPersistentStore *persistentStore = [managedObjectStore addSQLitePersistentStoreAtPath:path fromSeedDatabaseAtPath:nil withConfiguration:nil options:nil error:&error];
    if (! persistentStore) {
        RKLogError(@"Failed adding persistent store at path '%@': %@", path, error);
    }
    
    [managedObjectStore createManagedObjectContexts];
    [managedObjectStore startIndexingPersistentStoreManagedObjectContext];
    
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:BASE_URL]];
    objectManager.managedObjectStore = managedObjectStore;

    // RESPOSE DESCRIPTORS
     NSArray *responseDescriptors = @[[RKResponseDescriptor responseDescriptorWithMapping:priceMapping
                                                                                   method:RKRequestMethodAny
                                                                              pathPattern:PRICES_PATH
                                                                                  keyPath:nil
                                                                              statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)],
                                      [RKResponseDescriptor responseDescriptorWithMapping:registrationRpMapping
                                                                                   method:RKRequestMethodAny
                                                                              pathPattern:REGISTER_PATH
                                                                                  keyPath:nil
                                                                              statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)],
                                      [RKResponseDescriptor responseDescriptorWithMapping:errorMapping
                                                                                   method:RKRequestMethodAny
                                                                              pathPattern:nil
                                                                                  keyPath:@"Message"
                                                                              statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassClientError)],
                                      [RKResponseDescriptor responseDescriptorWithMapping:tokenMapping
                                                                                   method:RKRequestMethodAny
                                                                              pathPattern:TOKEN_PATH
                                                                                  keyPath:nil
                                                                              statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)],
                                      [RKResponseDescriptor responseDescriptorWithMapping:productMapping
                                                                                   method:RKRequestMethodAny
                                                                              pathPattern:PRODUCTS_PATH
                                                                                  keyPath:nil
                                                                              statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)],
                                      [RKResponseDescriptor responseDescriptorWithMapping:unitMapping
                                                                                   method:RKRequestMethodAny
                                                                              pathPattern:UNITS_PATH
                                                                                  keyPath:nil
                                                                              statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)],
                                      [RKResponseDescriptor responseDescriptorWithMapping:stockRpMapping
                                                                                   method:RKRequestMethodAny
                                                                              pathPattern:STOCKS_PATH
                                                                                  keyPath:nil
                                                                              statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];
    [objectManager addResponseDescriptorsFromArray:responseDescriptors];
    
    // REQUEST DESCRIPTOR
    NSArray *requestDescriptors = @[[RKRequestDescriptor requestDescriptorWithMapping:registrationRqMapping
                                                                          objectClass:[Registration class]
                                                                          rootKeyPath:nil
                                                                               method:RKRequestMethodAny],
                                    [RKRequestDescriptor requestDescriptorWithMapping:loginRqMapping
                                                                          objectClass:[Login class]
                                                                          rootKeyPath:nil
                                                                               method:RKRequestMethodAny],
                                    [RKRequestDescriptor requestDescriptorWithMapping:stockRqMapping
                                                                          objectClass:[Stock class]
                                                                          rootKeyPath:nil
                                                                               method:RKRequestMethodAny]];
    [objectManager addRequestDescriptorsFromArray:requestDescriptors];
    
    if (![CLLocationManager locationServicesEnabled]) {
        UIAlertView *servicesDisabledAlert = [[UIAlertView alloc] initWithTitle:@"El servicio GPS está apagado"
                                                                        message:@"Actualmente tiene apagado los servicios de localización. Si continua, se le preguntará si pueden ser reactivado."
                                                                       delegate:nil
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil];
        [servicesDisabledAlert show];
    }
    
    return YES;
}

@end
