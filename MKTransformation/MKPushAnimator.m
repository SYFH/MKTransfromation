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
    } else if (self.animator.transitionDuration) {
        return self.animator.transitionDuration;
    } else {
        return 0.25;
    }
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    if (self.animator.pushAnimateBlock) {
        [self animationForBlockWithContext:transitionContext];
    } else if (self.animator.pushAnimateDelegate) {
        [self animationForDelegateWithContext:transitionContext];
    } else if (self.animator.pushAnimateOptions) {
        [self animationForOptionWithContext:transitionContext];
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
    
    if (self.animator.containerBackgroundColor) {
        containerView.backgroundColor = self.animator.containerBackgroundColor;
    }
    
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    __weak typeof(self) weakSelf = self;
    NSBlockOperation *didOperation = [NSBlockOperation blockOperationWithBlock:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if ([strongSelf.animator.pushAnimateDelegate respondsToSelector:@selector(pushAnimateDidAnimateFromView:toView:containerView:)]) {
            [strongSelf.animator.pushAnimateDelegate pushAnimateDidAnimateFromView:fromView
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

- (void)animationForOptionWithContext:(id <UIViewControllerContextTransitioning>)transitionContext {
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
                       options:self.animator.pushAnimateOptions
                    completion:^(BOOL finished) {
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCancelled];
    }];
}

- (void)animationForNoneWithContext:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *containerView = transitionContext.containerView;
    
    if (self.animator.containerBackgroundColor) {
        containerView.backgroundColor = self.animator.containerBackgroundColor;
    }
    
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
