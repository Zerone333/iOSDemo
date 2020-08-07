//
//  YZGraffitiView.m
//  Demo
//
//  Created by administrator on 2020/7/21.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "YZGraffitiView.h"
#import "YZCustomerBezierPath.h"

@interface YZGraffitiView () <CAAnimationDelegate>
@property (nonatomic, strong) UIColor *lineColor; //保存当前线条的颜色
@property (nonatomic, assign) CGFloat lineWidth;

@property (nonatomic, strong) NSMutableArray *lineArray;
@property (nonatomic, assign) CGPoint upPoint;

@property (nonatomic, strong) NSMutableArray<NSMutableArray *> *imageArray;
@property (nonatomic, copy) NSArray<UIImageView *> *animateImageViews;

@end

@implementation YZGraffitiView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.lineColor = [UIColor redColor];
        self.lineWidth = 5;
        
        UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        clearBtn.backgroundColor = [UIColor purpleColor];
        [clearBtn setTitle:@"清空" forState:UIControlStateNormal];
        clearBtn .frame = CGRectMake(0, 100, 40, 40);
        [clearBtn addTarget:self action:@selector(clearBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:clearBtn];
        
        UIButton *upBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        upBtn.backgroundColor = [UIColor purpleColor];
        [upBtn setTitle:@"上一步" forState:UIControlStateNormal];
        upBtn .frame = CGRectMake(60, 100, 60, 40);
        [upBtn addTarget:self action:@selector(upBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:upBtn];
        
        UIButton *sentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sentBtn.backgroundColor = [UIColor purpleColor];
        [sentBtn setTitle:@"动画" forState:UIControlStateNormal];
        sentBtn .frame = CGRectMake(140, 100, 40, 40);
        [sentBtn addTarget:self action:@selector(sentBtnAcstion:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sentBtn];
    }
    return self;
}
- (void)drawRect:(CGRect)rect{
    //遍历数组，绘制曲线
//    if(self.lineArray.count > 0){
//        for (YZCustomerBezierPath *path in self.lineArray) {
//            [path.color setStroke];
//            [path setLineCapStyle:kCGLineCapRound];
//            [path stroke];
//        }
//    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //1、每次触摸的时候都应该去创建一条贝塞尔曲线
    YZCustomerBezierPath *path = [YZCustomerBezierPath new];
    NSMutableArray *images = [NSMutableArray array];
    
    //2、移动画笔
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [path moveToPoint:point];
    //设置线宽
    path.lineWidth = self.lineWidth;
    //狮子颜色
    path.color = self.lineColor;//保存线条当前颜色
    [self.lineArray addObject:path];
    NSLog(@" ???start %f-%f", point.x, point.y);
    self.upPoint = point;
    [path.pointsArray addObject:[NSValue valueWithCGPoint:point]];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KYZGraffitiItemW, KYZGraffitiItemW)];
    image.image = [UIImage imageNamed:@"1"];
    image.center = point;
    [self addSubview:image];
    
    [images addObject:image];
    [self.imageArray addObject:images];
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    //间距
    CGFloat xDist = (self.upPoint.x - point.x);
    CGFloat yDist = (self.upPoint.y - point.y);
    CGFloat distance = sqrt((xDist * xDist) + (yDist * yDist));
    NSLog(@"distance  %f", distance);
    if (distance < KYZGraffitiItemW + KYZGraffitiItemDistance) {
        return;
    }

    CGPoint tempPoint = self.upPoint;
    if (distance >= KYZGraffitiItemW + KYZGraffitiItemDistance) {
        CGFloat r = atan(fabs(yDist/xDist));
        NSLog(@"r %f", r);
        CGFloat x = (KYZGraffitiItemW + KYZGraffitiItemDistance) * cos(r);
        CGFloat y = (KYZGraffitiItemW  + KYZGraffitiItemDistance )* sin(r);
        
        if (point.x > self.upPoint.x) {
        } else {
            x = -x;
        }
        if (point.y > self.upPoint.y) {
            
        } else {
            y = -y;
        }
        
        NSInteger count = distance / (KYZGraffitiItemW + KYZGraffitiItemDistance);
        NSLog(@"count %ld", (long)count);
        for (int i = 0; i <count; ++i) {
            CGFloat xDistm = tempPoint.x + x;
            CGFloat yDistm = tempPoint.y + y;
            tempPoint = CGPointMake(xDistm, yDistm);
            
            UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KYZGraffitiItemW, KYZGraffitiItemW)];
            image.image = [UIImage imageNamed:@"1"];
            image.center = tempPoint;
            [self addSubview:image];
            YZCustomerBezierPath *path = self.lineArray.lastObject;
            NSMutableArray *images = self.imageArray.lastObject;
            [images addObject:image];
            [path addLineToPoint:CGPointMake(xDistm, yDistm)];
            [path.pointsArray addObject:[NSValue valueWithCGPoint:tempPoint]];
            NSLog(@"point %f-%f", xDistm, yDistm);
        }
    }
    self.upPoint = tempPoint;
}

#pragma mark - getter

- (NSMutableArray *)lineArray {
    if (!_lineArray) {
        _lineArray = [NSMutableArray array];
    }
    return _lineArray;
}

- (NSMutableArray<NSMutableArray *> *)imageArray {
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

#pragma mark - event

- (void)clearBtnAction:(UIButton *)btn {
    for (NSMutableArray *array in self.imageArray) {
        for (UIImageView *imageView in array) {
            [imageView removeFromSuperview];
        }
    }
    
    [self.imageArray removeAllObjects];
    [self.lineArray removeAllObjects];
    
}

- (void)upBtnAction:(UIButton *)btn {
    YZCustomerBezierPath *path = self.lineArray.lastObject;
    [self.lineArray removeObject:path];
    NSMutableArray *imageViews = self.imageArray.lastObject;
    for (UIImageView *imageView in imageViews) {
        [imageView removeFromSuperview];
    }
    [self.imageArray removeObject:imageViews];
}

- (void)sentBtnAcstion:(UIButton *)btn {
    NSMutableArray *pointsArray = [self.lineArray copy];
    [self clearBtnAction:nil];
    NSMutableArray *imagesArray = [NSMutableArray array];
    for (YZCustomerBezierPath *path in pointsArray) {
        for (NSValue *point in path.pointsArray) {
            CGFloat proportion = 1; // 屏幕适配的尺寸 如果需要的话
            UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KYZGraffitiItemW * proportion, KYZGraffitiItemW * proportion)];
            image.image = [UIImage imageNamed:@"1"];
            image.center = CGPointMake(proportion * [point CGPointValue].x, [point CGPointValue].y * proportion) ;
            image.alpha= 0;
            [self addSubview:image];
            [imagesArray addObject:image];
        }
    }
    self.animateImageViews = imagesArray;
    [self animate:imagesArray index:0];
}

- (void)animate:(NSArray *)images index:(NSInteger)index {
    if (index >= images.count) {
            for (UIImageView *imageView in self.animateImageViews) {
                [self endAnimate:imageView forKey:@"key"];
            }
        return;
    }
    
    [UIView animateWithDuration:1.0/images.count animations:^{
        UIImageView *imageView = images[index];
        imageView.alpha= 1;
        NSLog(@"show %ld", (long)index);
    } completion:^(BOOL finished) {
        [self animate:images index:index + 1];
    }];
}

- (void)endAnimate:(UIImageView *)imageView forKey:(NSString *)key{
    CABasicAnimation *animation1 =[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation1.fromValue=[NSNumber numberWithFloat:1.0];
    animation1.toValue=[NSNumber numberWithFloat:1.5];
    animation1.duration = 1.0f;
    animation1.removedOnCompletion = NO;
    animation1.fillMode = kCAFillModeForwards;
    animation1.autoreverses = NO;
    
    CABasicAnimation *animation2 =[CABasicAnimation animationWithKeyPath:@"opacity"];
    animation2.fromValue=[NSNumber numberWithFloat:1];
    animation2.toValue=[NSNumber numberWithFloat:0.01];
    animation2.removedOnCompletion = NO;
    animation2.fillMode = kCAFillModeForwards;
    animation2.autoreverses = NO;
    
    CAAnimationGroup *animaGroup = [CAAnimationGroup animation];
    animaGroup.duration = 2.0f;
    animaGroup.removedOnCompletion = NO;
    animaGroup.fillMode = kCAFillModeForwards;
    animaGroup.repeatCount= 1;
    animaGroup.animations = @[animation1, animation2];
    animaGroup.delegate = self;
    
    [imageView.layer addAnimation:animaGroup forKey:key];
    
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    UIImageView *imageView = self.animateImageViews.lastObject;
    if (anim == [imageView.layer animationForKey:@"key"]) {
        for (UIImageView *imageView in self.animateImageViews) {
            [imageView removeFromSuperview];
        }
        self.animateImageViews = nil;
    }
}

@end
