//
//  YZMainItemModel.m
//  Demo
//
//  Created by administrator on 2020/4/27.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "YZMainItemModel.h"

@implementation YZMainItemModel

+ (instancetype)itemWithTitle:(NSString *)title vcClassName:(NSString *)vcClassName {
    YZMainItemModel *item = [YZMainItemModel new];
    item.title = title;
    item.vcClassName = vcClassName;
    return item;
}
@end
