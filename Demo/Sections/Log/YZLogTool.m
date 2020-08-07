//
//  YZLogTool.m
//  Demo
//
//  Created by administrator on 2020/7/29.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "YZLogTool.h"


@interface YZLogTool ()
@property (nonatomic, copy) NSString *dateString;
@property (nonatomic, copy) NSString *logTxtPath;
@end

@implementation YZLogTool

+ (YZLogTool *)shareInstance {
    static YZLogTool *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[YZLogTool alloc] init];
        [instance createLogFile];
        NSString *txtName = [NSString stringWithFormat:@"%@.txt", instance.dateString];
        NSString *filePath = [instance.logPath stringByAppendingPathComponent:txtName];
        instance.logTxtPath = filePath;
    });
    return instance;
}

/// 写日志
/// @param logString 日志文本
- (void)writeLog:(NSString *)logString {
    if (![YZLogTool shareInstance].logSwitchOn) {
        return;
    }
    
    NSString *path = [YZLogTool shareInstance].logTxtPath;
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:path];
    [fileHandle seekToEndOfFile];  //将节点跳到文件的末尾
   
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy_MM_dd hh:mm:ss";
    NSString *nowDateStr = [dateFormatter stringFromDate:date];
    
    NSString *log = [NSString stringWithFormat:@"%@ %@\n%@", nowDateStr, logString, kYZLogToolEndStringFlag];
    NSData* stringData  = [log dataUsingEncoding:NSUTF8StringEncoding];
    [fileHandle writeData:stringData]; //追加写入数据
    [fileHandle closeFile];
}

/// 清空日志
- (void)clearLogs {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *logPath = [YZLogTool shareInstance].logPath;
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:logPath error:NULL];
    NSEnumerator *e = [contents objectEnumerator];
    NSString *filename;
    while ((filename = [e nextObject])) {
            [fileManager removeItemAtPath:[logPath stringByAppendingPathComponent:filename] error:NULL];
    }
    if ([YZLogTool shareInstance].logSwitchOn) {
        [[YZLogTool shareInstance] createLogText];
    }
}

/// 读取日志
/// @param keyWord 关键字
- (NSString *)readLogsWithKeyword:(NSString *)keyWord; {
    NSString *path = [YZLogTool shareInstance].logTxtPath;
    NSString *logString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray *array = [logString componentsSeparatedByString:kYZLogToolEndStringFlag];
    NSMutableString *logsString = [NSMutableString string];
    for (NSString *string in array) {
        if (keyWord.length > 0) {
            if ([string containsString:keyWord]) {
                NSString *s = [string stringByReplacingOccurrencesOfString:kYZLogToolEndStringFlag withString:@""];
                [logsString appendString:s];
            }
        } else {
            NSString *s = [string stringByReplacingOccurrencesOfString:kYZLogToolEndStringFlag withString:@""];
            [logsString appendString:s];
        }
      }
    return [logsString copy];
}

#pragma mark - private

- (void)createLogFile {
    NSString *logFile = [self logPath];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:logFile isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) ) {//如果文件夹不存在
        [fileManager createDirectoryAtPath:logFile withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

- (NSString *)logPath {
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *logFile = [documentPath stringByAppendingPathComponent:@"YZ_LOG"];
    return logFile;
}

- (void)createLogText {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:self.logTxtPath]) {
        [fileManager createFileAtPath:self.logTxtPath contents:nil attributes:nil];
    }
}

#pragma mark - getter

- (NSString *)dateString {
    if (!_dateString) {
        NSDate *date = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy_MM_dd";
        NSString *nowDateStr = [dateFormatter stringFromDate:date];
        _dateString = nowDateStr;
    }
    return _dateString;
}

- (void)setLogSwitchOn:(BOOL)logSwitchOn {
    _logSwitchOn = logSwitchOn;
    if (logSwitchOn) {
        [self createLogText];
    }
}

//        //沙盒根目录
//       NSString *homePath = NSHomeDirectory();
//       //document目录
//       NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
//       //library目录
//       NSString *libraryPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
//       //caches目录
//       NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
//       //application support目录
//       NSString *applicationSupportPath = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES).firstObject;
//       //preference目录
//       NSString *preferencePath = NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES).firstObject;
//       //tem目录
//       NSString *temPath = NSTemporaryDirectory();
@end
