//
//  UIViewController+Transformator.m
//  控制器转场动画测试
//
//  Created by 云翼天 on 2017/1/7.
//  Copyright © 2017年 云翼天. All rights reserved.
//

#import "UIViewController+Transformator.h"

@implementation UIViewController (Transformator)

- (MKTransitionAnimator *)transformtor {
    MKTransitionAnimator *animator = [[MKTransitionAnimator alloc] init];
    [animator settingFromController:self];
    return animator;
}

@end
