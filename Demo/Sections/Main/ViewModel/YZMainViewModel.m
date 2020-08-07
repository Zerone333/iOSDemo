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
        [tempArray addObject:[YZMainItemModel itemWithTitle:@"动态排布标签选择器 BaseTableList" vcClassName:@"YZLabelSelectorViewController"]];
        _dataSource = [tempArray copy];
        
        [tempArray addObject:[YZMainItemModel itemWithTitle:@"MVVM+RAC_Demo MVVM+RAC" vcClassName:@"YZMVVMDemoViewController"]];
        _dataSource = [tempArray copy];
        
        [tempArray addObject:[YZMainItemModel itemWithTitle:@"GCDTimer" vcClassName:@"GCDTimerViewController"]];
        _dataSource = [tempArray copy];
        
        [tempArray addObject:[YZMainItemModel itemWithTitle:@"跑马灯" vcClassName:@"AnimationViewController"]];
        _dataSource = [tempArray copy];
        
        [tempArray addObject:[YZMainItemModel itemWithTitle:@"横向并排 UIStackView" vcClassName:@"StackViewController"]];
        _dataSource = [tempArray copy];
        
        [tempArray addObject:[YZMainItemModel itemWithTitle:@"渐变色图层 GradientLayer" vcClassName:@"GradientLayerViewController"]];
        _dataSource = [tempArray copy];
        
        [tempArray addObject:[YZMainItemModel itemWithTitle:@"Collection" vcClassName:@"YZCollectionViewController"]];
        _dataSource = [tempArray copy];
        
        [tempArray addObject:[YZMainItemModel itemWithTitle:@"气泡 CAShapeLayer" vcClassName:@"YZCAShapeLayerDemoVC"]];
        _dataSource = [tempArray copy];
        
        [tempArray addObject:[YZMainItemModel itemWithTitle:@"WKWebview" vcClassName:@"YZWebViewController"]];
        _dataSource = [tempArray copy];
        
        [tempArray addObject:[YZMainItemModel itemWithTitle:@"play video" vcClassName:@"YZPlayVideoViewController"]];
        _dataSource = [tempArray copy];
        [tempArray addObject:[YZMainItemModel itemWithTitle:@"涂鸦 Graffiti" vcClassName:@"YZGraffitiViewController"]];
        _dataSource = [tempArray copy];
        
        [tempArray addObject:[YZMainItemModel itemWithTitle:@"摇一摇" vcClassName:@"YZShakeViewController"]];
        _dataSource = [tempArray copy];
        
        [tempArray addObject:[YZMainItemModel itemWithTitle:@"操作日志" vcClassName:@"YZLogViewController"]];
        _dataSource = [tempArray copy];
        
        
        
        
        
    }
    return _dataSource;
}
@end
