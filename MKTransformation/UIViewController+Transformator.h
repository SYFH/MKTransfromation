//
//  UIViewController+Transformator.h
//  控制器转场动画测试
//
//  Created by 云翼天 on 2017/1/7.
//  Copyright © 2017年 云翼天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKTransitionAnimator.h"

@interface UIViewController (Transformator)

@property (nonatomic, strong, readonly) MKTransitionAnimator *transformtor;

@end
