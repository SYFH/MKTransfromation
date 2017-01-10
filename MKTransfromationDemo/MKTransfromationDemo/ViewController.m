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

@interface ViewController ()<UITableViewDelegate>

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
    [self.transformtor presentToViewController:secondController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 懒加载
- (UIControl *)hitArea {
    if (!_hitArea) {
        _hitArea = [[UIControl alloc] init];
    }
    return _hitArea;
}

@end
