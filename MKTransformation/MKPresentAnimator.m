//
// Created by 云翼天 on 16/11/18.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import "MKPresentAnimator.h"
#import "MKTransitionAnimator.h"

@interface MKPresentAnimator ()

@property (nonatomic, copy) transitionAnimateParameters animateBlock;
@property (nonatomic, weak) MKTransitionAnimator *animator;

@end

@implementation MKPresentAnimator

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
        self.animateBlock(fromController, toController, containerView);
    } else {
        CGRect screenBounds = [UIScreen mainScreen].bounds;
        toView.frame = CGRectMake(0, screenBounds.size.height, screenBounds.size.width, screenBounds.size.height);
        [containerView addSubview:toView];

        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            toView.frame = [transitionContext finalFrameForViewController:toController];
        } completion:^(BOOL finished) {
            BOOL wasCancelled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!wasCancelled];
        }];
    }
}

@end
