//
//  MDribbbleModel.m
//  DualTableView
//
//  Created by Shintaro Kaneko on 10/27/13.
//  Copyright (c) 2013 Muukii. All rights reserved.
//

#import "MDribbbleModel.h"

NSString *const kMDribbbleEndpoint = @"http://api.dribbble.com";

NSString *const kMDribbbleShots = @"shots";
NSString *const kMDribbbleDebugts = @"debuts";
NSString *const kMDribbbleEveryone = @"everyone";
NSString *const kMDribbblePopular = @"popular";

@interface MDribbbleModel ()
@end

@implementation MDribbbleModel

static MDribbbleModel *_sharedInstance = nil;

+ (MDribbbleModel *)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[MDribbbleModel alloc] init];
    });
    return _sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)shotsWithType:(MDribbbleShotsType)type
           parameters:(NSDictionary *)parameters
       successHandler:(successHandler)successHandler
         errorHandler:(errorHandler)errorHandler
{
    switch (type) {
        case MDribbbleShotsDebuts: {
            [self debutsShotsWithParameters:parameters successHandler:successHandler errorHandler:errorHandler];
            break;
        }
        case MDribbbleShotsEveryone: {
            [self everyoneShotsWithParameters:parameters successHandler:successHandler errorHandler:errorHandler];
            break;
        }
        case MDribbbleShotsPopular: {
            [self popularShotsWithParameters:parameters successHandler:successHandler errorHandler:errorHandler];
            break;
        }
    }
}


#pragma mark -
#pragma mark Private methods

- (void)debutsShotsWithParameters:(NSDictionary *)parameters
                   successHandler:(successHandler)successHandler
                     errorHandler:(errorHandler)errorHandler
{
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/%@", kMDribbbleEndpoint, kMDribbbleShots, kMDribbbleDebugts];
    NSURLRequest *request = [MModelHelper requestWithURLString:urlString parameters:parameters];
    void (^completion)(NSURLResponse *response, NSData *data, NSError *error) = ^(NSURLResponse *response, NSData *data, NSError *error)
    {
        [super commonCompletionWithResponse:response
                                       data:data
                                      error:error
                             successHandler:successHandler
                               errorHandler:errorHandler];
    };
    [super sendRequest:request completionHandler:completion];
}

- (void)everyoneShotsWithParameters:(NSDictionary *)parameters
                     successHandler:(successHandler)successHandler
                       errorHandler:(errorHandler)errorHandler
{
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/%@", kMDribbbleEndpoint, kMDribbbleShots, kMDribbbleEveryone];
    NSURLRequest *request = [MModelHelper requestWithURLString:urlString parameters:parameters];
    void (^completion)(NSURLResponse *response, NSData *data, NSError *error) = ^(NSURLResponse *response, NSData *data, NSError *error)
    {
        [super commonCompletionWithResponse:response
                                       data:data
                                      error:error
                             successHandler:successHandler
                               errorHandler:errorHandler];
    };
    [super sendRequest:request completionHandler:completion];
}

- (void)popularShotsWithParameters:(NSDictionary *)parameters
                    successHandler:(successHandler)successHandler
                      errorHandler:(errorHandler)errorHandler
{
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/%@", kMDribbbleEndpoint, kMDribbbleShots, kMDribbblePopular];
    NSURLRequest *request = [MModelHelper requestWithURLString:urlString parameters:parameters];
    void (^completion)(NSURLResponse *response, NSData *data, NSError *error) = ^(NSURLResponse *response, NSData *data, NSError *error)
    {
        [super commonCompletionWithResponse:response
                                       data:data
                                      error:error
                             successHandler:successHandler
                               errorHandler:errorHandler];
    };
    [super sendRequest:request completionHandler:completion];
}

@end

@implementation MDribbbleModel (Test)

- (void)testShotsWithParameters:(NSDictionary *)parameters
                 successHandler:(successHandler)successHandler
                   errorHandler:(errorHandler)errorHandler
{
    NSMutableArray *objects = [NSMutableArray array];
    for (NSInteger i = 0, n = 15; i < n; ++i) {
        [objects addObject:[self testDribbbleObject]];
    }
    NSDictionary *dictionary = @{@"page": @"1",
                                 @"pages": @"50",
                                 @"per_page": @"15",
                                 @"total": @"750",
                                 @"shots": objects
                                 };
    successHandler(dictionary);
}

- (NSDictionary *)testDribbbleObject
{
    return @{@"comments_count": @"1",
             @"created_at": @"2013/10/26 07:59:43 -0400",
             @"height": @"600",
             @"id": @"1287386",
             @"image_400_url": @"http://dribbble.s3.amazonaws.com/users/304961/screenshots/1287386/sds_spanget_1x.png",
             @"image_teaser_url": @"http://dribbble.s3.amazonaws.com/users/304961/screenshots/1287386/sds_spanget_teaser.png",
             @"image_url": @"http://dribbble.s3.amazonaws.com/users/304961/screenshots/1287386/sds_spanget.png",
             @"likes_count": @"1",
             @"player": @{
                     @"avatar_url": @"http://dribbble.s3.amazonaws.com/users/304961/avatars/normal/vimeo_spanget.gif?1364375916",
                     @"comments_count": @"2",
                     @"comments_received_count": @"1",
                     @"created_at": @"2013/03/27 05:15:57 -0400",
                     @"drafted_by_player_id": @"9426",
                     @"draftees_count": @"0",
                     @"followers_count": @"2",
                     @"following_count": @"8",
                     @"id": @"304961",
                     @"likes_count": @"27",
                     @"likes_received_count": @"1",
                     @"location": @"Copenhagen, Denmark",
                     @"name": @"Louise Spanget",
                     @"rebounds_count": @"0",
                     @"rebounds_received_count": @"0",
                     @"shots_count": @"1",
                     @"twitter_screen_name": [NSNull null],
                     @"url": @"http://dribbble.com/spanget",
                     @"username": @"spanget",
                     @"website_url": @"http://cargcollective.com/spanget",
                     },
             @"rebound_source_id": [NSNull null],
             @"rebounds_count": @"0",
             @"short_url": @"http://drbl.in/jifw",
             @"title": @"Logo for 'sds' ",
             @"url": @"http://dribbble.com/shots/1287386-Logo-for-sds",
             @"views_count": @"11",
             @"width": @"800"
             };
}


@end
