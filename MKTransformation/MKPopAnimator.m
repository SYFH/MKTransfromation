//
// Created by 云翼天 on 16/11/18.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import "MKPopAnimator.h"
#import "MKTransitionAnimator.h"

@interface MKPopAnimator ()

@property (nonatomic, weak) MKTransitionAnimator *animator;

@end

@implementation MKPopAnimator

- (instancetype)initWithAnimator:(MKTransitionAnimator *)animator {
    self = [super init];
    if (self) {
        self.animator = animator;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    if ([self.animator.popAnimateDelegate respondsToSelector:@selector(popAnimateDuration)]) {
        return [self.animator.popAnimateDelegate popAnimateDuration];
    } else if (self.animator.transitionDuration) {
        return self.animator.transitionDuration;
    } else {
        return 0.25;
    }
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    if (self.animator.popAnimateBlock) {
        [self animationForBlockWithContext:transitionContext];
    } else if (self.animator.popAnimateDelegate) {
        [self animationForDelegateWwithContext:transitionContext];
    } else if (self.animator.popAnimateOptions) {
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
    __weak typeof(self) weakSelf = self;
    NSBlockOperation *didOperation = [NSBlockOperation blockOperationWithBlock:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.animator.popAnimateBlock(fromView, toView, containerView);
    }];
    NSBlockOperation *overOperation = [NSBlockOperation blockOperationWithBlock:^{
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCancelled];
    }];
    
    [overOperation addDependency:didOperation];
    [queue addOperation:didOperation];
    [queue addOperation:overOperation];
}

- (void)animationForDelegateWwithContext:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *containerView = transitionContext.containerView;
    
    if (self.animator.containerBackgroundColor) {
        containerView.backgroundColor = self.animator.containerBackgroundColor;
    }
    
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    __weak typeof(self) weakSelf = self;
    NSBlockOperation *didOperation = [NSBlockOperation blockOperationWithBlock:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if ([strongSelf.animator.popAnimateDelegate respondsToSelector:@selector(popAnimateDidAnimateFromView:toView:containerView:)]) {
            [strongSelf.animator.popAnimateDelegate popAnimateDidAnimateFromView:fromView
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
                       options:self.animator.popAnimateOptions
                    completion:^(BOOL finished) {
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCancelled];
    }];
}

- (void)animationForNoneWithContext:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *containerView = transitionContext.containerView;
    
    if (self.animator.containerBackgroundColor) {
        containerView.backgroundColor = self.animator.containerBackgroundColor;
    }
    
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

@end
