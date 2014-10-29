//
//  C4CAppDelegate.m
//  Agronegocios
//
//  Created by David Almeciga on 7/6/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4CAppDelegate.h"
#import <RestKit/RestKit.h>
#import <RestKit/CoreData.h>
#import <RestKit/Search.h>
#import "C4CPriceTableViewController.h"
#import "Registration.h"

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
                                                       @"Product.Code":   @"productCode",
                                                       @"Product.Name":   @"productName",
                                                       @"Unit.Code":   @"unitCode",
                                                       @"Unit.Name":   @"unitName",
                                                       @"Location":   @"location",
                                                       @"PriceMaxPerUnit":   @"priceMaxPerUnit",
                                                       @"PriceMinPerUnit":   @"priceMinPerUnit",
                                                       @"PriceAvgPerUnit":   @"priceAvgPerUnit",
                                                       @"Created":   @"createdAt",
                                                       @"Updated":   @"updatedAt"}];
    priceMapping.identificationAttributes = @[@"priceId"];
    [managedObjectStore addSearchIndexingToEntityForName:@"Price"
                                            onAttributes:@[@"productName", @"location"]];
    
    //REGISTRATION MAPPING
    RKObjectMapping *registrationMapping = [RKObjectMapping requestMapping];
    [registrationMapping addAttributeMappingsFromDictionary:@{@"name": @"Name",
                                                              @"identification": @"Identification",
                                                              @"phone": @"Phone",
                                                              @"address": @"Address",
                                                              @"email": @"Email",
                                                              @"password": @"Password",
                                                              @"repeatPassword": @"ConfirmPassword"}];
    
    // TOKEN MAPPING
    /*RKEntityMapping *tokenMapping = [RKEntityMapping mappingForEntityForName:@"Token" inManagedObjectStore:nil];
    [tokenMapping addAttributeMappingsFromDictionary:@{@"access_token": @"accessToken",
                                                       @"token_type": @"tokenType",
                                                       @"expires_in": @"expiresIn",
                                                       @"userName": @"userName",
                                                       @".issued": @"expiresAt",
                                                       @".expires": @"issuedAt"}];*/
    
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

    // RESPOSE DESCRIPTOR PRICE
    [objectManager addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:priceMapping
                                                                                      method:RKRequestMethodAny
                                                                                 pathPattern:PRICES_PATH
                                                                                     keyPath:nil
                                                                                 statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];
    
    /*[objectManager addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:tokenMapping
                                                                                      method:RKRequestMethodPOST
                                                                                 pathPattern:TOKEN_PATH
                                                                                     keyPath:nil
                                                                                 statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];*/
    
    // REQUEST DESCRIPTOR
    [objectManager addRequestDescriptor:[RKRequestDescriptor requestDescriptorWithMapping:registrationMapping
                                                                              objectClass:[Registration class]
                                                                              rootKeyPath:nil
                                                                                   method:RKRequestMethodAny]];
    
    return YES;
}

@end
