//
//  GHCrossToViewController.m
//  GHTransitioningAnimation
//
//  Created by mac on 2018/12/5.
//  Copyright © 2018年 GHome. All rights reserved.
//

#import "GHCrossToViewController.h"

@interface GHCrossToViewController ()

@end

@implementation GHCrossToViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
