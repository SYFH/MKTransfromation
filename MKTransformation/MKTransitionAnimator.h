//
// Created by 云翼天 on 16/11/18.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import "MKTransitionCommon.h"
#import "MKTransitionProtocol.h"

@interface MKTransitionAnimator : NSObject

// Initial -- 初始化
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

// Time -- 转场时间
@property (nonatomic, assign) NSTimeInterval transitionDuration;

// Color -- 容器颜色
@property (nonatomic, strong) UIColor *containerBackgroundColor;

// System Animate -- 系统自带动画
@property (nonatomic, assign) UIViewAnimationOptions pushAnimateOptions;
@property (nonatomic, assign) UIViewAnimationOptions popAnimateOptions;
@property (nonatomic, assign) UIViewAnimationOptions presentAnimateOptions;
@property (nonatomic, assign) UIViewAnimationOptions dismissAnimateOptions;

// Delegate -- 动画代理
@property (nonatomic, weak) id<MKTransitionPresentProtocol> presentAnimateDelegate;
@property (nonatomic, weak) id<MKTransitionDismissProtocol> dismissAnimateDelegate;
@property (nonatomic, weak) id<MKTransitionPushProtocol> pushAnimateDelegate;
@property (nonatomic, weak) id<MKTransitionPopProtocol> popAnimateDelegate;

// Block -- 动画回调
@property (nonatomic, copy, readonly) transitionAnimateParameters presenAnimateBlock;
@property (nonatomic, copy, readonly) transitionAnimateParameters dismissAnimateBlock;
@property (nonatomic, copy, readonly) transitionAnimateParameters pushAnimateBlock;
@property (nonatomic, copy, readonly) transitionAnimateParameters popAnimateBlock;

@end

// 自定义Present&Dismiss动画
@interface MKTransitionAnimator (CustomPresentAnimate)

- (void)presentAnimateBlock:(transitionAnimateParameters)animateBlock;
- (void)presentToViewController:(UIViewController *)toViewController
               withAnimateBlock:(transitionAnimateParameters)animateBlock;
- (void)dismissAnimateBlock:(transitionAnimateParameters)animateBlock;

@end

// 自定义Push&Pop动画
@interface MKTransitionAnimator (CustomPushAnimate)

- (void)pushAnimateBlock:(transitionAnimateParameters)animateBlock;
- (void)pushToViewController:(UIViewController *)toViewController
            withAnimateBlock:(transitionAnimateParameters)animateBlock;
- (void)popAnimateBlock:(transitionAnimateParameters)animateBlock;

@end
