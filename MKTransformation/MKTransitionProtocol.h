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
- (void)pushAnimateWillAnimateWithFromView:(UIView *)fromView
                                    toView:(UIView *)toView
                             containerView:(UIView *)containerView;
- (void)pushAnimateDidAnimateFromView:(UIView *)fromView
                               toView:(UIView *)toView
                        containerView:(UIView *)containerView;
- (void)pushAnimateEndAnimateFromView:(UIView *)fromView
                               toView:(UIView *)toView
                        containerView:(UIView *)containerView;

@end

@protocol MKTransitionPopProtocol <NSObject>

// pop
- (NSTimeInterval)popAnimateDuration;
- (void)popAnimateWillAnimateFromView:(UIView *)fromView
                               toView:(UIView *)toView
                        containerView:(UIView *)containerView;
- (void)popAnimateDidAnimateFromView:(UIView *)fromView
                              toView:(UIView *)toView
                       containerView:(UIView *)containerView;
- (void)popAnimateEndAnimateFromView:(UIView *)fromView
                              toView:(UIView *)toView
                       containerView:(UIView *)containerView;

@end

@protocol MKTransitionPresentProtocol <NSObject>

// present
- (NSTimeInterval)presentAnimateDuration;
- (void)presentAnimateWillAnimateFromView:(UIView *)fromView
                                   toView:(UIView *)toView
                            containerView:(UIView *)containerView;
- (void)presentAnimateDidAnimateFromView:(UIView *)fromView
                                  toView:(UIView *)toView
                           containerView:(UIView *)containerView;
- (void)presentAnimateEndAnimateFromView:(UIView *)fromView
                                  toView:(UIView *)toView
                           containerView:(UIView *)containerView;

@end

@protocol MKTransitionDismissProtocol <NSObject>

// dismiss
- (NSTimeInterval)dismissAnimateDuration;
- (void)dismissAnimateWillAnimateFromView:(UIView *)fromView
                                   toView:(UIView *)toView
                            containerView:(UIView *)containerView;
- (void)dismissAnimateDidAnimateFromView:(UIView *)fromView
                                  toView:(UIView *)toView
                           containerView:(UIView *)containerView;
- (void)dismissAnimateEndAnimateFromView:(UIView *)fromView
                                  toView:(UIView *)toView
                           containerView:(UIView *)containerView;

@end
