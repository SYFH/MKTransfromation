//
//  MKTransitionProtocol.h
//  MKTransfromationDemo
//
//  Created by 云翼天 on 2017/1/10.
//  Copyright © 2017年 SYFH. All rights reserved.
//

@protocol MKTransitionPushProtocol <NSObject>

// push
- (NSTimeInterval)pushAnimateDuration;
- (void)pushAnimateDidAnimateFromView:(UIView *)fromView
                               toView:(UIView *)toView
                        containerView:(UIView *)containerView;

@end

@protocol MKTransitionPopProtocol <NSObject>

// pop
- (NSTimeInterval)popAnimateDuration;
- (void)popAnimateDidAnimateFromView:(UIView *)fromView
                              toView:(UIView *)toView
                       containerView:(UIView *)containerView;

@end

@protocol MKTransitionPresentProtocol <NSObject>

// present
- (NSTimeInterval)presentAnimateDuration;
- (void)presentAnimateDidAnimateFromView:(UIView *)fromView
                                  toView:(UIView *)toView
                           containerView:(UIView *)containerView;

@end

@protocol MKTransitionDismissProtocol <NSObject>

// dismiss
- (NSTimeInterval)dismissAnimateDuration;
- (void)dismissAnimateDidAnimateFromView:(UIView *)fromView
                                  toView:(UIView *)toView
                           containerView:(UIView *)containerView;

@end
