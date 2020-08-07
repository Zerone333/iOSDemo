//
//  YZCustomerBezierPath.h
//  Demo
//
//  Created by administrator on 2020/7/21.
//  Copyright © 2020 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YZCustomerBezierPath : UIBezierPath
@property (nonatomic, strong) UIColor *color; //保存当前线条的颜色

@property (nonatomic, strong) NSMutableArray *pointsArray;

@end

NS_ASSUME_NONNULL_END
