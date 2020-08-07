//
//  YZCAShapeLayerDemoVC.m
//  Demo
//
//  Created by administrator on 2020/6/30.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "YZCAShapeLayerDemoVC.h"
#import "FMAirBubblesLabel.h"

@interface YZCAShapeLayerDemoVC ()
@property (nonatomic, strong) FMAirBubblesLabel *label;
@end

@implementation YZCAShapeLayerDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    FMAirBubblesLabel *label = [FMAirBubblesLabel new];
    label.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:label];
    label.frame = CGRectMake(100, 100, 90, 40);
    self.label = label;
    
    UIView *testView = [UIView new];
    testView.frame = CGRectMake(0, 200, 200, 200);
    testView.layer.shadowOpacity = 0.5;
    testView.layer.shadowColor = [UIColor blackColor].CGColor;
//    testView.layer.opaque = 0.8;//透明度6%
    testView.layer.shadowOffset = CGSizeMake(0, 0);//投影偏移
    testView.layer.shadowRadius = 4;//大小为8px
    [self.view addSubview:testView];
    
    UIView *view1 = [UIView new];
    view1.frame = CGRectMake(0, 0, 200, 200);
    view1.backgroundColor = [UIColor greenColor];
    [testView addSubview:view1];
    
    UIImageView *view12 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ping"]];
    view12.frame = CGRectMake(50, 50, 100, 100);
    view1.maskView = view12;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.label.label.text = @" 1212 ";
    [self.label.label sizeToFit];
    self.label.label.textColor = [UIColor blackColor];
    CGRect frame = self.label.frame;
    frame.size.width = self.label.label.bounds.size.width;
    self.label.frame = frame;
}

@end
