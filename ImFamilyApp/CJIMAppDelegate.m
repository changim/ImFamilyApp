//
//  CJIMAppDelegate.m
//  ImFamilyApp
//
//  Created by James Im on 12/15/12.
//  Copyright (c) 2012 James Im. All rights reserved.
//

#import "CJIMAppDelegate.h"

#import "CJIMMasterViewController.h"
#import <Simperium/SPAuthenticationManager.h>

@interface CJIMAppDelegate () {
    NSMutableArray *_objects;
    NSMutableData *_data;
    SPAuthenticationManager *_authenticationManager;
}
@end

@implementation CJIMAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    CJIMMasterViewController *controller = (CJIMMasterViewController *)navigationController.topViewController;
    controller.managedObjectContext = self.managedObjectContext;
    
    self.simperium = [[Simperium alloc] initWithRootViewController:
                      _window.rootViewController];
    
    
    /* seed me as family member
    NSString *url = @"https://api.simperium.com/1/clip-hushes-0ee/user/i/james";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    NSString *data = [NSString stringWithFormat:@"{\"name\":\"James\", \"password\":\"1234\"}"];
    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValue:@"a072e56ad97b4491a3d5fbd70addfe7d"		forHTTPHeaderField:@"X-Simperium-Token"];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];*/
    
    // start simperium
    self.simperium.authenticationEnabled = NO;
    [self.simperium startWithAppID:@"clip-hushes-0ee"
                            APIKey:@"29b748a1ab8b490e83fef18299abd593"
                             model:[self managedObjectModel]
                           context:[self managedObjectContext]
                       coordinator:[self persistentStoreCoordinator]];
    
    // authenticate user on simperium
    _authenticationManager = [[SPAuthenticationManager alloc] initWithDelegate:self.simperium simperium:self.simperium];
    
    [_authenticationManager authenticateWithUsername:@"everyone@im.com" password:@"1234"
                                             success:^{}
                                            failure:^(int responseCode, NSString *responseString){NSLog(@"fail: %@",responseString);}];
    
    return YES;
}
/*
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    _data = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_data appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"%@",error.localizedDescription);
    abort();
    // Please do something sensible here, like log the error.
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    //NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:_data options:0 error:nil];
    NSString *responseText = [[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding];
    //self.simperium.user = [[SPUser alloc] initWithEmail:[responseDictionary objectForKey:@"username"]
                                                   //token:[responseDictionary objectForKey:@"access_token"]];
    // Do anything you want with it
    NSLog(@"response text: %@ %@", responseText, self.simperium.user.authenticated ? @"YES" : @"NO");
}*/
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    //[self.simperium signOutAndRemoveLocalData:YES];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*[_authenticationManager authenticateWithUsername:@"everyone@im.com" password:@"1234"
                                             success:^{}
                                             failure:^(int responseCode, NSString *responseString){NSLog(@"fail: %@",responseString);}];*/
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ImFamilyApp" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ImFamilyApp.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
