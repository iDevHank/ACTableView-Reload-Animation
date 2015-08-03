//
//  ACMainTableViewCell.m
//  Infrastructure
//
//  Created by Avalon on 15/7/31.
//  Copyright (c) 2015年 Hank. All rights reserved.
//

#import "ACMainTableViewCell.h"

@implementation ACMainTableViewCell

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor clearColor];
    self.label.shadowColor = [UIColor lightGrayColor];
    self.label.shadowOffset = CGSizeMake(1.0, 1.0);
}

@end
