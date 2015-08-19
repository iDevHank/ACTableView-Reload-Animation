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
typedef NS_ENUM(NSInteger, ACTableViewReloadAnimationStyle) {
    ACTableViewReloadAnimationStyleNone, /**< no animation */
    ACTableViewReloadAnimationStyleFlow,  /**< flow */
    ACTableViewReloadAnimationStyleStack,  /**< stack */
    ACTableViewReloadAnimationStyleLeftWave,  /**< from right side */
    ACTableViewReloadAnimationStyleRightWave,  /**< from left side */
    ACTableViewReloadAnimationStyleFall,  /**< fall */
    ACTableViewReloadAnimationStyleFade,  /**< fade in */
    ACTableViewReloadAnimationStyleBounce  /**< bounce */
};


/*! UITableView Animations */
@interface UITableView (PopAnimation)

/*!
 *  @brief  UITableView Reload Animation
 *
 *  @param style Animation Style
 */
- (void)reloadDataWithAnimationStyle:(ACTableViewReloadAnimationStyle)style;

@end
