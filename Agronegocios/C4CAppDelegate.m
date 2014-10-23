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
#import "C4CPriceTableViewController.h"

@implementation C4CAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSError *error = nil;
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;

    /*NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    NSManagedObjectModel *managedObjectModel = [[[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL] mutableCopy];
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    
    [managedObjectStore createPersistentStoreCoordinator];
    
    //NSPersistentStore __unused *persistentStore = [managedObjectStore addInMemoryPersistentStore:&error];
    //NSAssert(persistentStore, @"Failed to add persistent store: %@", error);
    NSString *storePath = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"Agronegocios.sqlite"];
    NSString *seedPath = [[NSBundle mainBundle] pathForResource:@"AgronegociosSeedDatabase" ofType:@"sqlite"];
    NSPersistentStore *persistentStore = [managedObjectStore addSQLitePersistentStoreAtPath:storePath fromSeedDatabaseAtPath:seedPath withConfiguration:nil options:nil error:&error];
    NSAssert(persistentStore, @"Failed to add persistent store with error: %@", error);
    
    [managedObjectStore createManagedObjectContexts];
    managedObjectStore.managedObjectCache = [[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:managedObjectStore.persistentStoreManagedObjectContext];
    
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:BASE_URL]];
    objectManager.managedObjectStore = managedObjectStore;

    [RKObjectManager setSharedManager:objectManager];
    [objectManager.HTTPClient setDefaultHeader:@"Content-Type" value:@"application/json"];
    
    RKEntityMapping *priceMapping = [RKEntityMapping mappingForEntityForName:@"Price" inManagedObjectStore:managedObjectStore];
    [priceMapping addAttributeMappingsFromDictionary:@{@"priceId" : @"Id",
                                                  @"productCode" : @"Product.Code",
                                                  @"productName" : @"Product.Name",
                                                  @"unitCode" : @"Unit.Code",
                                                  @"unitName" : @"Unit.Name",
                                                  @"priceAvgPerUnit" : @"PriceAvgPerUnit",
                                                  @"priceMaxPerUnit" : @"PriceMaxPerUnit",
                                                  @"priceMinPerUnit" : @"PriceMinPerUnit",
                                                  @"location" : @"Location",
                                                  @"createdAt" : @"Created",
                                                  @"updatedAt" : @"Updated"}];
    priceMapping.identificationAttributes = @[@"priceId"];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:priceMapping
                                                                                       pathPattern:PRICES_PATH
                                                                                           keyPath:nil
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responseDescriptor];*/
    
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
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
    
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:BASE_URL]];
    objectManager.managedObjectStore = managedObjectStore;
    
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
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:priceMapping
                                                                                            method:RKRequestMethodAny
                                                                                       pathPattern:PRICES_PATH
                                                                                           keyPath:nil
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:responseDescriptor];
    
    return YES;
}

@end
