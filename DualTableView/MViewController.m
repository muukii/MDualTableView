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
@interface MViewController () <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet MLeftTableView *leftTableView;
@property (weak, nonatomic) IBOutlet MRightTableView *rightTableView;

@end

@implementation MViewController
{
    NSMutableArray *_leftArray,*_rightArray;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.leftTableView registerNib:[MDualTableViewCell nib] forCellReuseIdentifier:NSStringFromClass([MDualTableViewCell class])];
    [self.rightTableView registerNib:[MDualTableViewCell nib] forCellReuseIdentifier:NSStringFromClass([MDualTableViewCell class])];

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isKindOfClass:[MRightTableView class]]) {
        return 243;
    } else if ([tableView isKindOfClass:[MLeftTableView class]]){
        return 140;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MDualTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MDualTableViewCell class])];
    
    NSLog(@"%@",NSStringFromClass([tableView class]));
    if ([tableView isKindOfClass:[MRightTableView class]]) {
        cell.mainLabel.text = @"right";
    } else if ([tableView isKindOfClass:[MLeftTableView class]]){
        cell.mainLabel.text = @"left";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
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

@end
