//
//  MBaseModel.h
//  DualTableView
//
//  Created by Shintaro Kaneko on 10/27/13.
//  Copyright (c) 2013 Muukii. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MModelHelper.h"

@interface MBaseModel : NSObject

- (void)commonCompletionWithResponse:(NSURLResponse *)response
                                data:(NSData *)data
                               error:(NSError *)error
                      successHandler:(successHandler)successHandler
                        errorHandler:(errorHandler)errorHandler;

- (void)sendRequest:(NSURLRequest *)request completionHandler:(completionHandler)completion;;

@end
