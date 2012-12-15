//
//  User.h
//  ImFamilyApp
//
//  Created by James Im on 12/15/12.
//  Copyright (c) 2012 James Im. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SPManagedObject.h"


@interface User : SPManagedObject

@property (nonatomic, retain) NSDate * dateOfBirth;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *message;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addMessageObject:(NSManagedObject *)value;
- (void)removeMessageObject:(NSManagedObject *)value;
- (void)addMessage:(NSSet *)values;
- (void)removeMessage:(NSSet *)values;

@end
