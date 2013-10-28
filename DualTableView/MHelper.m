//
//  MHelper.m
//  DualTableView
//
//  Created by Shintaro Kaneko on 10/27/13.
//  Copyright (c) 2013 Muukii. All rights reserved.
//

#import "MHelper.h"

@implementation MHelper
@end

@implementation NSDictionary (Extension)

- (NSString *)stringForKey:(NSString *)aKey
{
    id object = [self objectForKey:aKey];
    if (nil != object && ![object isEqual:[NSNull null]]) {
        return [NSString stringWithString:object];
    }
    return @"";
}

- (NSNumber *)numberForKey:(NSString *)aKey
{
    return [NSNumber numberWithInteger:[self integerForKey:aKey]];
}

- (NSInteger)integerForKey:(NSString *)aKey
{
    id object = [self objectForKey:aKey];
    if (nil != object && ![object isEqual:[NSNull null]]) {
        return [object integerValue];
    }
    return 0;
}

@end

@implementation NSString (Convert)

- (NSDate *)convertDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss Z"];
    return [dateFormatter dateFromString:self];
}

@end

@implementation UIImageView (Extension)

- (void)setFadedImage:(UIImage *)image
{
    [self setAlpha:0.0];
    [self setImage:image];
    [UIView animateWithDuration:.2f
                          delay:.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self setAlpha:1.0];
                     } completion:^(BOOL finished) {
                         if (finished) {
                         }
                     }];
}

@end

