//
//  YZLabelSelectorViewController.m
//  Demo
//
//  Created by administrator on 2020/4/27.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "YZLabelSelectorViewController.h"
#import "YLTagsChooserConfig.h"
#import "YLTagsChooser.h"
#import "YLTag.h"

#define SCREEN_WIDTH  ([[UIScreen mainScreen]bounds].size.width)

@interface YZLabelSelectorViewController () <YLTagsChooserDelegate>

@end

@implementation YZLabelSelectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 200; ++ i) {
        [array addObject:[NSString stringWithFormat:@"测试%d", i]];
    }
    [self showChooser:array];
    
}

- (void)showChooser:(NSArray *)tags {
    if (tags.count == 0) {
        return;
    }
    YLTagsChooserConfig *config = [[YLTagsChooserConfig alloc] init];
    config.hasHeader = YES;
    config.headerSize = CGSizeMake(SCREEN_WIDTH, 52);
    config.rowHeight = 40.f;
    config.maxItemWidth = 76.f;
    
    
    YLTagsChooser *chooser = [[YLTagsChooser alloc]initWithMaxSelectCount:1 delegate:self config:config];
    NSMutableArray *orignDataArray = [NSMutableArray array];
    
    NSInteger index = tags.count;
    NSMutableArray *testTags0 = [NSMutableArray arrayWithCapacity:tags.count];
    for(NSInteger i = 0; i < index; i++){
        NSString *label = tags[i];
        YLTag *tag = [[YLTag alloc]initWithId:i name:label];
        [testTags0 addObject:tag];
    }
    [orignDataArray addObject:testTags0];
    
    CGRect frame = self.view.bounds;
    frame.origin.y = 0;
    frame.size.height = frame.size.height;
    [chooser showInView:self.view frame:frame];
    
    [chooser refreshWithTags:orignDataArray selectedTags:nil headerTitles:@[@"热门标签"]];
}

#pragma mark - YLTagsChooserDelegate
- (void)tagsChooser:(YLTagsChooser *)sheet selectedTags:(NSArray <NSIndexPath *>*)sTags {

}

@end
