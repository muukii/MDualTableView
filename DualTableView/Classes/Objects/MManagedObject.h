//
//  MManagedObject.h
//  DualTableView
//
//  Created by Shintaro Kaneko on 10/28/13.
//  Copyright (c) 2013 Muukii. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface MManagedObject : NSManagedObject

+ (NSString *)entityName;
+ (instancetype)findByIdentity:(NSString *)anIdentity;
+ (void)removeAllObjects;

@end
