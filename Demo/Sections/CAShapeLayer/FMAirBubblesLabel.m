//
//  FMAirBubblesLabel.m
//  ForManLive
//
//  Created by administrator on 2020/6/30.
//  Copyright © 2020 厦门东城世纪. All rights reserved.
//

#import "FMAirBubblesLabel.h"
#define kFMAirBubblesLabelDistace 5 ///< 气泡尖高度


@interface FMAirBubblesLabel ()
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) CAShapeLayer *airBubblesLabelMaskLayer;
@end

@implementation FMAirBubblesLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.label];
        self.layer.mask = self.airBubblesLabelMaskLayer;
    }
    return self;
}

- (void)layoutSubviews {
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    CGFloat radius = (h - kFMAirBubblesLabelDistace) * 0.5;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(radius, 0)];
    [path addLineToPoint:CGPointMake(w - radius, 0)];
    [path addArcWithCenter:CGPointMake(w - radius, radius) radius:radius startAngle:-M_PI_2 endAngle:M_PI_2 clockwise:YES];
    [path addLineToPoint:CGPointMake(w * 0.5 + kFMAirBubblesLabelDistace, radius * 2)];
    [path addLineToPoint:CGPointMake(w * 0.5, h)];
    [path addLineToPoint:CGPointMake(w * 0.5 - kFMAirBubblesLabelDistace, radius * 2)];
    [path addLineToPoint:CGPointMake(radius, radius * 2)];
    [path addArcWithCenter:CGPointMake(radius, radius) radius:radius startAngle:M_PI_2 endAngle:M_PI_2 + M_PI clockwise:YES];
    [path stroke];
    
    self.airBubblesLabelMaskLayer.frame = self.bounds;
    self.airBubblesLabelMaskLayer.path = path.CGPath;
    self.airBubblesLabelMaskLayer.strokeColor = [UIColor whiteColor].CGColor;
    self.layer.mask = self.airBubblesLabelMaskLayer;
}

#pragma mark - getter
- (UILabel *)label {
    if (!_label) {
        _label = [UILabel new];
        _label.textColor = [UIColor blackColor];
        _label.text = @"fsdfsdfs";
        _label.font = [UIFont systemFontOfSize:17];
        _label.backgroundColor = [UIColor greenColor];
        _label.frame = CGRectMake(0, 0, 49, 20);
        [_label sizeToFit];
    }
    return _label;
}

- (CAShapeLayer *)airBubblesLabelMaskLayer {
    if (!_airBubblesLabelMaskLayer) {
        _airBubblesLabelMaskLayer = [CAShapeLayer new];
    }
    return _airBubblesLabelMaskLayer;
}

@end
