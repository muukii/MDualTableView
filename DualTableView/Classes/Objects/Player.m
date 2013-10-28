//
//  Player.m
//  DualTableView
//
//  Created by Shintaro Kaneko on 10/27/13.
//  Copyright (c) 2013 Muukii. All rights reserved.
//

#import "Player.h"

#import "MAppDelegate.h"

NSString *const kMPlayerObjectIdKey = @"id";
NSString *const kMPlayerObjectAvatarUrlKey = @"avatar_url";
NSString *const kMPlayerObjectCommentsCountKey = @"comments_count";
NSString *const kMPlayerObjectCommentsReceivedCountKey = @"comments_received_count";
NSString *const kMPlayerObjectCreatedAtKey = @"created_at";
NSString *const kMPlayerObjectDraftedByPlayerIdKey = @"drafted_by_player_id";
NSString *const kMPlayerObjectDrafteesCountKey = @"draftees_count";
NSString *const kMPlayerObjectFollowersCountKey = @"followers_count";
NSString *const kMPlayerObjectFollowingCountKey = @"following_count";
NSString *const kMPlayerObjectLikesCountKey = @"likes_count";
NSString *const kMPlayerObjectLikesReceivedCountKey = @"likes_received_count";
NSString *const kMPlayerObjectLocationKey = @"location";
NSString *const kMPlayerObjectNameKey = @"name";
NSString *const kMPlayerObjectReboundsCountKey = @"rebounds_count";
NSString *const kMPlayerObjectReboundsReceivedCountKey = @"rebounds_received_count";
NSString *const kMPlayerObjectShotsCountKey = @"shots_count";
NSString *const kMPlayerObjectTwitterScreenNameKey = @"twitter_screen_name";
NSString *const kMPlayerObjectUrlKey = @"url";
NSString *const kMPlayerObjectUsernameKey = @"username";
NSString *const kMPlayerObjectWebsiteUrlKey = @"website_url";

@implementation Player

@dynamic commentsCount;
@dynamic createdAt;
@dynamic identity;
@dynamic likesCount;
@dynamic reboundsCount;
@dynamic url;
@dynamic name;
@dynamic username;
@dynamic twitterScreenName;
@dynamic location;
@dynamic websiteUrl;
@dynamic avaterUrl;
@dynamic commentsReceivedCount;
@dynamic likesReceivedCount;
@dynamic reboundsReceivedCount;
@dynamic shotsCount;
@dynamic drafteesCount;
@dynamic followersCount;
@dynamic followingCount;
@dynamic draftedByPlayerId;
@dynamic shots;

+ (Player *)insertByDictionary:(NSDictionary *)dictionary withShots:(NSArray *)shots
{
    MAppDelegate *appDelegate = (MAppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    
    Player *player = (Player *)[NSEntityDescription insertNewObjectForEntityForName:[self entityName]
                                                             inManagedObjectContext:managedObjectContext];
    
    player.commentsCount            = [dictionary numberForKey:kMPlayerObjectCommentsCountKey];
    player.createdAt                = [[dictionary stringForKey:kMPlayerObjectCreatedAtKey] convertDate];
    player.identity                 = [dictionary numberForKey:kMPlayerObjectIdKey];
    player.likesCount               = [dictionary numberForKey:kMPlayerObjectLikesCountKey];
    player.reboundsCount            = [dictionary numberForKey:kMPlayerObjectReboundsCountKey];
    player.url                      = [dictionary stringForKey:kMPlayerObjectUrlKey];
    player.name                     = [dictionary stringForKey:kMPlayerObjectNameKey];
    player.username                 = [dictionary stringForKey:kMPlayerObjectUsernameKey];
    player.twitterScreenName        = [dictionary stringForKey:kMPlayerObjectTwitterScreenNameKey];
    player.location                 = [dictionary stringForKey:kMPlayerObjectLocationKey];
    player.websiteUrl               = [dictionary stringForKey:kMPlayerObjectWebsiteUrlKey];
    player.avaterUrl                = [dictionary stringForKey:kMPlayerObjectAvatarUrlKey];
    player.commentsReceivedCount    = [dictionary numberForKey:kMPlayerObjectCommentsReceivedCountKey];
    player.likesReceivedCount       = [dictionary numberForKey:kMPlayerObjectLikesReceivedCountKey];
    player.reboundsReceivedCount    = [dictionary numberForKey:kMPlayerObjectReboundsReceivedCountKey];
    player.shotsCount               = [dictionary numberForKey:kMPlayerObjectShotsCountKey];
    player.drafteesCount            = [dictionary numberForKey:kMPlayerObjectDrafteesCountKey];
    player.followersCount           = [dictionary numberForKey:kMPlayerObjectFollowersCountKey];
    player.followingCount           = [dictionary numberForKey:kMPlayerObjectFollowingCountKey];
    player.draftedByPlayerId        = [dictionary numberForKey:kMPlayerObjectDraftedByPlayerIdKey];
    player.shotsCount               = [dictionary numberForKey:kMPlayerObjectShotsCountKey];
    
    [player addShots:[NSSet setWithArray:shots]];
    
    NSError *error = nil;
    if ([managedObjectContext save:&error]) {
        return player;
    } else {
        DLog(@"Error: CoreData, %@", error.localizedDescription);
        return nil;
    }
}

- (void)updateByDictionary:(NSDictionary *)dictionary
{
    MAppDelegate *appDelegate = (MAppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    
    self.commentsCount            = [dictionary numberForKey:kMPlayerObjectCommentsCountKey];
    self.createdAt                = [[dictionary stringForKey:kMPlayerObjectCreatedAtKey] convertDate];
    self.identity                 = [dictionary numberForKey:kMPlayerObjectIdKey];
    self.likesCount               = [dictionary numberForKey:kMPlayerObjectLikesCountKey];
    self.reboundsCount            = [dictionary numberForKey:kMPlayerObjectReboundsCountKey];
    self.url                      = [dictionary stringForKey:kMPlayerObjectUrlKey];
    self.name                     = [dictionary stringForKey:kMPlayerObjectNameKey];
    self.username                 = [dictionary stringForKey:kMPlayerObjectUsernameKey];
    self.twitterScreenName        = [dictionary stringForKey:kMPlayerObjectTwitterScreenNameKey];
    self.location                 = [dictionary stringForKey:kMPlayerObjectLocationKey];
    self.websiteUrl               = [dictionary stringForKey:kMPlayerObjectWebsiteUrlKey];
    self.avaterUrl                = [dictionary stringForKey:kMPlayerObjectAvatarUrlKey];
    self.commentsReceivedCount    = [dictionary numberForKey:kMPlayerObjectCommentsReceivedCountKey];
    self.likesReceivedCount       = [dictionary numberForKey:kMPlayerObjectLikesReceivedCountKey];
    self.reboundsReceivedCount    = [dictionary numberForKey:kMPlayerObjectReboundsReceivedCountKey];
    self.shotsCount               = [dictionary numberForKey:kMPlayerObjectShotsCountKey];
    self.drafteesCount            = [dictionary numberForKey:kMPlayerObjectDrafteesCountKey];
    self.followersCount           = [dictionary numberForKey:kMPlayerObjectFollowersCountKey];
    self.followingCount           = [dictionary numberForKey:kMPlayerObjectFollowingCountKey];
    self.draftedByPlayerId        = [dictionary numberForKey:kMPlayerObjectDraftedByPlayerIdKey];
    self.shotsCount               = [dictionary numberForKey:kMPlayerObjectShotsCountKey];
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        DLog(@"Error: CoreData, %@", error.localizedDescription);
    }
}

@end

@implementation Player (State)

- (BOOL)hasComments
{
    return self.commentsCount.integerValue > 0;
}

- (BOOL)hasCommentsReceived
{
    return self.commentsReceivedCount.integerValue > 0;
}

- (BOOL)hasDraftees
{
    return self.drafteesCount.integerValue > 0;
}

- (BOOL)hasFollowers
{
    return self.followersCount.integerValue > 0;
}

- (BOOL)hasFollowing
{
    return self.followingCount.integerValue > 0;
}

- (BOOL)hasLikes
{
    return self.likesCount.integerValue > 0;
}

- (BOOL)hasLikesReceived
{
    return self.likesReceivedCount.integerValue > 0;
}

- (BOOL)hasRebounds
{
    return self.reboundsCount.integerValue > 0;
}

- (BOOL)hasReboundsReceived
{
    return self.reboundsReceivedCount.integerValue > 0;
}

-(BOOL)hasShots
{
    return self.shotsCount.integerValue > 0;
}

@end