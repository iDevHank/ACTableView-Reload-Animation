//
//  ACMainViewItem.h
//  Infrastructure
//
//  Created by Avalon on 15/7/31.
//  Copyright (c) 2015年 Hank. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACMainViewItem : NSObject

@property (strong, nonatomic) NSArray *items;

/*! Singleton */
+ (instancetype)sharedItem;

@end
