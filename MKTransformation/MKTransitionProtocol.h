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
- (void)pushAnimateWillAnimateWithFromController:(UIViewController *)fromController
                                    toController:(UIViewController *)toController
                                   containerView:(UIView *)containerView;
- (void)pushAnimateDidAnimateFromController:(UIViewController *)fromController
                               toController:(UIViewController *)toController
                              containerView:(UIView *)containerView;
- (void)pushAnimateEndAnimateFromController:(UIViewController *)fromController
                               toController:(UIViewController *)toController
                              containerView:(UIView *)containerView;

@end

@protocol MKTransitionPopProtocol <NSObject>

// pop
- (NSTimeInterval)popAnimateDuration;
- (void)popAnimateWillAnimateFromController:(UIViewController *)fromController
                               toController:(UIViewController *)toController
                              containerView:(UIView *)containerView;
- (void)popAnimateDidAnimateFromController:(UIViewController *)fromController
                              toController:(UIViewController *)toController
                             containerView:(UIView *)containerView;
- (void)popAnimateEndAnimateFromController:(UIViewController *)fromController
                              toController:(UIViewController *)toController
                             containerView:(UIView *)containerView;

@end

@protocol MKTransitionPresentProtocol <NSObject>

// present
- (NSTimeInterval)presentAnimateDuration;
- (void)presentAnimateWillAnimateFromController:(UIViewController *)fromController
                                   toController:(UIViewController *)toController
                                  containerView:(UIView *)containerView;
- (void)presentAnimateDidAnimateFromController:(UIViewController *)fromController
                                  toController:(UIViewController *)toController
                                 containerView:(UIView *)containerView;
- (void)presentAnimateEndAnimateFromController:(UIViewController *)fromController
                                  toController:(UIViewController *)toController
                                 containerView:(UIView *)containerView;

@end

@protocol MKTransitionDismissProtocol <NSObject>

// dismiss
- (NSTimeInterval)dismissAnimateDuration;
- (void)dismissAnimateWillAnimateFromController:(UIViewController *)fromController
                                   toController:(UIViewController *)toController
                                  containerView:(UIView *)containerView;
- (void)dismissAnimateDidAnimateFromController:(UIViewController *)fromController
                                  toController:(UIViewController *)toController
                                 containerView:(UIView *)containerView;
- (void)dismissAnimateEndAnimateFromController:(UIViewController *)fromController
                                  toController:(UIViewController *)toController
                                 containerView:(UIView *)containerView;

@end
