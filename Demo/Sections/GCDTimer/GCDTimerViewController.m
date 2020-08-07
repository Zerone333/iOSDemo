//
//  GCDTimerViewController.m
//  GCDTimer
//
//  Created by administrator on 2020/6/16.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "GCDTimerViewController.h"
/**
 停止 Dispatch Timer 有两种方法，一种是使用 dispatch_suspend，另外一种是使用 dispatch_source_cancel。

 dispatch_suspend 严格上只是把 Timer 暂时挂起，它和 dispatch_resume 是一个平衡调用，两者分别会减少和增加 dispatch 对象的挂起计数。当这个计数大于 0 的时候，Timer 就会执行。在挂起期间，产生的事件会积累起来，等到 resume 的时候会融合为一个事件发送。

 dispatch_source_cancel 则是真正意义上的取消 Timer。被取消之后如果想再次执行 Timer，只能重新创建新的 Timer。这个过程类似于对 NSTimer 执行 invalidate。
 ————————————————
 版权声明：本文为CSDN博主「大飞哥666」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
 原文链接：https://blog.csdn.net/u013602835/java/article/details/87623497
 */

@interface GCDTimerViewController ()
@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, assign) BOOL isStartTimer;
@property (nonatomic, assign) NSInteger times;
@end

@implementation GCDTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadTimer];
}

- (void)dealloc {
    [self cancelTimer];
    NSLog(@"TestViewController dealloc");
}

#pragma mark - private

/// 定时器控制器内全局 1s执行一次
- (void)loadTimer {
    //定时器相关数据初始化
    self.times = 0;
    self.isStartTimer = YES;
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    //创建一个定时器（dispatch_source_t本质上还是一个OC对象）
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    //设置定时器的各种属性
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0*NSEC_PER_SEC));
    uint64_t interval = (uint64_t)(1.0*NSEC_PER_SEC);
    dispatch_source_set_timer(self.timer, start, interval, 0);
    
    //设置回调
    __weak typeof(self) weakSelf = self;
    dispatch_source_set_event_handler(self.timer, ^{
        [weakSelf timerAction]; 
    });
    //启动定时器（默认是暂停）
    dispatch_resume(self.timer);
}

- (void)timerAction {
    self.times += 1;
    NSLog(@"timerAction %ld", (long)self.times);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.isStartTimer) {
        NSLog(@"暂停定时器");
        [self suspendTimer];
    } else {
        NSLog(@"恢复定时器");
        // 启动定时器（默认是暂停）
        [self resumetimer];
    }
    self.isStartTimer = !self.isStartTimer;
    
}

/// 取消定时器
- (void)cancelTimer {
    if (self.timer) {
        dispatch_source_cancel(self.timer); // 取消定时器， 取消后的timer 不可dispatch_resume 会crash
        self.timer = nil;
    }
}

/// 恢复、启动定时器
- (void)resumetimer {
    dispatch_resume(self.timer); // 恢复、启动
}

/// 暂停定时器
- (void)suspendTimer {
    dispatch_suspend(self.timer); // 暂停
}

@end
