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

@implementation C4CAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSError *error = nil;
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    //RKLogConfigureByName("RestKit/Search", RKLogLevelTrace);
    
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

    // RESPOSE DESCRIPTOR
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:priceMapping
                                                                                            method:RKRequestMethodAny
                                                                                       pathPattern:PRICES_PATH
                                                                                           keyPath:nil
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:responseDescriptor];
    
    return YES;
}

@end
