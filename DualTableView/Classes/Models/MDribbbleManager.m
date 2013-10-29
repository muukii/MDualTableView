//
//  MDribbbleManager.m
//  DualTableView
//
//  Created by Shintaro Kaneko on 10/27/13.
//  Copyright (c) 2013 Muukii. All rights reserved.
//

#import "MDribbbleManager.h"

#import "Shot.h"

NSString *const kMDribbbleManagerPageKey = @"page";
NSString *const kMDribbbleManagerPagesKey = @"pages";
NSString *const kMDribbbleManagerPerPageKey = @"per_page";
NSString *const kMDribbbleManagerTotalKey = @"total";
NSString *const kMDribbbleManagerShotsKey = @"shots";

@interface MDribbbleManager ()
@end

@implementation MDribbbleManager

static MDribbbleManager *_sharedInstance = nil;

+ (MDribbbleManager *)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[MDribbbleManager alloc] init];
    });
    return _sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.page = 0;
        self.pages = 0;
        self.perPage = 0;
        self.total = 0;
    }
    return self;
}

- (void)bundleWithDictionary:(NSDictionary *)dictionary
{
    self.page = [dictionary integerForKey:kMDribbbleManagerPageKey];
    self.pages = [dictionary integerForKey:kMDribbbleManagerPagesKey];
    self.perPage = [dictionary integerForKey:kMDribbbleManagerPerPageKey];
    self.total = [dictionary integerForKey:kMDribbbleManagerTotalKey];
    NSMutableArray *array = [NSMutableArray arrayWithArray:[dictionary objectForKey:kMDribbbleManagerShotsKey]];
    for (NSDictionary *dictionary in array) {
        NSString *identity = [dictionary objectForKey:kMShotObjectIdKey];
        Shot *shot = [Shot findByIdentity:identity];
        if (!shot) {
            shot = [Shot insertByDictionary:dictionary];
        } else {
            [shot updateByDictionary:dictionary];
        }
    }
}

@end
