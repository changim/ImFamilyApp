//
//  Location.h
//  ImFamilyApp
//
//  Created by James Im on 12/15/12.
//  Copyright (c) 2012 James Im. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SPManagedObject.h"


@interface Location : SPManagedObject

@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;

@end
