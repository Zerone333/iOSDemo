//
//  AnimationViewController.m
//  Demo
//
//  Created by administrator on 2020/6/16.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "AnimationViewController.h"

@interface AnimationViewController ()
@property (nonatomic, strong) UILabel *pickDragonTipLabel;
@property (nonatomic, strong) UILabel *pickDragonTipLabel2;
@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.pickDragonTipLabel];
    self.pickDragonTipLabel.text = @"我是厕所放骄傲了发；可代发；发卡机多发；的看法就；电费卡多发；发点卡服；打发；打发";
    [self.pickDragonTipLabel sizeToFit];
    
    [self.view addSubview:self.pickDragonTipLabel2];
    self.pickDragonTipLabel2.text = @"我是厕所放骄傲了发；可代发；发卡机多发；的看法就；电费卡多发；发点卡服；打发；打发";
    [self.pickDragonTipLabel2 sizeToFit];
}

#pragma mark - private

- (void)dragonPaomadeng {
    NSLog(@"lee= dragonPaomadeng");
    CGRect frame1 = self.pickDragonTipLabel.frame;
    frame1.origin.x = 0;
    self.pickDragonTipLabel.frame = frame1;
    [self.pickDragonTipLabel.layer removeAllAnimations];
        [UIView animateWithDuration:3 animations:^{
           
                CGRect frame = self.pickDragonTipLabel.frame;
                frame.origin.x = -frame.size.width;
                    self.pickDragonTipLabel.frame = frame;
        } completion:^(BOOL finished) {
            if (finished) {
                NSLog(@"lee= finish");
                [self dragonPaomadeng];
            }
        }];
}

- (void)dragonPaomadeng2 {
    NSLog(@"lee= dragonPaomadeng2");
    CGRect frame1 = self.pickDragonTipLabel.frame;
    frame1.origin.x = 0;
    frame1.origin.x = -frame1.size.width;
    self.pickDragonTipLabel.frame = frame1;
    [self.pickDragonTipLabel2.layer removeAnimationForKey:@"animationID"];
    
  
    CABasicAnimation * animaiton = [CABasicAnimation animationWithKeyPath:@"position"];
    animaiton.removedOnCompletion = NO;
    animaiton.fillMode = kCAFillModeForwards;
    animaiton.duration = 5;
    animaiton.repeatCount = 100000;
    animaiton.toValue = [NSValue valueWithCGPoint:CGPointMake(-frame1.size.width, self.pickDragonTipLabel2.center.y)];
    [self.pickDragonTipLabel2.layer addAnimation:animaiton forKey:@"animationID"];
}

#pragma mark - getter

- (UILabel *)pickDragonTipLabel {
    if (!_pickDragonTipLabel) {
        _pickDragonTipLabel = [UILabel new];
        _pickDragonTipLabel.textColor = [UIColor blackColor];
        _pickDragonTipLabel.frame = CGRectMake(0, 100, 0, 0);
    }
    return _pickDragonTipLabel;
}

- (UILabel *)pickDragonTipLabel2 {
    if (!_pickDragonTipLabel2) {
        _pickDragonTipLabel2 = [UILabel new];
        _pickDragonTipLabel2.textColor = [UIColor blackColor];
        _pickDragonTipLabel2.frame = CGRectMake(0, 200, 0, 0);
    }
    return _pickDragonTipLabel2;
}

#pragma mark - super
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dragonPaomadeng];
    [self dragonPaomadeng2];
    
}

@end
