//
//  C4CAppDelegate.m
//  Agronegocios
//
//  Created by David Almeciga on 7/6/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4CAppDelegate.h"
#import <Parse/Parse.h>

@implementation C4CAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:@"Hy4HilhJuJCkZFCNLVZMSmZB6Zihvg1pbASEBqAz"
                  clientKey:@"LnWKpocESxfmvRLskZ27lg20Y4AnC982Eh02DEZk"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];

    PFACL *defaultACL = [PFACL ACL];
    [defaultACL setPublicReadAccess:YES];
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

@end
