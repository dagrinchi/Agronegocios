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
    
    //RKLogConfigureByName("RestKit/CoreData", RKLogLevelDebug);
    RKLogConfigureByName("RestKit/Search", RKLogLevelTrace);
    
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] mutableCopy];
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    
    // PRICE MAPPING
    RKEntityMapping *priceMapping = [RKEntityMapping mappingForEntityForName:@"Price" inManagedObjectStore:managedObjectStore];
    [priceMapping addAttributeMappingsFromDictionary:@{@"Id" : @"priceId",
                                                       @"Product.Code" : @"productCode",
                                                       @"Product.Name" : @"productName",
                                                       @"Unit.Code" : @"unitCode",
                                                       @"Unit.Name" : @"unitName",
                                                       @"Location" : @"location",
                                                       @"PriceMaxPerUnit" : @"priceMaxPerUnit",
                                                       @"PriceMinPerUnit" : @"priceMinPerUnit",
                                                       @"PriceAvgPerUnit" : @"priceAvgPerUnit",
                                                       @"Created" : @"createdAt",
                                                       @"Updated" : @"updatedAt"}];
    priceMapping.identificationAttributes = @[@"priceId"];
    [managedObjectStore addSearchIndexingToEntityForName:@"Price"
                                            onAttributes:@[@"productName", @"location"]];
    
    //REGISTRATION REQUEST MAPPING
    RKObjectMapping *registrationRqMapping = [RKObjectMapping requestMapping];
    [registrationRqMapping addAttributeMappingsFromDictionary:@{@"name": @"Name",
                                                              @"identification": @"Identification",
                                                              @"phone": @"Phone",
                                                              @"address": @"Address",
                                                              @"email": @"Email",
                                                              @"password": @"Password",
                                                              @"repeatPassword": @"ConfirmPassword"}];
    
    //REGISTRATION RESPONSE MAPPING
    RKObjectMapping *registrationRpMapping = [RKObjectMapping mappingForClass:[Registration class]];
    [registrationRpMapping addAttributeMappingsFromDictionary:@{@"name": @"User.Name",
                                                                @"identification": @"User.Identification",
                                                                @"phone": @"User.Phone",
                                                                @"email": @"Email"}];
    
    //LOGIN REQUEST MAPPING
    RKObjectMapping *loginRqMapping = [RKObjectMapping requestMapping];
    [loginRqMapping addAttributeMappingsFromDictionary:@{@"grantType": @"grant_type",
                                                         @"username": @"username",
                                                         @"password": @"password"}];
    
    //TOKEN RESPONSE MAPPING
    RKEntityMapping *tokenMapping = [RKEntityMapping mappingForEntityForName:@"Token" inManagedObjectStore:managedObjectStore];
    [tokenMapping addAttributeMappingsFromDictionary:@{@"access_token": @"accessToken",
                                                       @"token_type": @"tokenType",
                                                       @"expires_in": @"expiresIn",
                                                       @"userName": @"userName",
                                                       @".issued": @"expiresAt",
                                                       @".expires": @"issuedAt"}];
    
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
                                                                              statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];
    [objectManager addResponseDescriptorsFromArray:responseDescriptors];
    
    /*[objectManager addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:tokenMapping
                                                                                      method:RKRequestMethodPOST
                                                                                 pathPattern:TOKEN_PATH
                                                                                     keyPath:nil
                                                                                 statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];*/
    
    // REQUEST DESCRIPTOR
    NSArray *requestDescriptors = @[[RKRequestDescriptor requestDescriptorWithMapping:registrationRqMapping
                                                                          objectClass:[Registration class]
                                                                          rootKeyPath:nil
                                                                               method:RKRequestMethodAny],
                                    [RKRequestDescriptor requestDescriptorWithMapping:loginRqMapping
                                                                          objectClass:[Login class]
                                                                          rootKeyPath:nil
                                                                               method:RKRequestMethodAny]];
    [objectManager addRequestDescriptorsFromArray:requestDescriptors];
    
    /// TEST ///
    NSManagedObjectContext *moc = [managedObjectStore mainQueueManagedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Token" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    //NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Token"];
    /*NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"issuedAt" ascending:NO];
     [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];*/
    
    NSArray *results = [moc executeFetchRequest:request error:&error];
    Token *lastToken = [results objectAtIndex:0];
    
    /*if (lastToken == nil && [NSDate date] >= lastToken.expiresAt) {
     [self.navigationController pushViewController:[[C4CRootFormViewController alloc] init] animated:YES];
     } else {
     [self.navigationController pushViewController:[[C4CWhoamiTableViewController alloc] init] animated:YES];
     }*/
    NSLog(@"Go app %@", [[[NSDateFormatter alloc] init] stringFromDate:lastToken.expiresAt]);
    
    return YES;
}

@end
