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

// Delegate -- 动画代理
@property (nonatomic, weak) id<MKTransitionPresentProtocol> presentAnimateDelegate;
@property (nonatomic, weak) id<MKTransitionDismissProtocol> didmissAnimateDelegate;
@property (nonatomic, weak) id<MKTransitionPushProtocol> pushAnimateDelegate;
@property (nonatomic, weak) id<MKTransitionPopProtocol> popAnimateDelegate;

@end

// 自定义Present&Dismiss动画
@interface MKTransitionAnimator (CustomPresentAnimate)

- (void)presentAnimateBlock:(transitionAnimateParameters)animate;
- (void)dismissAnimateBlock:(transitionAnimateParameters)animate;

@end

// 自定义Push&Pop动画
@interface MKTransitionAnimator (CustomPushAnimate)

- (void)pushAnimateBlock:(transitionAnimateParameters)animate;
- (void)popAnimateBlock:(transitionAnimateParameters)animate;

@end
