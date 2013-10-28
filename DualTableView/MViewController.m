//
//  MViewController.m
//  DualTableView
//
//  Created by Muukii on 10/24/13.
//  Copyright (c) 2013 Muukii. All rights reserved.
//

#import "MViewController.h"
#import "MDualTableViewCell.h"

#import "MTableView.h"
#import "MAppDelegate.h"
#import "MDribbbleManager.h"
#import "MDribbbleModel.h"
#import "Shot.h"

@interface MViewController () <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate, NSFetchedResultsControllerDelegate>
@property (weak, nonatomic) IBOutlet MLeftTableView *leftTableView;
@property (weak, nonatomic) IBOutlet MRightTableView *rightTableView;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (assign, nonatomic) NSUInteger page;
@property (assign, nonatomic) BOOL loading;
- (void)fetchShots;
@end

@implementation MViewController
{
    NSMutableArray *_leftArray,*_rightArray;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.page = 1;
    self.loading = NO;
    [self.leftTableView registerNib:[MDualTableViewCell nib] forCellReuseIdentifier:NSStringFromClass([MDualTableViewCell class])];
    [self.rightTableView registerNib:[MDualTableViewCell nib] forCellReuseIdentifier:NSStringFromClass([MDualTableViewCell class])];

    [self fetchShots];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchShots
{
    self.loading = YES;
    [[MDribbbleModel sharedManager] shotsWithType:MDribbbleShotsDebuts
                                       parameters:@{@"page": @(self.page)}
                                   successHandler:^(id userInfo) {
                                       [[MDribbbleManager sharedManager] bundleWithDictionary:userInfo];
                                       [self.fetchedResultsController performFetch:nil];
                                       [self.leftTableView reloadData];
                                       [self.rightTableView reloadData];
                                       self.loading = NO;
                                   } errorHandler:^(NSError *error) {
                                       self.loading = NO;
                                       DLog(@"Error: %@", error.localizedDescription);
                                   }];
}

#pragma mark -
#pragma mark TableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isKindOfClass:[MRightTableView class]]) {
    } else if ([tableView isKindOfClass:[MLeftTableView class]]) {
    }
    return [[self.fetchedResultsController.sections objectAtIndex:section] numberOfObjects];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isKindOfClass:[MRightTableView class]]) {
    } else if ([tableView isKindOfClass:[MLeftTableView class]]) {
    }
    return 243;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MDualTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MDualTableViewCell class])];
    if ([tableView isKindOfClass:[MRightTableView class]]) {
    } else if ([tableView isKindOfClass:[MLeftTableView class]]) {
    }
    Shot *shot = (Shot *)[self.fetchedResultsController objectAtIndexPath:indexPath];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (!shot.cacheImage) {
            shot.cacheImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:shot.image400Url]]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [cell.mainImageView setFadedImage:shot.cacheImage];
            cell.mainLabel.text = shot.title;
        });
    });
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.loading) {
        self.loading = YES;
        if ([[self.fetchedResultsController.sections objectAtIndex:0] numberOfObjects] - 1 == indexPath.row) {
            self.page++;
            [self fetchShots];
        } else {
            self.loading = NO;
        }
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


#pragma mark ScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.rightTableView setContentOffset:scrollView.contentOffset];
    [self.leftTableView setContentOffset:scrollView.contentOffset];
}

#pragma mark -
#pragma mark Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    MAppDelegate *appDelegate = (MAppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:[Shot entityName]
                                              inManagedObjectContext:appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    [fetchRequest setFetchBatchSize:20];

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"createdAt"
                                                                   ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    [fetchRequest setSortDescriptors:sortDescriptors];
       
    // NSPredicate *predicate = [NSPredicate predicateWithFormat:@" == %@", @""];
    // [fetchRequest setPredicate:predicate];
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                                managedObjectContext:appDelegate.managedObjectContext
                                                                                                  sectionNameKeyPath:nil
                                                                                                           cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
        DLog(@"Error: Fetching from CoreData, %@", error.localizedDescription);
	}
    return _fetchedResultsController;
}

@end
