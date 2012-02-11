//
//  AppDelegate.m
//  iSchoolManager
//
//  Created by Andrew Davis on 2/11/12.
//  Copyright (c) 2012 NASA. All rights reserved.
//

#import <RestKit/RestKit.h>
#import "AppDelegate.h"
#import "CoursesTableViewController.h"
#import "Course.h"

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    RKLogConfigureByName("RestKit/Network*", RKLogLevelTrace);
    // Initialize RestKit
    RKObjectManager* objectManager = [RKObjectManager objectManagerWithBaseURL:@"http://school_manager.dev"];
    
    // Enable automatic network activity indicator management
    objectManager.client.requestQueue.showsNetworkActivityIndicatorWhenBusy = YES;
    
    // Setup our object mappings
    RKObjectMapping* courseMapping = [RKObjectMapping mappingForClass:[Course class]];
    [courseMapping mapKeyPathsToAttributes:
     @"id", @"courseID",
     @"name", @"name",
     @"number", @"number",
     nil];
    
    // Update date format so that we can parse Twitter dates properly
    // Wed Sep 29 15:31:08 +0000 2010
    [RKObjectMapping addDefaultDateFormatterForString:@"E MMM d HH:mm:ss Z y" inTimeZone:nil];
    
    // Register our mappings with the provider
    [objectManager.mappingProvider setMapping:courseMapping forKeyPath:@"course"];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
