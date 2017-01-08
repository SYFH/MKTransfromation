//
// Created by 云翼天 on 16/11/18.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import "MKTransitionCommon.h"

@interface MKTransitionAnimator : NSObject

// Initial -- 初始化
+ (instancetype)defaulfAnimator;
+ (instancetype)animatorFromController:(UIViewController *)fromController
                          toController:(UIViewController *)toController;

// Setting Controller -- 设置控制器
- (void)settingFromController:(UIViewController *)fromController;
- (void)settingToController:(UIViewController *)toController;
- (void)settingFromController:(UIViewController *)fromController
                 toController:(UIViewController *)toController;

// Transition -- 转场
- (void)present;
- (void)presentViewController:(UIViewController *)viewCOntroller
             toViewController:(UIViewController *)toViewController;
- (void)presentToViewController:(UIViewController *)toViewController;
- (void)dismiss;

- (void)push;
- (void)pushViewController:(UIViewController *)viewController
          toViewController:(UIViewController *)toViewController;
- (void)pushToViewController:(UIViewController *)toViewController;
- (void)pop;

@end

// 自定义Present&Dismiss动画
@interface MKTransitionAnimator (CustomPresentAnimate)

- (void)presentAnimate:(transitionAnimateParameters)animate;
- (void)dismissAnimate:(transitionAnimateParameters)animate;

@end

// 自定义Push&Pop动画
@interface MKTransitionAnimator (CustomPushAnimate)

- (void)pushAnimate:(transitionAnimateParameters)animate;
- (void)popAnimate:(transitionAnimateParameters)animate;

@end
