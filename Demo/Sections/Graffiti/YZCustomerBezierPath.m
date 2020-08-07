//
//  YZCustomerBezierPath.m
//  Demo
//
//  Created by administrator on 2020/7/21.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "YZCustomerBezierPath.h"

@implementation YZCustomerBezierPath
- (NSMutableArray *)pointsArray {
    if (!_pointsArray) {
        _pointsArray = [NSMutableArray array];
    }
    return _pointsArray;
}
@end
