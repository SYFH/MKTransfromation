//
//  ViewController.m
//  MKTransfromationDemo
//
//  Created by 云翼天 on 2017/1/8.
//  Copyright © 2017年 SYFH. All rights reserved.
//

#import "ViewController.h"
#import "SecondController.h"
#import "UIViewController+Transformator.h"

@interface ViewController ()<UITableViewDelegate, MKTransitionPushProtocol>

@property (nonatomic, strong) UIControl *hitArea;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.hitArea.frame = CGRectMake(0, 0, 100, 100);
    self.hitArea.center = self.view.center;
    self.hitArea.backgroundColor = [UIColor orangeColor];
    [self.hitArea addTarget:self action:@selector(hitAreaHit:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.hitArea];
}

- (void)hitAreaHit:(UIControl *)sendr {
    SecondController *secondController = [[SecondController alloc] init];
    CGRect frame = self.hitArea.frame;
    
    [self.transformtor popAnimateBlock:^(UIView *fromView, UIView *toView, UIView *containerView) {
        
        fromView.frame = [UIScreen mainScreen].bounds;
        toView.frame = [UIScreen mainScreen].bounds;
        [containerView addSubview:toView];
        [containerView addSubview:fromView];
        
        [UIView animateWithDuration:0.25 animations:^{
            fromView.frame = frame;
        }];
    }];
    
    [self.transformtor pushToViewController:secondController withAnimateBlock:^(UIView *fromView, UIView *toView, UIView *containerView) {
        
        toView.frame = self.hitArea.frame;
        [containerView addSubview:toView];
        
        [UIView animateWithDuration:0.25 animations:^{
            toView.frame = [UIScreen mainScreen].bounds;
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 代理
- (NSTimeInterval)pushAnimateDuration {
    return 0.25;
}

- (void)pushAnimateDidAnimateFromView:(UIView *)fromView toView:(UIView *)toView containerView:(UIView *)containerView {
    containerView.backgroundColor = [UIColor whiteColor];
    toView.frame = self.hitArea.frame;
    [containerView addSubview:toView];
    
    [UIView animateWithDuration:[self pushAnimateDuration] animations:^{
        toView.frame = [UIScreen mainScreen].bounds;
    }];
}

#pragma mark - 懒加载
- (UIControl *)hitArea {
    if (!_hitArea) {
        _hitArea = [[UIControl alloc] init];
    }
    return _hitArea;
}

@end
