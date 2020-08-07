//
//  YZLogTool.h
//  Demo
//
//  Created by administrator on 2020/7/29.
//  Copyright © 2020 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kYZLogToolEndStringFlag @"YZLogTool!@#$@#$#"

NS_ASSUME_NONNULL_BEGIN

@interface YZLogTool : NSObject
@property (nonatomic, assign) BOOL logSwitchOn; /// default NO 写日志开关

+ (instancetype)shareInstance;

/// 写日志
/// @param logString 日志文本
- (void)writeLog:(NSString *)logString;

/// 清空日志
- (void)clearLogs;

/// 读取日志
/// @param keyWord 关键字
- (NSString *)readLogsWithKeyword:(NSString *)keyWord;
@end

NS_ASSUME_NONNULL_END
