//
//  YZMainViewModel.m
//  Demo
//
//  Created by administrator on 2020/4/27.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "YZMainViewModel.h"

@implementation YZMainViewModel
- (NSArray *)dataSource {
    if (!_dataSource) {
        NSMutableArray *tempArray = [NSMutableArray array];
        [tempArray addObject:[YZMainItemModel itemWithTitle:@"动态排布标签选择器" vcClassName:@"YZLabelSelectorViewController"]];
        _dataSource = [tempArray copy];
    }
    return _dataSource;
}
@end
