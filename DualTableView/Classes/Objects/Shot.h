//
//  Shot.h
//  DualTableView
//
//  Created by Shintaro Kaneko on 10/27/13.
//  Copyright (c) 2013 Muukii. All rights reserved.
//

#import "MManagedObject.h"

#import <Foundation/Foundation.h>

UIKIT_EXTERN NSString *const kMShotObjectIdKey;
UIKIT_EXTERN NSString *const kMShotObjectCreatedAtKey;

@class Player;

@interface Shot : MManagedObject

@property (nonatomic, retain) NSNumber * identity;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * shortUrl;
@property (nonatomic, retain) NSNumber * likesCount;
@property (nonatomic, retain) NSNumber * commentsCount;
@property (nonatomic, retain) NSNumber * viewsCount;
@property (nonatomic, retain) NSNumber * reboundsCount;
@property (nonatomic, retain) NSNumber * reboundSourceId;
@property (nonatomic, retain) NSString * imageUrl;
@property (nonatomic, retain) NSString * image400Url;
@property (nonatomic, retain) NSString * imageTeaserUrl;
@property (nonatomic, retain) NSNumber * height;
@property (nonatomic, retain) NSNumber * width;
@property (nonatomic, retain) Player *player;

@property (strong, nonatomic) UIImage *cacheImage;

+ (Shot *)insertByDictionary:(NSDictionary *)dictionary;
- (void)updateByDictionary:(NSDictionary *)dictionary;

@end

@interface Shot (State)

@property (assign, nonatomic, getter = hasLikes, readonly) BOOL likes;
@property (assign, nonatomic, getter = hasComments, readonly) BOOL comments;
@property (assign, nonatomic, getter = hasViews, readonly) BOOL views;
@property (assign, nonatomic, getter = hasRebounds, readonly) BOOL rebounds;
@property (assign, nonatomic, getter = isVerticallyLong, readonly) BOOL verticallyLong;

@end