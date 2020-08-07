//
//  StackViewController.m
//  Demo
//
//  Created by administrator on 2020/6/16.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "StackViewController.h"

@interface StackViewController ()

@end

@implementation StackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat count = 5;
    NSMutableArray * array = [[NSMutableArray alloc]init];
    for (int i =0 ; i<count; i++) {
        UIView * view = [[UIView alloc]init];
        view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
        [array addObject:view];
    }
    UIStackView *stackView = [[UIStackView alloc]initWithArrangedSubviews:array];
    [self.view addSubview:stackView];
    stackView.frame = CGRectMake(10, 100, count * 50, 100);
    
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.distribution = UIStackViewDistributionFillEqually;
    stackView.alignment = UIStackViewAlignmentFill;
    stackView.spacing = 10;
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
