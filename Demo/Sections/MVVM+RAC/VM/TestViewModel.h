//
//  TestViewModel.h
//  testlee
//
//  Created by administrator on 2020/4/26.
//  Copyright © 2020 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestViewModel : NSObject
//RACCommand
@property (nonatomic, strong) RACCommand *autoLoginCommand;

//RACSubject
@property (nonatomic, strong) RACSubject *pushSubject; // 热信号

//RACSubject
@property (nonatomic, strong) RACSignal *signal;  ///< 冷信号
@end

NS_ASSUME_NONNULL_END
