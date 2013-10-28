//
//  Player.h
//  DualTableView
//
//  Created by Shintaro Kaneko on 10/27/13.
//  Copyright (c) 2013 Muukii. All rights reserved.
//

#import "MManagedObject.h"

#import <Foundation/Foundation.h>

UIKIT_EXTERN NSString *const kMPlayerObjectIdKey;

@interface Player : MManagedObject

@property (nonatomic, retain) NSNumber * commentsCount;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSNumber * identity;
@property (nonatomic, retain) NSNumber * likesCount;
@property (nonatomic, retain) NSNumber * reboundsCount;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * twitterScreenName;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * websiteUrl;
@property (nonatomic, retain) NSString * avaterUrl;
@property (nonatomic, retain) NSNumber * commentsReceivedCount;
@property (nonatomic, retain) NSNumber * likesReceivedCount;
@property (nonatomic, retain) NSNumber * reboundsReceivedCount;
@property (nonatomic, retain) NSNumber * shotsCount;
@property (nonatomic, retain) NSNumber * drafteesCount;
@property (nonatomic, retain) NSNumber * followersCount;
@property (nonatomic, retain) NSNumber * followingCount;
@property (nonatomic, retain) NSNumber * draftedByPlayerId;
@property (nonatomic, retain) NSSet *shots;

+ (Player *)insertByDictionary:(NSDictionary *)dictionary withShots:(NSArray *)shots;
- (void)updateByDictionary:(NSDictionary *)dictionary;

@end

@interface Player (State)

@property (assign, nonatomic, getter = hasComments, readonly) BOOL comments;
@property (assign, nonatomic, getter = hasCommentsReceived, readonly) BOOL commentsReceived;
@property (assign, nonatomic, getter = hasLikes, readonly) BOOL likes;
@property (assign, nonatomic, getter = hasLikesReceived, readonly) BOOL likesReceived;
@property (assign, nonatomic, getter = hasRebounds, readonly) BOOL rebounds;
@property (assign, nonatomic, getter = hasReboundsReceived, readonly) BOOL reboundsReceived;
@property (assign, nonatomic, getter = hasShots, readonly) BOOL shots;
@property (assign, nonatomic, getter = hasDraftees, readonly) BOOL draftees;
@property (assign, nonatomic, getter = hasFollowers, readonly) BOOL followers;
@property (assign, nonatomic, getter = hasFollowing, readonly) BOOL following;

@end

@interface Player (CoreDataGeneratedAccessors)

- (void)addShotsObject:(NSManagedObject *)value;
- (void)removeShotsObject:(NSManagedObject *)value;
- (void)addShots:(NSSet *)values;
- (void)removeShots:(NSSet *)values;

@end
