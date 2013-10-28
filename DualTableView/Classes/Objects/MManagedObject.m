//
//  MManagedObject.m
//  DualTableView
//
//  Created by Shintaro Kaneko on 10/28/13.
//  Copyright (c) 2013 Muukii. All rights reserved.
//

#import "MManagedObject.h"

#import "MAppDelegate.h"

@implementation MManagedObject

+ (NSString *)entityName
{
    return NSStringFromClass([self class]);
}

+ (instancetype)findByIdentity:(NSString *)anIdentity
{
    MAppDelegate *appDelegate = (MAppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:[self entityName]
                                        inManagedObjectContext:managedObjectContext]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identity == %@", anIdentity];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *objects = [managedObjectContext executeFetchRequest:fetchRequest
                                                           error:&error];
    return !error ? objects.lastObject : nil;
}

+ (void)removeAllObjects
{
    MAppDelegate *appDelegate = (MAppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:[self entityName]
                                        inManagedObjectContext:managedObjectContext]];
    
    NSError *error = nil;
    NSArray *objects = [managedObjectContext executeFetchRequest:fetchRequest
                                                           error:&error];
    if (!error) {
        for (id object in objects) {
            [managedObjectContext deleteObject:object];
        }
    }
}

@end
