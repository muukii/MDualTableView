//
//  MDribbbleManager.h
//  DualTableView
//
//  Created by Shintaro Kaneko on 10/27/13.
//  Copyright (c) 2013 Muukii. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDribbbleManager : NSObject
@property (assign, nonatomic) NSInteger page;
@property (assign, nonatomic) NSInteger pages;
@property (assign, nonatomic) NSInteger perPage;
@property (assign, nonatomic) NSInteger total;

+ (MDribbbleManager *)sharedManager;
- (void)bundleWithDictionary:(NSDictionary *)dictionary;

@end
