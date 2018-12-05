//
//  GHCrossAnimation.m
//  GHTransitioningAnimation
//
//  Created by mac on 2018/12/5.
//  Copyright © 2018年 GHome. All rights reserved.
//
//  gitHub:https://github.com/shabake
//  简书:https://www.jianshu.com/u/884a67907187

#import "GHCrossAnimation.h"

@implementation GHCrossAnimation

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.35;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    /** fromVc */
    UIViewController *fromVc = [transitionContext viewControllerForKey:(UITransitionContextFromViewControllerKey)];
    /** toVc */
    UIViewController *toVc = [transitionContext viewControllerForKey:(UITransitionContextToViewControllerKey)];

    /** contentView */
    UIView *contentView = [transitionContext containerView];
    
    /** fromView */
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    /** toView */
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    /** fromView.frame */

    fromView.frame = [transitionContext initialFrameForViewController:fromVc];
    
    /** toView.frame */
    toView.frame = [transitionContext finalFrameForViewController:toVc];

    fromView.alpha = 1.0f;
    toView.alpha = 0.0f;
    
    [contentView addSubview:toView];

    /** 获取动画时长 */
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];

    [UIView animateWithDuration:transitionDuration animations:^{
        
        fromView.alpha = 0.0f;
        toView.alpha  = 1.0;
        
    } completion:^(BOOL finished) {
        
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCancelled];
    }];
}
@end
