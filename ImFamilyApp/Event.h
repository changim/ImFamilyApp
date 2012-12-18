//
//  Event.h
//  ImFamilyApp
//
//  Created by James Im on 12/17/12.
//  Copyright (c) 2012 James Im. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <Simperium/SPManagedObject.h>
@class User;

@interface Event : SPManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) User *createdBy;

@end
