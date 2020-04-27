//
//  YZMainViewModel.h
//  Demo
//
//  Created by administrator on 2020/4/27.
//  Copyright © 2020 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YZMainItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YZMainViewModel : NSObject
@property (nonatomic, copy) NSArray <YZMainItemModel *>*dataSource;
@end

NS_ASSUME_NONNULL_END
