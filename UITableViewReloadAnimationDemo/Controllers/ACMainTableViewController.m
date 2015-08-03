//
//  ACMainTableViewController.m
//  UITableViewReloadAnimationDemo
//
//  Created by Avalon on 15/8/3.
//  Copyright (c) 2015年 Hank. All rights reserved.
//

#import "ACMainTableViewController.h"
#import "UITableView+PopAnimation.h"
#import "ACMainViewItem.h"
#import "ACMainViewDataSource.h"
#import "ACBasicTableViewController.h"

@interface ACMainTableViewController ()

@property (strong, nonatomic) id<UITableViewDataSource> dataSource; /**< UITableViewDataSource */

@end

@implementation ACMainTableViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Animations";
    
    self.dataSource = [[ACMainViewDataSource alloc] init];
    self.tableView.dataSource = self.dataSource;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"backgroud"];
    imageView.alpha = 0.5;
    [self.view addSubview:imageView];
    [self.view bringSubviewToFront:self.tableView];
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ACBasicTableViewController *basicTableViewController = [[ACBasicTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    switch (indexPath.row) {
        case 0:
            basicTableViewController.animationStyle = UITableViewReloadAnimationStyleFlow;
            break;
        case 1:
            basicTableViewController.animationStyle = UITableViewReloadAnimationStyleStack;
            break;
        case 2:
            basicTableViewController.animationStyle = UITableViewReloadAnimationStyleLeftWave;
            break;
        case 3:
            basicTableViewController.animationStyle = UITableViewReloadAnimationStyleRightWave;
            break;
        case 4:
            basicTableViewController.animationStyle = UITableViewReloadAnimationStyleFall;
            break;
        case 5:
            basicTableViewController.animationStyle = UITableViewReloadAnimationStyleFade;
            break;
        case 6:
            basicTableViewController.animationStyle = UITableViewReloadAnimationStyleBounce;
            break;
        default:
            break;
    }
    
    [self.navigationController pushViewController:basicTableViewController animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

@end
