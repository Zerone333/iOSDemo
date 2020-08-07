//
//  YZLogViewController.m
//  Demo
//
//  Created by administrator on 2020/7/29.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "YZLogViewController.h"
#import "YZLogTool.h"

@interface YZLogViewController ()
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, assign) NSInteger index;
@end

@implementation YZLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self constructUI];
    [YZLogTool shareInstance].logSwitchOn = YES;
    [self btn2Click];
}

#pragma mark - event

- (void)btnClick {
    [[YZLogTool shareInstance] writeLog:[NSString stringWithFormat:@"第%ld条测试数据", (long)self.index]];
    ++self.index;
}

- (void)btn2Click {
    NSString *log = [[YZLogTool shareInstance] readLogsWithKeyword:self.textField.text];
    self.textView.text = log;
    [self.view endEditing:YES];
}

- (void)btn3Click {
    [[YZLogTool shareInstance] clearLogs];
    self.textView.text = nil;
    [self.view endEditing:YES];
}

#pragma mark - private

- (void)constructUI {
    CGFloat sW = self.view.frame.size.width;
    CGFloat top = 64;
    CGFloat searchH = 44;
    CGFloat btnW = 44;
    
    [self.view addSubview:self.textField];
    [self.view addSubview:self.textView];
    
    self.textField.frame = CGRectMake(0, top, sW - btnW * 2, searchH);
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.backgroundColor = [UIColor redColor];
//    btn.frame = CGRectMake(0, top, 44, 22);
//    [btn setTitle:@"写" forState:UIControlStateNormal];
//    [self.view addSubview:btn];
//    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.backgroundColor = [UIColor redColor];
    btn2.frame = CGRectMake(sW - btnW * 2, top, btnW, searchH);
    [btn2 setTitle:@"搜索" forState:UIControlStateNormal];
    [self.view addSubview:btn2];
    [btn2 addTarget:self action:@selector(btn2Click) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.backgroundColor = [UIColor purpleColor];
    btn3.frame = CGRectMake(sW - btnW, top, btnW, searchH);
    [btn3 setTitle:@"清空" forState:UIControlStateNormal];
    [self.view addSubview:btn3];
    [btn3 addTarget:self action:@selector(btn3Click) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect frame = self.view.bounds;
    frame.origin.y = searchH + top;
    frame.size.height = frame.size.height - searchH - top;
    self.textView.frame = frame;
}

#pragma mark - getter

- (UITextField *)textField {
    if (!_textField) {
        _textField = [UITextField new];
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.placeholder = @"输入关键字搜索";
        _textField.textColor = [UIColor blackColor];
    }
   return _textField;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
        _textView.editable = NO;
    }
    return _textView;
}

@end
