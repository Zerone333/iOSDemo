//
//  YLTagsChooserConfig.h
//  iOSWaterfallFlow
//
//  Created by administrator on 2020/4/21.
//  Copyright © 2020 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLTagsChooserConfig : NSObject
@property (nonatomic, assign) BOOL hasHeader;
@property (nonatomic, assign) BOOL hasFooter;
@property (nonatomic, assign) CGSize headerSize;
@property (nonatomic, assign) CGSize footerSize;
@property (nonatomic, assign) CGFloat rowHeight;
@property (nonatomic, assign) CGFloat maxItemWidth;
@end

NS_ASSUME_NONNULL_END
