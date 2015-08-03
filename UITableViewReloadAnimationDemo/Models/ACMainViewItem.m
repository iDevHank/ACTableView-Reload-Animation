//
//  ACMainViewItem.m
//  Infrastructure
//
//  Created by Avalon on 15/7/31.
//  Copyright (c) 2015年 Hank. All rights reserved.
//

#import "ACMainViewItem.h"
#import "UITableView+PopAnimation.h"

@implementation ACMainViewItem

+ (instancetype)sharedItem
{
    static ACMainViewItem *_sharedItem = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedItem = [[self alloc] init];
    });
    
    return _sharedItem;
}

#pragma mark - 初始化方法

- (instancetype)init
{
    if (self = [super init]) {
        
        self.items = @[@[@"StyleFlow"],
                       @[@"StyleStack"],
                       @[@"StyleLeftWave"],
                       @[@"StyleRightWave"],
                       @[@"StyleFall"],
                       @[@"StyleFade"],
                       @[@"StyleBounce"],
                       ];
    }
    return self;
}

@end
