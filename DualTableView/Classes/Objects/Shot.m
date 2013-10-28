//
//  Shot.m
//  DualTableView
//
//  Created by Shintaro Kaneko on 10/27/13.
//  Copyright (c) 2013 Muukii. All rights reserved.
//

#import "Shot.h"
#import "Player.h"

#import "MAppDelegate.h"

NSString *const kMShotObjectIdKey = @"id";
NSString *const kMShotObjectTitleKey = @"title";
NSString *const kMShotObjectUrlKey = @"url";
NSString *const kMShotObjectShortUrlKey = @"short_url";
NSString *const kMShotObjectLikesCountKey = @"likes_count";
NSString *const kMShotObjectCommentsCountKey = @"comments_count";
NSString *const kMShotObjectViewsCountKey = @"views_count";
NSString *const kMShotObjectCreatedAtKey = @"created_at";
NSString *const kMShotObjectHeightKey = @"height";
NSString *const kMShotObjectWidthKey = @"width";
NSString *const kMShotObjectImage400UrlKey = @"image_400_url";
NSString *const kMShotObjectImageTeaserUrlKey = @"image_teaser_url";
NSString *const kMShotObjectImageUrlKey = @"image_url";
NSString *const kMShotObjectReboundSourceIdKey = @"rebound_source_id";
NSString *const kMShotObjectReboundsCountKey = @"rebounds_count";
NSString *const kMShotObjectPlayerKey = @"player";

@implementation Shot

@dynamic identity;
@dynamic title;
@dynamic createdAt;
@dynamic url;
@dynamic shortUrl;
@dynamic likesCount;
@dynamic commentsCount;
@dynamic viewsCount;
@dynamic reboundsCount;
@dynamic reboundSourceId;
@dynamic imageUrl;
@dynamic image400Url;
@dynamic imageTeaserUrl;
@dynamic height;
@dynamic width;
@dynamic player;

@synthesize cacheImage;

+ (Shot *)insertByDictionary:(NSDictionary *)dictionary
{
    MAppDelegate *appDelegate = (MAppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    
    Shot *shot = (Shot *)[NSEntityDescription insertNewObjectForEntityForName:[self entityName]
                                                       inManagedObjectContext:managedObjectContext];

    shot.identity           = [dictionary numberForKey:kMShotObjectIdKey];
    shot.title              = [dictionary stringForKey:kMShotObjectTitleKey];
    shot.createdAt          = [[dictionary stringForKey:kMShotObjectCreatedAtKey] convertDate];
    shot.url                = [dictionary stringForKey:kMShotObjectUrlKey];
    shot.shortUrl           = [dictionary stringForKey:kMShotObjectShortUrlKey];
    shot.likesCount         = [dictionary numberForKey:kMShotObjectLikesCountKey];
    shot.commentsCount      = [dictionary numberForKey:kMShotObjectCommentsCountKey];
    shot.viewsCount         = [dictionary numberForKey:kMShotObjectViewsCountKey];
    shot.reboundsCount      = [dictionary numberForKey:kMShotObjectReboundsCountKey];
    shot.reboundSourceId    = [dictionary numberForKey:kMShotObjectReboundSourceIdKey];
    shot.imageUrl           = [dictionary stringForKey:kMShotObjectImageUrlKey];
    shot.image400Url        = [dictionary stringForKey:kMShotObjectImage400UrlKey];
    shot.imageTeaserUrl     = [dictionary stringForKey:kMShotObjectImageTeaserUrlKey];
    shot.height             = [dictionary numberForKey:kMShotObjectHeightKey];
    shot.width              = [dictionary numberForKey:kMShotObjectWidthKey];
    
    NSString *identity = [[dictionary objectForKey:kMShotObjectPlayerKey] objectForKey:kMPlayerObjectIdKey];
    Player *player = [Player findByIdentity:identity];
    if (!player) {
        player = [Player insertByDictionary:[dictionary objectForKey:kMShotObjectPlayerKey]
                                  withShots:@[]];
    }
    shot.player = player;

    NSError *error = nil;
    if ([managedObjectContext save:&error]) {
        return shot;
    } else {
        DLog(@"Error: CoreData, %@", error.localizedDescription);
        return nil;
    }
}

- (void)updateByDictionary:(NSDictionary *)dictionary
{
    MAppDelegate *appDelegate = (MAppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    
    self.identity           = [dictionary numberForKey:kMShotObjectIdKey];
    self.title              = [dictionary stringForKey:kMShotObjectTitleKey];
    self.createdAt          = [[dictionary stringForKey:kMShotObjectCreatedAtKey] convertDate];
    self.url                = [dictionary stringForKey:kMShotObjectUrlKey];
    self.shortUrl           = [dictionary stringForKey:kMShotObjectShortUrlKey];
    self.likesCount         = [dictionary numberForKey:kMShotObjectLikesCountKey];
    self.commentsCount      = [dictionary numberForKey:kMShotObjectCommentsCountKey];
    self.viewsCount         = [dictionary numberForKey:kMShotObjectViewsCountKey];
    self.reboundsCount      = [dictionary numberForKey:kMShotObjectReboundsCountKey];
    self.reboundSourceId    = [dictionary numberForKey:kMShotObjectReboundSourceIdKey];
    self.imageUrl           = [dictionary stringForKey:kMShotObjectImageUrlKey];
    self.image400Url        = [dictionary stringForKey:kMShotObjectImage400UrlKey];
    self.imageTeaserUrl     = [dictionary stringForKey:kMShotObjectImageTeaserUrlKey];
    self.height             = [dictionary numberForKey:kMShotObjectHeightKey];
    self.width              = [dictionary numberForKey:kMShotObjectWidthKey];
    
    [self.player updateByDictionary:[dictionary objectForKey:kMShotObjectPlayerKey]];
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        DLog(@"Error: CoreData, %@", error.localizedDescription);
    }
}

@end

@implementation Shot (State)

- (BOOL)hasComments
{
    return self.commentsCount.integerValue > 0;
}

- (BOOL)hasLikes
{
    return self.likesCount.integerValue > 0;
}

- (BOOL)hasRebounds
{
    return self.reboundsCount.integerValue > 0;
}

- (BOOL)hasViews
{
    return self.viewsCount.integerValue > 0;
}

- (BOOL)isVerticallyLong
{
    return self.height.integerValue > self.width.integerValue;
}

@end