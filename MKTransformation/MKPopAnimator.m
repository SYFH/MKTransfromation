//
// Created by 云翼天 on 16/11/18.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import "MKPopAnimator.h"

@interface MKPopAnimator ()

@property (nonatomic, copy) transitionAnimateParameters animateBlock;

@end

@implementation MKPopAnimator

- (instancetype)initWithAnimate:(transitionAnimateParameters)animate {
    self = [super init];
    if (self) {
        self.animateBlock = animate;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = transitionContext.containerView;

    UIView *fromView;
    UIView *toView;

    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        fromView = fromController.view;
        toView = toController.view;
    }

    if (self.animateBlock) {
        self.animateBlock(fromView, toView, containerView);
    } else {
        CGRect screenBounds = [UIScreen mainScreen].bounds;
        toView.frame = [transitionContext finalFrameForViewController:toController];
        fromView.frame = [transitionContext finalFrameForViewController:toController];
        [containerView addSubview:toView];
        [containerView addSubview:fromView];

        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromView.frame = CGRectMake(screenBounds.size.width, 0, screenBounds.size.width, screenBounds.size.height);
        } completion:^(BOOL finished) {
            [fromView removeFromSuperview];
            BOOL wasCancelled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!wasCancelled];
        }];
    }
}

@end
