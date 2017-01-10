//
// Created by 云翼天 on 16/11/18.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import "MKTransitionAnimator.h"
#import "MKPresentAnimator.h"
#import "MKDismissAnimator.h"
#import "MKPushAnimator.h"
#import "MKPopAnimator.h"

@interface MKTransitionAnimator ()<UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak) UIViewController *fromController;
@property (nonatomic, weak) UIViewController *toController;

@property (nonatomic, copy) transitionAnimateParameters presenAnimateBlock;
@property (nonatomic, copy) transitionAnimateParameters dismissAnimateBlock;
@property (nonatomic, copy) transitionAnimateParameters pushAnimateBlock;
@property (nonatomic, copy) transitionAnimateParameters popAnimateBlock;

@end

@implementation MKTransitionAnimator

// 自定义初始化

+ (instancetype)animatorFromController:(UIViewController *)fromController
                          toController:(UIViewController *)toController {
    MKTransitionAnimator *animator = [[self alloc] init];
    animator.fromController = fromController;
    animator.toController = toController;
    animator.toController.transitioningDelegate = animator;
    return animator;
}

// 公公方法
- (void)settingFromController:(UIViewController *)fromController {
    self.fromController = fromController;
}

- (void)settingToController:(UIViewController *)toController {
    self.toController = toController;
}

- (void)settingFromController:(UIViewController *)fromController
                 toController:(UIViewController *)toController {
    self.fromController = fromController;
    self.toController = toController;
}

- (void)present {
    [self presentViewController:self.fromController
               toViewController:self.toController];
}

- (void)presentViewController:(UIViewController *)viewCOntroller
             toViewController:(UIViewController *)toViewController {
    toViewController.transitioningDelegate = self;
    [viewCOntroller presentViewController:toViewController
                                 animated:YES
                               completion:nil];
}

- (void)presentToViewController:(UIViewController *)toViewController {
    toViewController.transitioningDelegate = self;
    [self.fromController presentViewController:toViewController
                                 animated:YES
                               completion:nil];
}

- (void)dismiss {
    self.fromController.transitioningDelegate = self;
    [self.fromController dismissViewControllerAnimated:YES completion:nil];
}

- (void)push {
    [self pushViewController:self.fromController
            toViewController:self.toController];
}

- (void)pushViewController:(UIViewController *)viewController
          toViewController:(UIViewController *)toViewController {
    viewController.navigationController.delegate = self;
    [viewController.navigationController pushViewController:toViewController
                                                   animated:YES];
}

- (void)pushToViewController:(UIViewController *)toViewController {
    self.fromController.navigationController.delegate = self;
    [self.fromController.navigationController pushViewController:toViewController
                                                   animated:YES];
}

- (void)pop {
    self.fromController.transitioningDelegate = self;
    [self.fromController.navigationController popViewControllerAnimated:YES];
}

// UIViewControllerTransitioningDelegate
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                   presentingController:(UIViewController *)presenting
                                                                       sourceController:(UIViewController *)source {
    return [[MKPresentAnimator alloc] initWithAnimate:self.presenAnimateBlock];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[MKDismissAnimator alloc] initWithAnimate:self.dismissAnimateBlock];
}

// UINavigationControllerDelegate
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        return [[MKPushAnimator alloc] initWithAnimator:self];
    } else if (operation == UINavigationControllerOperationPop) {
        return [[MKPopAnimator alloc] initWithAnimate:self.popAnimateBlock];
    } else {
        return nil;
    }
}

@end

@implementation MKTransitionAnimator (CustomPresentAnimate)

- (void)presentAnimateBlock:(transitionAnimateParameters)animate {
    self.presenAnimateBlock = animate;
}

- (void)dismissAnimateBlock:(transitionAnimateParameters)animate {
    self.dismissAnimateBlock = animate;
}

@end

@implementation MKTransitionAnimator (CustomPushAnimate)

- (void)pushAnimateBlock:(transitionAnimateParameters)animate {
    self.pushAnimateBlock = animate;
}

- (void)popAnimateBlock:(transitionAnimateParameters)animate {
    self.popAnimateBlock = animate;
}

@end
