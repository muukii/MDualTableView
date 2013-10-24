//
//  MDualTableViewCell.h
//  DualTableView
//
//  Created by Muukii on 10/24/13.
//  Copyright (c) 2013 Muukii. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDualTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
+ (UINib *)nib;
- (CGFloat)heightOfRow;
+ (CGFloat)heightOfRow;
@end
