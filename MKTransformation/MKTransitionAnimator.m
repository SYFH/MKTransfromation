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

@property (nonatomic, strong) MKPushAnimator *pushAnimator;
@property (nonatomic, strong) MKPopAnimator *popAnimator;
@property (nonatomic, strong) MKPresentAnimator *presentAnimator;
@property (nonatomic, strong) MKDismissAnimator *dismissAnimator;

@end

@implementation MKTransitionAnimator

// 自定义初始化
- (instancetype)init {
    self = [super init];
    if (self) {
        [self defaultSetting];
    }
    return self;
}

- (void)defaultSetting {
    self.transitionDuration = 0.25;
    self.containerBackgroundColor = [UIColor whiteColor];
}

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
    return self.presentAnimator;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self.dismissAnimator;
}

// UINavigationControllerDelegate
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        return self.pushAnimator;
    } else if (operation == UINavigationControllerOperationPop) {
        return self.popAnimator;
    } else {
        return nil;
    }
}

// 懒加载
- (MKPushAnimator *)pushAnimator {
    if (!_pushAnimator) {
        _pushAnimator = [[MKPushAnimator alloc] initWithAnimator:self];
    }
    return _pushAnimator;
}

- (MKPopAnimator *)popAnimator {
    if (!_popAnimator) {
        _popAnimator = [[MKPopAnimator alloc] initWithAnimator:self];
    }
    return _popAnimator;
}

- (MKPresentAnimator *)presentAnimator {
    if (!_presentAnimator) {
        _presentAnimator = [[MKPresentAnimator alloc] initWithAnimator:self];
    }
    return _presentAnimator;
}

- (MKDismissAnimator *)dismissAnimator {
    if (!_dismissAnimator) {
        _dismissAnimator = [[MKDismissAnimator alloc] initWithAnimator:self];
    }
    return _dismissAnimator;
}

@end

@implementation MKTransitionAnimator (CustomPresentAnimate)

- (void)presentAnimateBlock:(transitionAnimateParameters)animateBlock {
    self.presenAnimateBlock = animateBlock;
}

- (void)presentToViewController:(UIViewController *)toViewController
               withAnimateBlock:(transitionAnimateParameters)animateBlock {
    self.presenAnimateBlock = animateBlock;
    [self settingToController:toViewController];
    [self presentToViewController:toViewController];
}

- (void)dismissAnimateBlock:(transitionAnimateParameters)animateBlock {
    self.dismissAnimateBlock = animateBlock;
}

@end

@implementation MKTransitionAnimator (CustomPushAnimate)

- (void)pushAnimateBlock:(transitionAnimateParameters)animateBlock {
    self.pushAnimateBlock = animateBlock;
}

- (void)pushToViewController:(UIViewController *)toViewController
            withAnimateBlock:(transitionAnimateParameters)animateBlock {
    self.pushAnimateBlock = animateBlock;
    [self settingToController:toViewController];
    [self pushToViewController:toViewController];
}

- (void)popAnimateBlock:(transitionAnimateParameters)animateBlock {
    self.popAnimateBlock = animateBlock;
}

@end
