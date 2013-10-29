//
//  MHelper.h
//  DualTableView
//
//  Created by Shintaro Kaneko on 10/27/13.
//  Copyright (c) 2013 Muukii. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG
# define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
# define DLog(...)
#endif

@interface MHelper : NSObject
@end

@interface NSDictionary (Extension)

- (NSString *)stringForKey:(NSString *)aKey;
- (NSInteger)integerForKey:(NSString *)aKey;
- (NSNumber *)numberForKey:(NSString *)aKey;

@end

@interface NSString (Convert)

- (NSDate *)convertDate;

@end

@interface UIImageView (Extension)

- (void)setFadedImage:(UIImage *)image;

@end