//
//  YZMVVMDemoViewController.m
//  Demo
//
//  Created by administrator on 2020/4/27.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "YZMVVMDemoViewController.h"
#import "TestViewModel.h"

@interface YZMVVMDemoViewController ()
@property (nonatomic, strong) TestViewModel *VM;
@end

@implementation YZMVVMDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    

    self.VM = [[TestViewModel alloc] init];
    RACSignal *signalOne = [RACSignal return:@"12345678"];
    RACSignal *signalTwo = [signalOne map:^id(id value) {
        NSLog(@"做其他事情");
        return [value substringFromIndex:2];
    }];
    [signalTwo subscribeNext:^(id x) {
        NSLog(@"signalTwo::%@", x);
    }];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[self.VM.autoLoginCommand execute:nil] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];

    [self.VM.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];

    [self.VM.pushSubject sendNext:@"124"];
}

@end
