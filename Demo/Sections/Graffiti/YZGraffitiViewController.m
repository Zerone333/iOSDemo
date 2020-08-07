//
//  YZGraffitiViewController.m
//  Demo
//
//  Created by administrator on 2020/7/21.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "YZGraffitiViewController.h"
#import "YZGraffitiView.h"

@interface YZGraffitiViewController ()

@end

@implementation YZGraffitiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    YZGraffitiView *view = [[YZGraffitiView alloc] init];
    view.frame = self.view.bounds;
    view.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.3];
    [self.view addSubview:view];
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
