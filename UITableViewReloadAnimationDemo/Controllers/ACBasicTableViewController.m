//
//  ACBasicTableViewController.m
//  UITableViewReloadAnimationDemo
//
//  Created by Avalon on 15/8/3.
//  Copyright (c) 2015年 Hank. All rights reserved.
//

#import "ACBasicTableViewController.h"
#import "ACBasicTableViewCell.h"

static NSString * const kBasicCellIdentifier = @"BasicCellID";

@interface ACBasicTableViewController ()

@property (strong, nonatomic) NSMutableArray *images;

@end

@implementation ACBasicTableViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.images = [NSMutableArray array];
    for (NSInteger i = 1; i <= 7; i++) {
        [self.images addObject:[NSString stringWithFormat:@"cell-background%ld",(long)i]];
    }
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadTableView)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadDataWithAnimationStyle:_animationStyle];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.tableView.backgroundColor = [UIColor colorWithRed:225.0/255 green:225.0/255 blue:235.0/255 alpha:1.0];
}

#pragma mark - Reload Data

- (void)reloadTableView
{
    [self.tableView reloadDataWithAnimationStyle:_animationStyle];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ACBasicTableViewCell *cell = (ACBasicTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kBasicCellIdentifier];
    
    if (!cell) {
        cell = [[ACBasicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kBasicCellIdentifier];
    }
    
    [cell setCustomImage:[UIImage imageNamed:self.images[indexPath.row % 7]]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.00001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"%@",indexPath);
}

@end
