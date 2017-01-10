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
    UIViewController *fromController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = transitionContext.containerView;

    if (self.animateBlock) {
        self.animateBlock(fromController, toController, containerView);
    } else if (self.animator.presentAnimateDelegate) {
        if ([self.animator.presentAnimateDelegate respondsToSelector:@selector(presentAnimateWillAnimateFromController:toController:containerView:)]) {
            [self.animator.presentAnimateDelegate presentAnimateWillAnimateFromController:fromController
                                                                             toController:toController
                                                                            containerView:containerView];
        }
        if ([self.animator.presentAnimateDelegate respondsToSelector:@selector(presentAnimateDidAnimateFromController:toController:containerView:)]) {
            [self.animator.presentAnimateDelegate presentAnimateDidAnimateFromController:fromController
                                                                            toController:toController
                                                                           containerView:containerView];
        }
        
        NSOperationQueue *queue = [NSOperationQueue mainQueue];
        NSBlockOperation *end = [NSBlockOperation blockOperationWithBlock:^{
            if ([self.animator.presentAnimateDelegate respondsToSelector:@selector(presentAnimateEndAnimateFromController:toController:containerView:)]) {
                [self.animator.presentAnimateDelegate presentAnimateEndAnimateFromController:fromController
                                                                                toController:toController
                                                                               containerView:containerView];
            }
        }];
        NSBlockOperation *over = [NSBlockOperation blockOperationWithBlock:^{
            BOOL wasCancelled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!wasCancelled];
        }];
        [queue addOperation:end];
        [queue addOperation:over];
        [over addDependency:end];
    } else {
        UIView *fromView;
        UIView *toView;
        
        if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
            fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
            toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        } else {
            fromView = fromController.view;
            toView = toController.view;
        }
        
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
