//
//  TestViewModel.m
//  testlee
//
//  Created by administrator on 2020/4/26.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "TestViewModel.h"

@implementation TestViewModel


- (RACSubject *)pushSubject {
    if (!_pushSubject) {
        _pushSubject = [RACSubject subject];
        [_pushSubject subscribeNext:^(id x) {
              NSLog(@"One 信号来了:%@", x);
          }];
          // 2 订阅
          [_pushSubject subscribeNext:^(id x) {
              NSLog(@"Tow 信号来了:%@", x);
          }];
    }
    return _pushSubject;
}

- (RACCommand *)autoLoginCommand {
    if (!_autoLoginCommand) {
        _autoLoginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                NSDictionary *paramDic = @{@"userName" : @"lee"};
                [subscriber sendNext:paramDic];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return _autoLoginCommand;
}

- (RACSignal *)signal {
    if (!_signal){
        _signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:@"I'm send next data"];
            return nil;
        }];
    }
    return _signal;
}
@end
