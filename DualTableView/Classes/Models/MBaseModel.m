//
//  MBaseModel.m
//  DualTableView
//
//  Created by Shintaro Kaneko on 10/27/13.
//  Copyright (c) 2013 Muukii. All rights reserved.
//

#import "MBaseModel.h"

@interface MBaseModel ()
@property (nonatomic, strong) NSOperationQueue *requestQueue;
@end

@implementation MBaseModel

-(id)init
{
    self = [super init];
    if (self) {
        self.requestQueue = [[NSOperationQueue alloc] init];
    }
    return self;
}

- (void)commonCompletionWithResponse:(NSURLResponse *)response
                                data:(NSData *)data
                               error:(NSError *)error
                      successHandler:(successHandler)successHandler
                        errorHandler:(errorHandler)errorHandler
{
    NSInteger statusCode = [MModelHelper  statusCodeOnURLResponse:response];
    switch (statusCode) {
        case kHTTPStatusOK: {
            if (data) {
                NSError *error = nil;
                NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                           options:NSJSONReadingAllowFragments
                                                                             error:&error];
                if (![MModelHelper isErrorOnJSONSerialization:error]) {
                    successHandler(dictionary);
                } else {
                    errorHandler(error);
                }
            }
            break;
        }
        case kHTTPStatusBadRequest: {
            errorHandler(error);
            break;
        }
        default: {
            [MModelHelper invalidStatusCodeOnURLResponseWithError:error];
            errorHandler(error);
            break;
        }
    }
}

- (void)sendRequest:(NSURLRequest *)request completionHandler:(completionHandler)completion
{
    [MModelHelper sendRequest:request queue:self.requestQueue completionHandler:completion];
}

@end
