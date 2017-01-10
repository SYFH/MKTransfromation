//
// Created by 云翼天 on 16/11/18.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MKTransitionCommon.h"
@class MKTransitionAnimator;

@interface MKDismissAnimator : NSObject<UIViewControllerAnimatedTransitioning>

- (instancetype)initWithAnimate:(transitionAnimateParameters)animate;
- (instancetype)initWithAnimator:(MKTransitionAnimator *)animator;

@end
