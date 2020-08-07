//
//  YZShakeViewController.m
//  Demo
//
//  Created by administrator on 2020/7/29.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "YZShakeViewController.h"

@interface YZShakeViewController ()

@end

@implementation YZShakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view. // 设置允许摇一摇功能

    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;

    // 并让自己成为第一响应者
    [self becomeFirstResponder];
}

#pragma mark - getter#pragma mark - ShakeToEdit 摇动手机之后的回调方法

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    //检测到摇动开始
    if (motion == UIEventSubtypeMotionShake) {
      // your code
      NSLog(@"检测到摇动开始");
    }
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    //摇动取消
    NSLog(@"摇动取消");
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    //摇动结束
    if (event.subtype == UIEventSubtypeMotionShake) {
        // your code
        NSLog(@"摇动结束");
//        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//振动效果 需要#import <AudioToolbox/AudioToolbox.h>
    }
}

@end
