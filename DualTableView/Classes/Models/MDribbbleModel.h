//
//  MDribbbleModel.h
//  DualTableView
//
//  Created by Shintaro Kaneko on 10/27/13.
//  Copyright (c) 2013 Muukii. All rights reserved.
//

#import "MBaseModel.h"

typedef NS_ENUM(NSInteger, MDribbbleShotsType) {
    MDribbbleShotsDebuts,
    MDribbbleShotsEveryone,
    MDribbbleShotsPopular,
};

@interface MDribbbleModel : MBaseModel
+ (MDribbbleModel *)sharedManager;
- (void)shotsWithType:(MDribbbleShotsType)type
           parameters:(NSDictionary *)parameters
       successHandler:(successHandler)successHandler
         errorHandler:(errorHandler)errorHandler;
@end

@interface MDribbbleModel (Test)
- (void)testShotsWithParameters:(NSDictionary *)parameters
                 successHandler:(successHandler)successHandler
                   errorHandler:(errorHandler)errorHandler;
@end