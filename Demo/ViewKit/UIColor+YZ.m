//
//  UIColor+YZ.m
//  Demo
//
//  Created by administrator on 2020/4/27.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "UIColor+YZ.h"


@implementation UIColor (YZ)

/// 字符串转颜色
/// @param strColor #FFFFFF \ FFFFFF \ 0xFFFFFF
+ (UIColor *)yz_ColorFromString:(NSString *)strColor {
    if (!strColor) {
        return nil;
    }
    NSMutableString *color = [NSMutableString stringWithString:strColor];
    // 转换成标准16进制数
    [color replaceCharactersInRange:[strColor rangeOfString:@"#" ] withString:@"0x"];
    
    // 十六进制字符串转成整形。
    long colorLong = strtoul([color cStringUsingEncoding:NSUTF8StringEncoding], 0, 16);
    return YZCOLOR_HEX(colorLong);
}
@end
