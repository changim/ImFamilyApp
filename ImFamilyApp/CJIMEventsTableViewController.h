//
//  CJIMEventsTableViewController.h
//  ImFamilyApp
//
//  Created by James Im on 12/15/12.
//  Copyright (c) 2012 James Im. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface CJIMEventsTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

    @property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
    @property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end