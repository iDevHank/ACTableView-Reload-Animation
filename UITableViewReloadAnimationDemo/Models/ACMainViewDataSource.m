//
//  ACMainViewDataSource.m
//  Infrastructure
//
//  Created by Avalon on 15/7/31.
//  Copyright (c) 2015年 Hank. All rights reserved.
//

#import "ACMainViewDataSource.h"
#import "ACMainViewItem.h"
#import "ACMainTableViewCell.h"

static NSString * const kMainViewCellID = @"MainViewCellID";

@implementation ACMainViewDataSource

#pragma mark - <UITableViewDataSource>

/*! 每个section的行数 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ACMainViewItem sharedItem].items.count;
}

/*! cell数据 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ACMainTableViewCell *cell = (ACMainTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kMainViewCellID];
    
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ACMainTableViewCell" owner:self options:nil][0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    /*! 自定义cell */
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

/*! 自定义cell */
- (void)configureCell:(ACMainTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray* dic = [ACMainViewItem sharedItem].items[indexPath.row];
    NSAttributedString *title = [[NSAttributedString alloc]
                                    initWithString:dic[0]
                                        attributes:@{ NSFontAttributeName:[UIFont fontWithName:@"ArialRoundedMTBold" size:18],
                                                      NSForegroundColorAttributeName:[UIColor blackColor]
                                                      }];
    cell.label.attributedText = title;
}

@end
