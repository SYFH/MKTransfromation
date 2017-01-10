//
// Created by 云翼天 on 16/11/18.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import "MKPushAnimator.h"
#import "MKTransitionAnimator.h"

@interface MKPushAnimator ()

@property (nonatomic, weak) MKTransitionAnimator *animator;

@end

@implementation MKPushAnimator

- (instancetype)initWithAnimator:(MKTransitionAnimator *)animator {
    self = [super init];
    if (self) {
        self.animator = animator;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    if ([self.animator.pushAnimateDelegate respondsToSelector:@selector(pushAnimateDuration)]) {
        return [self.animator.pushAnimateDelegate pushAnimateDuration];
    } else {
        return 0.25;
    }
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    if (self.animator.pushAnimateBlock) {
        [self animationForBlockWithContext:transitionContext];
    } else if (self.animator.pushAnimateDelegate) {
        [self animationForDelegateWithContext:transitionContext];
    } else {
        [self animationForNoneWithContext:transitionContext];
    }
}

- (void)animationForBlockWithContext:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *containerView = transitionContext.containerView;
    
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    NSBlockOperation *didOperation = [NSBlockOperation blockOperationWithBlock:^{
        self.animator.pushAnimateBlock(fromView, toView, containerView);
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
    
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    NSBlockOperation *willOperation = [NSBlockOperation blockOperationWithBlock:^{
        if ([self.animator.pushAnimateDelegate respondsToSelector:@selector(pushAnimateWillAnimateWithFromView:toView:containerView:)]) {
            [self.animator.pushAnimateDelegate pushAnimateWillAnimateWithFromView:fromView
                                                                           toView:toView
                                                                    containerView:containerView];
        }
    }];
    NSBlockOperation *didOperation = [NSBlockOperation blockOperationWithBlock:^{
        if ([self.animator.pushAnimateDelegate respondsToSelector:@selector(pushAnimateDidAnimateFromView:toView:containerView:)]) {
            [self.animator.pushAnimateDelegate pushAnimateDidAnimateFromView:fromView
                                                                      toView:toView
                                                               containerView:containerView];
        }
    }];
    NSBlockOperation *endOperation = [NSBlockOperation blockOperationWithBlock:^{
        if ([self.animator.pushAnimateDelegate respondsToSelector:@selector(pushAnimateEndAnimateFromView:toView:containerView:)]) {
            [self.animator.pushAnimateDelegate pushAnimateEndAnimateFromView:fromView
                                                                      toView:toView
                                                               containerView:containerView];
        }
    }];
    NSBlockOperation *overOperation = [NSBlockOperation blockOperationWithBlock:^{
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCancelled];
    }];
    
    [overOperation addDependency:endOperation];
    [endOperation addDependency:didOperation];
    [didOperation addDependency:willOperation];
    [queue addOperation:willOperation];
    [queue addOperation:didOperation];
    [queue addOperation:endOperation];
    [queue addOperation:overOperation];
}

- (void)animationForNoneWithContext:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *containerView = transitionContext.containerView;
    
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    toView.frame = CGRectMake(screenBounds.size.width, 0, screenBounds.size.width, screenBounds.size.height);
    
    [containerView addSubview:toView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.frame = fromView.bounds;
    } completion:^(BOOL finished) {
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCancelled];
    }];
}

@end
