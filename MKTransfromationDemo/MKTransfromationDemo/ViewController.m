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
@property (weak, nonatomic) IBOutlet UIView *Cover;
@property (weak, nonatomic) IBOutlet UIView *Name;

@property (weak, nonatomic) IBOutlet UIControl *hitAera;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.hitAera addTarget:self action:@selector(hitControl:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)hitControl:(UIControl *)sender {
    SecondController *secondController = [[SecondController alloc] init];
    secondController.transformtor.transitionDuration = 0.3;
    
    secondController.cover.hidden = YES;
    secondController.name.hidden = YES;
    secondController.brief1.hidden = YES;
    secondController.brief2.hidden = YES;
    secondController.brief3.hidden = YES;
    secondController.brief4.hidden = YES;
    secondController.item1.hidden = YES;
    secondController.item2.hidden = YES;
    secondController.item3.hidden = YES;
    
    __weak typeof(secondController) weakVC = secondController;
    __weak typeof(self) weakSelf = self;
    [self.transformtor pushToViewController:secondController withAnimateBlock:^(UIView *fromView, UIView *toView, UIView *containerView, NSTimeInterval duration) {
        
        __strong typeof(weakVC) strongVC = weakVC;
        __strong typeof(weakSelf) strongSelf = weakSelf;
        toView.frame = [UIScreen mainScreen].bounds;
        [containerView addSubview:toView];
        
        UIView *cover = [strongVC.cover snapshotViewAfterScreenUpdates:NO];
        cover.backgroundColor = [UIColor orangeColor];
        cover.frame = strongSelf.Cover.frame;
        [containerView addSubview:cover];
        
        [UIView animateWithDuration:duration animations:^{
            cover.frame = strongVC.cover.frame;
        } completion:^(BOOL finished) {
            [cover removeFromSuperview];
        }];
    }];
}

#pragma mark - 代理

#pragma mark - 懒加载

@end
