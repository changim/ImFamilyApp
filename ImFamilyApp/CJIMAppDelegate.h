//
//  CJIMAppDelegate.h
//  ImFamilyApp
//
//  Created by James Im on 12/15/12.
//  Copyright (c) 2012 James Im. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Simperium/Simperium.h>
#import <MapKit/MapKit.h>

#import "User.h"

@interface CJIMAppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) Simperium *simperium;
@property (strong, nonatomic) User *currentUser;

// core location stuff
@property CLLocationManager *locationManager;
@property BOOL collectingLocation;
@property (strong, nonatomic) CLLocation *lastLocation;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

// Delegate method from the CLLocationManagerDelegate protocol.
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations ;

@end
