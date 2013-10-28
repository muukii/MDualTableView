//
//  MModelHelper.m
//  DualTableView
//
//  Created by Shintaro Kaneko on 10/27/13.
//  Copyright (c) 2013 Muukii. All rights reserved.
//

#import "MModelHelper.h"

const CGFloat kMTimeoutInterval = 15.f;

@implementation MModelHelper

+ (NSURLRequest *)requestWithURLString:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestReloadIgnoringCacheData
                                         timeoutInterval:kMTimeoutInterval];
    return request;
}

+ (NSURLRequest *)requestWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters
{
    NSMutableString *queries = [NSMutableString string];
    for (NSString *key in parameters.keyEnumerator) {
        [queries appendFormat:@"%@=%@", key, [parameters objectForKey:key]];
    }
    NSString *urlWithQueriesString = [NSString stringWithFormat:@"%@?%@", urlString, queries];
    return [MModelHelper requestWithURLString:urlWithQueriesString];
}

+ (void)sendRequest:(NSURLRequest *)request queue:(NSOperationQueue *)queue completionHandler:(completionHandler)completion
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	[NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                               completion(response, data, error);
                           }];
}


+ (NSInteger)statusCodeOnURLResponse:(NSURLResponse *)response
{
    NSInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
    if (kHTTPStatusOK == statusCode) {
        NSLog(@"Success: Connected to the Internet.");
    } else if (kHTTPStatusBadRequest == statusCode) {
        NSLog(@"Failure: Bad Requests.");
    } else {
        NSLog(@"Failure: Something went wrong, code => %d.", (int)statusCode);
    }
    return statusCode;
}

+ (CFNetworkErrors)checkErrorForResponse:(NSError *)error
{
    CFNetworkErrors code = (int)error.code;
    NSLog(@"Request got a network error, code => %d", code);
    if (kCFURLErrorNotConnectedToInternet == code) {
        NSLog(@"Failure: Failed to connect to the Internet.");
    }
    NSLog(@"Error description: %@", error.localizedDescription);
    return code;
}

+ (BOOL)isErrorOnJSONSerialization:(NSError *)error
{
    if (error) {
        NSInteger code = error.code;
        NSLog(@"JSON serialization error, code => %d", (int)code);
        NSLog(@"JSON serialization error, description: %@", error.localizedDescription);
        return YES;
    }
    return NO;
}

+ (void)invalidStatusCodeOnURLResponseWithError:(NSError *)error
{
    if (error) {
        CFNetworkErrors code = [self checkErrorForResponse:error];
        NSLog(@"NSURLConnection: Something went wrong, code => %d", code);
    } else {
        NSLog(@"%@", error);
    }
}


@end