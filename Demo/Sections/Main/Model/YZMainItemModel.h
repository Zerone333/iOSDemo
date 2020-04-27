//
//  YZMainItemModel.h
//  Demo
//
//  Created by administrator on 2020/4/27.
//  Copyright © 2020 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YZMainItemModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *vcClassName;

+ (instancetype)itemWithTitle:(NSString *)title vcClassName:(NSString *)vcClassName;
@end

NS_ASSUME_NONNULL_END
