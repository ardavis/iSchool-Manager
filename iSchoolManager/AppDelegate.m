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
#import "MyModels.h"

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    RKLogConfigureByName("RestKit/Network*", RKLogLevelTrace);
    // Initialize RestKit
    RKObjectManager* objectManager = [RKObjectManager objectManagerWithBaseURL:@"http://school_manager.dev"];
    objectManager.acceptMIMEType = RKMIMETypeJSON;
    objectManager.serializationMIMEType = RKMIMETypeJSON; 
    
    // Enable automatic network activity indicator management
    objectManager.client.requestQueue.showsNetworkActivityIndicatorWhenBusy = YES;

#pragma mark - Reskit Mappings
    // Incoming Mappings
    RKObjectMapping *courseMapping  = [RKObjectMapping mappingForClass:[Course class]];
    RKObjectMapping *projectMapping = [RKObjectMapping mappingForClass:[Project class]];
    
    // Outgoing Mappings
    RKObjectMapping *courseSerializationMapping = [RKObjectMapping mappingForClass:[Course class]]; 
    RKObjectMapping *projectSerializationMapping = [RKObjectMapping mappingForClass:[Project class]];

#pragma mark - Restkit Course Setup  
    // Setup our incoming object mappings
    [courseMapping mapKeyPath:@"id" toAttribute:@"courseID"];
    [courseMapping mapKeyPath:@"name" toAttribute:@"name"];
    [courseMapping mapKeyPath:@"number" toAttribute:@"number"];
    
    // Setup our outgoing object mapping
    [courseSerializationMapping mapKeyPath:@"courseID" toAttribute:@"id"]; 
    [courseSerializationMapping mapKeyPath:@"name" toAttribute:@"name"]; 
    [courseSerializationMapping mapKeyPath:@"number" toAttribute:@"number"]; 
    
    // Register our mappings with the provider
    [objectManager.mappingProvider setMapping:courseMapping forKeyPath:@""];
    [objectManager.mappingProvider setSerializationMapping:courseSerializationMapping forClass:[Course class]];
    
    // Routing
    [objectManager.router routeClass:[Course class] toResourcePath:@"users/1/courses" forMethod:RKRequestMethodGET];
    [objectManager.router routeClass:[Course class] toResourcePath:@"users/1/courses" forMethod:RKRequestMethodPOST];
    [objectManager.router routeClass:[Course class] toResourcePath:@"users/1/courses/:courseID" forMethod:RKRequestMethodDELETE];
    

#pragma mark - Restkit Project Setup      
    // Setup our incoming object mappings
    [projectMapping mapKeyPath:@"id" toAttribute:@"projectID"];
    [projectMapping mapKeyPath:@"course_id" toAttribute:@"courseID"];
    [projectMapping mapKeyPath:@"title" toAttribute:@"title"];
    [projectMapping mapKeyPath:@"description" toAttribute:@"desc"];
    [projectMapping mapKeyPath:@"due_date" toAttribute:@"dueDate"];
    [projectMapping mapKeyPath:@"completed_at" toAttribute:@"completedAt"];
    
    [projectMapping mapRelationship:@"course" withMapping:courseMapping];
    
    // Setup our outgoing mapping
    [projectSerializationMapping mapKeyPath:@"projectID" toAttribute:@"id"];
    [projectSerializationMapping mapKeyPath:@"courseID" toAttribute:@"course_id"];
    [projectSerializationMapping mapKeyPath:@"title" toAttribute:@"title"];
    [projectSerializationMapping mapKeyPath:@"desc" toAttribute:@"description"];
    [projectSerializationMapping mapKeyPath:@"dueDate" toAttribute:@"due_date"];
    [projectSerializationMapping mapKeyPath:@"completedAt" toAttribute:@"completed_at"];
    
    // Register our mappings with the provider
    [objectManager.mappingProvider setMapping:projectMapping forKeyPath:@"/projects"];
    [objectManager.mappingProvider setSerializationMapping:projectSerializationMapping forClass:[Project class]];
    
    // Routing
    [objectManager.router routeClass:[Project class] toResourcePath:@"/projects" forMethod:RKRequestMethodGET];
    [objectManager.router routeClass:[Project class] toResourcePath:@"/projects" forMethod:RKRequestMethodPOST];
    [objectManager.router routeClass:[Project class] toResourcePath:@"/projects/:projectID" forMethod:RKRequestMethodDELETE];
    
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
