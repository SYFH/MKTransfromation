//
// Created by 云翼天 on 16/11/18.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MKTransitionCommon.h"

@interface MKDismissAnimator : NSObject<UIViewControllerAnimatedTransitioning>

- (instancetype)initWithAnimate:(transitionAnimateParameters)animate;

@end