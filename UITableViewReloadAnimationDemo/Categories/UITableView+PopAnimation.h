//
//  UITableView+PopAnimation.h
//  Infrastructure
//
//  Created by Avalon on 15/8/1.
//  Copyright (c) 2015年 Hank. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <pop/POP.h>

typedef void(^TableViewAnimationCompletionBlock)(void);

/*! Animation Style */
typedef NS_ENUM(NSInteger, UITableViewReloadAnimationStyle) {
    UITableViewReloadAnimationStyleNone, /**< no animation */
    UITableViewReloadAnimationStyleFlow,  /**< flow */
    UITableViewReloadAnimationStyleStack,  /**< stack */
    UITableViewReloadAnimationStyleLeftWave,  /**< from right side */
    UITableViewReloadAnimationStyleRightWave,  /**< from left side */
    UITableViewReloadAnimationStyleFall,  /**< fall */
    UITableViewReloadAnimationStyleFade,  /**< fade in */
    UITableViewReloadAnimationStyleBounce  /**< bounce */
};


/*! UITableView Animations */
@interface UITableView (PopAnimation)

/*!
 *  @brief  UITableView Reload Animation
 *
 *  @param style Animation Style
 */
- (void)reloadDataWithAnimationStyle:(UITableViewReloadAnimationStyle)style;

@end
