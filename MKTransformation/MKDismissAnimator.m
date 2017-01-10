//
// Created by 云翼天 on 16/11/18.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import "MKDismissAnimator.h"
#import "MKTransitionAnimator.h"

@interface MKDismissAnimator ()

@property (nonatomic, copy) transitionAnimateParameters animateBlock;
@property (nonatomic, weak) MKTransitionAnimator *animator;

@end

@implementation MKDismissAnimator

- (instancetype)initWithAnimate:(transitionAnimateParameters)animate {
    self = [super init];
    if (self) {
        self.animateBlock = animate;
    }
    return self;
}

- (instancetype)initWithAnimator:(MKTransitionAnimator *)animator {
    self = [super init];
    if (self) {
        self.animator = animator;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    if ([self.animator.presentAnimateDelegate respondsToSelector:@selector(presentAnimateDuration)]) {
        return [self.animator.presentAnimateDelegate presentAnimateDuration];
    } else {
        return 0.25;
    }
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *containerView = transitionContext.containerView;

    if (self.animateBlock) {
        self.animateBlock(fromView, toView, containerView);
    } else {
        
        CGRect screenBounds = [UIScreen mainScreen].bounds;
        fromView.frame = [transitionContext finalFrameForViewController:toController];
        toView.frame = [transitionContext finalFrameForViewController:toController];
        [containerView addSubview:toView];
        [containerView addSubview:fromView];

        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromView.frame = CGRectMake(0, screenBounds.size.height, screenBounds.size.width, screenBounds.size.height);
        } completion:^(BOOL finished) {
            [fromView removeFromSuperview];
            BOOL wasCancelled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!wasCancelled];
        }];
    }
}

@end
