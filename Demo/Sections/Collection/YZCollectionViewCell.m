//
//  YZCollectionViewCell.m
//  Demo
//
//  Created by administrator on 2020/6/24.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "YZCollectionViewCell.h"

@implementation YZCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self.contentView addSubview:self.textLabel];
        self.textLabel.frame = CGRectMake(0, 0, 50, 30);
    }
    return self;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [UILabel new];
    }
    return _textLabel;
}
@end
