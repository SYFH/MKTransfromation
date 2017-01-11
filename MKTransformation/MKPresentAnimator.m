//
// Created by 云翼天 on 16/11/18.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import "MKPresentAnimator.h"
#import "MKTransitionAnimator.h"

@interface MKPresentAnimator ()

@property (nonatomic, weak) MKTransitionAnimator *animator;

@end

@implementation MKPresentAnimator

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
    } else if (self.animator.transitionDuration) {
        return self.animator.transitionDuration;
    } else {
        return 0.25;
    }
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    if (self.animator.presenAnimateBlock) {
        [self animationForBlockWithContext:transitionContext];
    } else if (self.animator.presentAnimateDelegate) {
        [self animationForDelegateWithContext:transitionContext];
    } else if (self.animator.presentAnimateOptions) {
        [self animationForOptionsWithContext:transitionContext];
    } else {
        [self animationForNoneWithContext:transitionContext];
    }
}

- (void)animationForBlockWithContext:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *containerView = transitionContext.containerView;
    
    if (self.animator.containerBackgroundColor) {
        containerView.backgroundColor = self.animator.containerBackgroundColor;
    }
    
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    NSBlockOperation *didOperation = [NSBlockOperation blockOperationWithBlock:^{
        self.animator.presenAnimateBlock(fromView, toView, containerView);
    }];
    NSBlockOperation *overOperation = [NSBlockOperation blockOperationWithBlock:^{
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCancelled];
    }];
    
    [overOperation addDependency:didOperation];
    [queue addOperation:didOperation];
    [queue addOperation:overOperation];
}

- (void)animationForDelegateWithContext:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *containerView = transitionContext.containerView;
    
    if (self.animator.containerBackgroundColor) {
        containerView.backgroundColor = self.animator.containerBackgroundColor;
    }
    
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    NSBlockOperation *didOperation = [NSBlockOperation blockOperationWithBlock:^{
        if ([self.animator.presentAnimateDelegate respondsToSelector:@selector(presentAnimateDidAnimateFromView:toView:containerView:)]) {
            [self.animator.presentAnimateDelegate presentAnimateDidAnimateFromView:fromView
                                                                            toView:toView
                                                                     containerView:containerView];
        }
    }];
    NSBlockOperation *overOperation = [NSBlockOperation blockOperationWithBlock:^{
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCancelled];
    }];
    
    [overOperation addDependency:didOperation];
    [queue addOperation:didOperation];
    [queue addOperation:overOperation];
}

- (void)animationForOptionsWithContext:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *containerView = transitionContext.containerView;
    
    if (self.animator.containerBackgroundColor) {
        containerView.backgroundColor = self.animator.containerBackgroundColor;
    }
    
    toView.frame = fromView.bounds;
    [containerView addSubview:toView];
    
    [UIView transitionFromView:fromView
                        toView:toView
                      duration:[self transitionDuration:transitionContext]
                       options:self.animator.presentAnimateOptions
                    completion:^(BOOL finished) {
                        BOOL wasCancelled = [transitionContext transitionWasCancelled];
                        [transitionContext completeTransition:!wasCancelled];
                    }];
}

- (void)animationForNoneWithContext:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *containerView = transitionContext.containerView;
    
    if (self.animator.containerBackgroundColor) {
        containerView.backgroundColor = self.animator.containerBackgroundColor;
    }
    
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

@end
