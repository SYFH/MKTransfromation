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
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    __weak typeof(self) weakSelf = self;
//    [self.transformtor popAnimateBlock:^(UIView *fromView, UIView *toView, UIView *containerView, NSTimeInterval duration) {
//        
//        toView.frame = [UIScreen mainScreen].bounds;
//        fromView.frame = [UIScreen mainScreen].bounds;
//        [containerView addSubview:toView];
//        [containerView addSubview:fromView];
//        
//        [UIView animateWithDuration:duration animations:^{
//            
//        }];
//    }];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"第二界面释放");
}

@end
