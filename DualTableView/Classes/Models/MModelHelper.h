//
//  MModelHelper.h
//  DualTableView
//
//  Created by Shintaro Kaneko on 10/27/13.
//  Copyright (c) 2013 Muukii. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^successHandler)(id userInfo);
typedef void(^errorHandler)(NSError *error);
typedef void(^completionHandler)(NSURLResponse *response, NSData *data, NSError *error);

typedef NS_ENUM(NSInteger, HTTPStatusCode) {
   kHTTPStatusOK = 200,
   kHTTPStatusBadRequest = 400
};

@interface MModelHelper : NSObject
+ (NSURLRequest *)requestWithURLString:(NSString *)urlString;
+ (NSURLRequest *)requestWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters;
+ (void)sendRequest:(NSURLRequest *)request queue:(NSOperationQueue *)queue completionHandler:(completionHandler)completion;
+ (NSInteger)statusCodeOnURLResponse:(NSURLResponse *)response;
+ (CFNetworkErrors)checkErrorForResponse:(NSError *)error;
+ (BOOL)isErrorOnJSONSerialization:(NSError *)error;
+ (void)invalidStatusCodeOnURLResponseWithError:(NSError *)error;
@end