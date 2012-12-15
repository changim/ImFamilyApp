//
//  Message.h
//  ImFamilyApp
//
//  Created by James Im on 12/15/12.
//  Copyright (c) 2012 James Im. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SPManagedObject.h"

@class User;

@interface Message : SPManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * body;
@property (nonatomic, retain) User *user;

@end
