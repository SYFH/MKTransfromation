//
// Created by 云翼天 on 16/11/18.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@class MKTransitionAnimator;

@interface MKPopAnimator : NSObject<UIViewControllerAnimatedTransitioning>

- (instancetype)initWithAnimator:(MKTransitionAnimator *)animator;

@end
