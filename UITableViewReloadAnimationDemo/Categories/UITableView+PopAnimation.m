//
//  UITableView+PopAnimation.m
//  Infrastructure
//
//  Created by Avalon on 15/8/1.
//  Copyright (c) 2015年 Hank. All rights reserved.
//

#import "UITableView+PopAnimation.h"

BOOL isAnimating = NO; /**< Tableview is animating or not. */


@implementation UITableView (PopAnimation)

#pragma mark - Reload Tableview with A Custom Animation

- (void)reloadDataWithAnimationStyle:(ACTableViewReloadAnimationStyle)style
{
    /*! Prevent multi-animations bug.
     *  Multi-animations should not show.
     *  Reload data without animatiom in the end of last animation.
     */
    if ([self isAnimating]) {
        return;
    }
    
    [UIView animateWithDuration:0.00001 animations:^{
        
        /*! Stop system animation */
        [self setContentOffset:self.contentOffset animated:NO];
        [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.00001 animations:^{
            
            /*! Reload data of tableview. */
            self.hidden = YES;
            [self reloadData];
            
        } completion:^(BOOL finished) {
            
            self.hidden = NO;
            
            /*! Choose a custom animation style. */
            switch (style) {
                case ACTableViewReloadAnimationStyleNone: {
                    break;
                }
                case ACTableViewReloadAnimationStyleFlow: {
                    [self performFlowAnimation];
                    break;
                }
                case ACTableViewReloadAnimationStyleStack: {
                    [self performStackAnimation];
                    break;
                }
                case ACTableViewReloadAnimationStyleLeftWave: {
                    [self performLeftWaveAnimation];
                    break;
                }
                case ACTableViewReloadAnimationStyleRightWave: {
                    [self performRightWaveAnimation];
                    break;
                }
                case ACTableViewReloadAnimationStyleFall: {
                    [self performFallAnimation];
                    break;
                }
                case ACTableViewReloadAnimationStyleFade: {
                    [self performFadeAnimation];
                    break;
                }
                case ACTableViewReloadAnimationStyleBounce: {
                    [self performBounceAnimation];
                    break;
                }
                default: {
                    break;
                }
            }
        }];
    }];
}

#pragma mark - Tableview Is Animating or Not

- (BOOL)isAnimating
{
    NSArray *visibleArray = [self indexPathsForVisibleRows];
    for (NSIndexPath *indexPath in visibleArray) {
        UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
        if ([cell pop_animationKeys].count) {
            isAnimating = YES;
            return YES;
        }
    }
    isAnimating = NO;
    return NO;
}

#pragma mark - Add Completion Block For Last Animation

- (void)addCompletionBlockOfLastAnimation:(POPPropertyAnimation *)animation
{
    animation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        
        /*! Multi-animations should not perform. Reload data without animatiom. */
        if (isAnimating) {
            [self reloadData];
            isAnimating = NO;
        }
    };
}

#pragma mark - Flow Animation

- (void)performFlowAnimation
{
    static CGFloat const kFlowCellDelay = 0.0618;  /**< Delay time for each cell. */
    NSArray *visibleArray = [[self indexPathsForVisibleRows] copy];
    
    for (NSIndexPath *indexPath in visibleArray) {
        
        UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
        
        /*! Hide cell for a better animation effect. */
        cell.hidden = YES;
        
        /*! @param  isLastObject  If cell is the last one in visible rows,
         *                        add a completion block to figure out whether the whole animation is over.
         */
        NSDictionary *dic = @{@"cell":cell, @"isLastObject":(indexPath == [visibleArray lastObject]) ? @(YES) : @(NO)};
        
        /*! Delay animation for each cell. */
        [self performSelector:@selector(flowAnimation:) withObject:dic afterDelay:kFlowCellDelay * (indexPath.row)];
    }
}

/*! Animation for each cell. */
- (void)flowAnimation:(NSDictionary *)dic
{
    static CGFloat const kFlowDuration = 0.3;
    UITableViewCell *cell = dic[@"cell"];
    
    [cell pop_removeAllAnimations];
    
    POPBasicAnimation *alphaAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    alphaAnimation.fromValue = @(0.1);
    alphaAnimation.toValue = @(1.0);
    alphaAnimation.duration = kFlowDuration;
    
    POPBasicAnimation *positionAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
    positionAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.bounds.size.width / 1.2, cell.center.y + 3 * cell.bounds.size.height)];
    positionAnimation.toValue = [NSValue valueWithCGPoint:cell.center];
    positionAnimation.duration = kFlowDuration;
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    scaleAnimation.duration = kFlowDuration;
    scaleAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(2.0, 2.0)];
    scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [cell pop_addAnimation:alphaAnimation forKey:@"ACTableViewReloadAnimationStyleFlowAlphaAnimation"];
    [cell pop_addAnimation:positionAnimation forKey:@"ACTableViewReloadAnimationStyleFlowPositionAnimation"];
    [cell pop_addAnimation:scaleAnimation forKey:@"ACTableViewReloadAnimationStyleFlowScaleAnimation"];
    cell.hidden = NO;
    
    /*! Last cell. If its animation is over, the tableview's animation is over. */
    if ([dic[@"isLastObject"] boolValue]) {
        [self addCompletionBlockOfLastAnimation:scaleAnimation];
    }
}

#pragma mark - Stack Animation

- (void)performStackAnimation
{
    static CGFloat const kStackCellDelay = 0.04; /**< Delay time for each cell. */
    NSArray *visibleArray = [self indexPathsForVisibleRows];
    
    for (NSIndexPath *indexPath in visibleArray) {
        
        UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
        
        /*! Hide cell for a better animation effect. */
        cell.hidden = YES;
        
        /*! @param  isLastObject  If cell is the last one in visible rows,
         *                        add a completion block to figure out whether the whole animation is over.
         */
        NSDictionary *dic = @{@"cell":cell, @"isLastObject":(indexPath == [visibleArray lastObject]) ? @(YES) : @(NO)};
        
        /*! Delay animation for each cell. */
        [self performSelector:@selector(stackAnimation:) withObject:dic afterDelay:kStackCellDelay * (indexPath.row)];
    }
}

/*! Animation for each cell. */
- (void)stackAnimation:(NSDictionary *)dic
{
    UITableViewCell *cell = dic[@"cell"];
    
    [cell pop_removeAllAnimations];
    
    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    positionAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.bounds.size.width / 2, cell.center.y + (cell.bounds.size.height))];
    positionAnimation.toValue = [NSValue valueWithCGPoint:cell.center];
    positionAnimation.springSpeed = 10.0;
    positionAnimation.springBounciness = 15.0;
    
    [cell pop_addAnimation:positionAnimation forKey:@"ACTableViewReloadAnimationStyleStackPositionAnimation"];
    cell.hidden = NO;
    
    /*! Last cell. If its animation is over, the tableview's animation is over. */
    if ([dic[@"isLastObject"] boolValue]) {
        [self addCompletionBlockOfLastAnimation:positionAnimation];
    }
}

#pragma mark - Left Wave Animation

- (void)performLeftWaveAnimation
{
    static CGFloat const kLeftWaveCellDelay = 0.07; /**< Delay time for each cell. */
    NSArray *visibleArray = [self indexPathsForVisibleRows];
    
    for (NSIndexPath *indexPath in visibleArray) {
        
        UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
        
        /*! Hide cell for a better animation effect. */
        cell.hidden = YES;
        
        /*! @param  isLastObject  If cell is the last one in visible rows,
         *                        add a completion block to figure out whether the whole animation is over.
         */
        NSDictionary *dic = @{@"cell":cell, @"isLastObject":(indexPath == [visibleArray lastObject]) ? @(YES) : @(NO)};
        
        /*! Delay animation for each cell. */
        [self performSelector:@selector(leftWaveAnimation:) withObject:dic afterDelay:kLeftWaveCellDelay * (indexPath.row)];
    }
}

/*! Animation for each cell. */
- (void)leftWaveAnimation:(NSDictionary *)dic
{
    UITableViewCell *cell = dic[@"cell"];
    [cell pop_removeAllAnimations];
    
    POPSpringAnimation *slideAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    slideAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(3 * cell.center.x, cell.center.y)];
    slideAnimation.toValue = [NSValue valueWithCGPoint:cell.center];
    slideAnimation.springSpeed = 10.0;
    slideAnimation.springBounciness = 13.0;
    
    [cell pop_addAnimation:slideAnimation forKey:@"ACTableViewReloadAnimationStyleLeftWaveSlideAnimation"];
    cell.hidden = NO;
    
    /*! Last cell. If its animation is over, the tableview's animation is over. */
    if ([dic[@"isLastObject"] boolValue]) {
        [self addCompletionBlockOfLastAnimation:slideAnimation];
    }
}

#pragma mark - Right Wave Animation

- (void)performRightWaveAnimation
{
    static CGFloat const kRightWaveCellDelay = 0.07;  /**< Delay time for each cell. */
    NSArray *visibleArray = [self indexPathsForVisibleRows];
    
    for (NSIndexPath *indexPath in visibleArray) {
        
        UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
        
        /*! Hide cell for a better animation effect. */
        cell.hidden = YES;
        
        /*! @param  isLastObject  If cell is the last one in visible rows,
         *                        add a completion block to figure out whether the whole animation is over.
         */
        NSDictionary *dic = @{@"cell":cell, @"isLastObject":(indexPath == [visibleArray lastObject]) ? @(YES) : @(NO)};
        
        /*! Delay animation for each cell. */
        [self performSelector:@selector(rightWaveAnimation:) withObject:dic afterDelay:kRightWaveCellDelay * (indexPath.row)];
    }
}

/*! Animation for each cell. */
- (void)rightWaveAnimation:(NSDictionary *)dic
{
    UITableViewCell *cell = dic[@"cell"];
    [cell pop_removeAllAnimations];
    
    POPSpringAnimation *slideAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    slideAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(-3 * cell.center.x, cell.center.y)];
    slideAnimation.toValue = [NSValue valueWithCGPoint:cell.center];
    slideAnimation.springSpeed = 10.0;
    slideAnimation.springBounciness = 13.0;
    
    [cell pop_addAnimation:slideAnimation forKey:@"ACTableViewReloadAnimationStyleRightWaveSlideAnimation"];
    cell.hidden = NO;
    
    /*! Last cell. If its animation is over, the tableview's animation is over. */
    if ([dic[@"isLastObject"] boolValue]) {
        [self addCompletionBlockOfLastAnimation:slideAnimation];
    }
}

#pragma mark - Fall Animation

- (void)performFallAnimation
{
    static CGFloat const kFallCellDelay = 0.1;  /**< Delay time for each cell. */
    NSArray *array = [self indexPathsForVisibleRows];
    NSArray *visibleArray = [[array reverseObjectEnumerator] allObjects];
    
    for (NSIndexPath *indexPath in visibleArray) {
        
        UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
        
        /*! Hide cell for a better animation effect. */
        cell.hidden = YES;
        
        /*! @param  isLastObject  If cell is the last one in visible rows,
         *                        add a completion block to figure out whether the whole animation is over.
         */
        NSDictionary *dic = @{@"cell":cell, @"isLastObject":(indexPath == [visibleArray lastObject]) ? @(YES) : @(NO)};
        
        /*! Delay animation for each cell. */
        [self performSelector:@selector(fallAnimation:) withObject:dic afterDelay:kFallCellDelay * (visibleArray.count - 1 - indexPath.row)];
    }
}

/*! Animation for each cell. */
- (void)fallAnimation:(NSDictionary *)dic
{
    UITableViewCell *cell = dic[@"cell"];
    [cell pop_removeAllAnimations];
    
    POPBasicAnimation *fallAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
    fallAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(cell.center.x, -cell.bounds.size.height)];
    fallAnimation.toValue = [NSValue valueWithCGPoint:cell.center];
    fallAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    fallAnimation.duration = 0.55;
    
    [cell pop_addAnimation:fallAnimation forKey:@"ACTableViewReloadAnimationStyleFallAnimation"];
    cell.hidden = NO;
    
    /*! Last cell. If its animation is over, the tableview's animation is over. */
    if ([dic[@"isLastObject"] boolValue]) {
        [self addCompletionBlockOfLastAnimation:fallAnimation];
    }
}

#pragma mark - Fade Animation

- (void)performFadeAnimation
{
    static CGFloat const kFlipCellDelay = 0.07;  /**< Delay time for each cell. */
    NSArray *visibleArray = [self indexPathsForVisibleRows];
    
    for (NSIndexPath *indexPath in visibleArray) {
        
        UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
        
        /*! Hide cell for a better animation effect. */
        cell.hidden = YES;
        
        /*! @param  isLastObject  If cell is the last one in visible rows,
         *                        add a completion block to figure out whether the whole animation is over.
         */
        NSDictionary *dic = @{@"cell":cell, @"isLastObject":(indexPath == [visibleArray lastObject]) ? @(YES) : @(NO)};
        
        /*! Delay animation for each cell. */
        [self performSelector:@selector(fadeAnimation:) withObject:dic afterDelay:(kFlipCellDelay * indexPath.row)];
    }
}

/*! Animation for each cell. */
- (void)fadeAnimation:(NSDictionary *)dic
{
    UITableViewCell *cell = dic[@"cell"];
    [cell pop_removeAllAnimations];
    
    cell.alpha = 0.0;
    POPBasicAnimation *fadeInAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    fadeInAnimation.fromValue = @(0.0);
    fadeInAnimation.toValue = @(1.0);
    fadeInAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    fadeInAnimation.duration = 0.8;
    
    /*! Last cell. If its animation is over, the tableview's animation is over. */
    if ([dic[@"isLastObject"] boolValue]) {
        [self addCompletionBlockOfLastAnimation:fadeInAnimation];
    }
    [cell pop_addAnimation:fadeInAnimation forKey:@"ACTableViewReloadAnimationStyleFadeInAnimation"];
    cell.hidden = NO;
}

#pragma mark - Bounce Animation

- (void)performBounceAnimation
{
    static CGFloat const kBounceCellDelay = 0.00;  /**< Delay time for each cell. */
    NSArray *visibleArray = [self indexPathsForVisibleRows];
    
    for (NSIndexPath *indexPath in visibleArray) {
        
        UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
        
        /*! Hide cell for a better animation effect. */
        cell.hidden = YES;
        
        /*! @param  isLastObject  If cell is the last one in visible rows,
         *                        add a completion block to figure out whether the whole animation is over.
         */
        NSDictionary *dic = @{@"cell":cell, @"isLastObject":(indexPath == [visibleArray lastObject]) ? @(YES) : @(NO)};
        
        /*! Delay animation for each cell. */
        [self performSelector:@selector(bounceAnimation:) withObject:dic afterDelay:(kBounceCellDelay * indexPath.row)];
    }
}

/*! Animation for each cell. */
- (void)bounceAnimation:(NSDictionary *)dic
{
    static CGFloat const kBounceScale = 1.2;
    static CGFloat const kBounceDuration = 0.3;
    static CGFloat const kSpringBounciness = 15.0;
    static CGFloat const kSpringSpeed = 5.0;
    
    UITableViewCell *cell = dic[@"cell"];
    [cell pop_removeAllAnimations];
    
    POPSpringAnimation *bounceAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleY];
    bounceAnimation.fromValue = @(kBounceScale);
    bounceAnimation.toValue = @(1.0);
    bounceAnimation.springSpeed = kSpringSpeed;
    bounceAnimation.springBounciness = kSpringBounciness;
    
    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    positionAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(cell.center.x, kBounceScale * cell.center.y)];
    positionAnimation.toValue = [NSValue valueWithCGPoint:cell.center];
    positionAnimation.springBounciness = kSpringBounciness;
    positionAnimation.springSpeed = kSpringSpeed;
    
    POPBasicAnimation *alphaAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    alphaAnimation.fromValue = @(0.8);
    alphaAnimation.toValue = @(1.0);
    alphaAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    alphaAnimation.duration = kBounceDuration;
    
    /*! Last cell. If its animation is over, the tableview's animation is over. */
    if ([dic[@"isLastObject"] boolValue]) {
        [self addCompletionBlockOfLastAnimation:bounceAnimation];
    }
    
    [cell pop_addAnimation:alphaAnimation forKey:@"ACTableViewReloadAnimationStyleBounceAlphaAnimation"];
    [cell pop_addAnimation:positionAnimation forKey:@"ACTableViewReloadAnimationStyleBouncePositionAnimation"];
    [cell pop_addAnimation:bounceAnimation forKey:@"ACTableViewReloadAnimationStyleBounceAnimation"];
    cell.hidden = NO;
}

@end