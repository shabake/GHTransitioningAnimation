//
//  GHCrossFromViewController.m
//  GHTransitioningAnimation
//
//  Created by mac on 2018/12/5.
//  Copyright © 2018年 GHome. All rights reserved.
//

#import "GHCrossFromViewController.h"
#import "GHCrossAnimation.h"
#import "GHCrossToViewController.h"

@interface GHCrossFromViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation GHCrossFromViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    GHCrossToViewController *crossToVc = [[GHCrossToViewController alloc]init];
    crossToVc.modalPresentationStyle = UIModalPresentationFullScreen;
    crossToVc.transitioningDelegate = self;
    
    [self presentViewController:crossToVc animated:YES completion:nil];

}
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [GHCrossAnimation new];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [GHCrossAnimation new];

}


@end
