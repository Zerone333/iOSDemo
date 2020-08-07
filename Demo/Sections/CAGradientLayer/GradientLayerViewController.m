//
//  GradientLayerViewController.m
//  Demo
//
//  Created by administrator on 2020/6/16.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "GradientLayerViewController.h"

@interface GradientLayerViewController ()

@end

@implementation GradientLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIColor *color1 = [UIColor greenColor];
    UIColor *color2 = [UIColor redColor];
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(100, 100, 100, 100);
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    gradientLayer.locations = @[@(0.5),@(1.0)];//渐变点
    [gradientLayer setColors:@[(__bridge id)color1.CGColor, (__bridge id)color2.CGColor]];//渐变数组
    gradientLayer.cornerRadius = 5;
    [self.view.layer addSublayer:gradientLayer];
    
    UIView *testView = [UIView new];
    testView.frame = CGRectMake(100, 250, 100, 100);
    [self.view addSubview:testView];
    
    CAGradientLayer *rightLayer = [CAGradientLayer layer];
    rightLayer.frame = testView.bounds;
    rightLayer.locations = @[@0.3, @0.9, @1];
    rightLayer.colors = @[(id)[UIColor yellowColor].CGColor, (id)[UIColor redColor].CGColor];
    [testView.layer addSublayer:rightLayer];
    
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = testView.bounds;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(50, 50) radius:40 startAngle:-0 endAngle:M_PI * 2  clockwise:YES];
    layer.lineWidth = 10;
    layer.path = path.CGPath;
    layer.fillColor = [UIColor clearColor].CGColor; // 填充色为透明（不设置为黑色）
    layer.strokeColor = [UIColor blackColor].CGColor; // 随便设置一个边框颜色
    layer.lineCap = kCALineCapRound; // 设置线为圆角
    
    rightLayer.mask = layer;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
