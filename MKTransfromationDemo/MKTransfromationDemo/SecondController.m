//
//  SecondController.m
//  MKTransfromationDemo
//
//  Created by 云翼天 on 2017/1/8.
//  Copyright © 2017年 SYFH. All rights reserved.
//

#import "SecondController.h"
#import "UIViewController+Transformator.h"

@interface SecondController ()

@end

@implementation SecondController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.transformtor popAnimateBlock:^(UIView *fromView, UIView *toView, UIView *containerView) {
        
        toView.frame = [UIScreen mainScreen].bounds;
        [containerView addSubview:toView];
        
        [UIView animateWithDuration:0.25 animations:^{
            fromView.frame = self.restoreFrame;
        }];
    }];
    
//    [self.transformtor dismissAnimateBlock:^(UIView *fromView, UIView *toView, UIView *containerView) {
//        fromView.frame = [UIScreen mainScreen].bounds;
//        toView.frame = [UIScreen mainScreen].bounds;
//        [containerView addSubview:toView];
//        [containerView addSubview:fromView];
//        
//        [UIView animateWithDuration:0.25 animations:^{
//            fromView.alpha = 0;
//        }];
//    }];
//    [self.transformtor dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"第二界面释放");
}

@end
