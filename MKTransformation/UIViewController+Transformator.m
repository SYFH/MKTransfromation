//
//  UIViewController+Transformator.m
//  控制器转场动画测试
//
//  Created by 云翼天 on 2017/1/7.
//  Copyright © 2017年 云翼天. All rights reserved.
//

#import "UIViewController+Transformator.h"
#import <objc/runtime.h>

@implementation UIViewController (Transformator)

- (MKTransitionAnimator *)transformtor {
    MKTransitionAnimator *animator;
    animator = objc_getAssociatedObject(self, @selector(transformtor));
    if (!animator) {
        animator = [[MKTransitionAnimator alloc] init];
        [animator settingFromController:self];
        self.transformtor = animator;
    }
    return animator;
}

- (void)setTransformtor:(MKTransitionAnimator *)transformtor {
    objc_setAssociatedObject(self, @selector(transformtor), transformtor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
