//
// Created by 云翼天 on 16/11/18.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import "MKPushAnimator.h"
#import "MKTransitionAnimator.h"

@interface MKPushAnimator ()

@property (nonatomic, copy) transitionAnimateParameters animateBlock;
@property (nonatomic, weak) MKTransitionAnimator *animator;

@end

@implementation MKPushAnimator

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
    if ([self.animator.pushAnimateDelegate respondsToSelector:@selector(pushAnimateDuration)]) {
        return [self.animator.pushAnimateDelegate pushAnimateDuration];
    } else {
        return 0.25;
    }
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    if (self.animateBlock) {
        [self animationForBlockWithContext:transitionContext];
    } else if (self.animator.pushAnimateDelegate) {
        [self animationForDelegateWithContext:transitionContext];
    } else {
        [self animationForNoneWithContext:transitionContext];
    }
}

- (void)animationForBlockWithContext:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = transitionContext.containerView;
    
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    NSBlockOperation *didOperation = [NSBlockOperation blockOperationWithBlock:^{
        self.animateBlock(fromController, toController, containerView);
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
    UIViewController *fromController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = transitionContext.containerView;
    
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    NSBlockOperation *willOperation = [NSBlockOperation blockOperationWithBlock:^{
        if ([self.animator.pushAnimateDelegate respondsToSelector:@selector(pushAnimateWillAnimateWithFromController:toController:containerView:)]) {
            [self.animator.pushAnimateDelegate pushAnimateWillAnimateWithFromController:fromController
                                                                           toController:toController
                                                                          containerView:containerView];
        }
    }];
    NSBlockOperation *didOperation = [NSBlockOperation blockOperationWithBlock:^{
        if ([self.animator.pushAnimateDelegate respondsToSelector:@selector(pushAnimateDidAnimateFromController:toController:containerView:)]) {
            [self.animator.pushAnimateDelegate pushAnimateDidAnimateFromController:fromController
                                                                      toController:toController
                                                                     containerView:containerView];
        }
    }];
    NSBlockOperation *endOperation = [NSBlockOperation blockOperationWithBlock:^{
        if ([self.animator.pushAnimateDelegate respondsToSelector:@selector(pushAnimateEndAnimateFromController:toController:containerView:)]) {
            [self.animator.pushAnimateDelegate pushAnimateEndAnimateFromController:fromController
                                                                      toController:toController
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
    
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    toView.frame = CGRectMake(screenBounds.size.width, 0, screenBounds.size.width, screenBounds.size.height);
    
    [containerView addSubview:toView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.frame = [transitionContext finalFrameForViewController:toController];
    } completion:^(BOOL finished) {
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCancelled];
    }];
}

@end
