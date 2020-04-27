//
//  YLTagsChooser.m
//  YLTagsChooser
//
//  Created by TK-001289 on 16/6/13.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "YLTagsChooser.h"
#import "YLWaterFlowLayout.h"
#import "YLCollectionReusableView.h"
#import "YLTag.h"

#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// 屏幕尺寸
#define kFrameWidth [UIScreen mainScreen].bounds.size.width
#define kFrameHeight [UIScreen mainScreen].bounds.size.height

static NSString *headerIdentifier = @"YLCollectionReusableView";
static NSString *footerIdentifier = @"YLCollectionReusableView";
static NSString *cellIdentifier = @"YLTagsCollectionViewCell";

static CGFloat const kBottomBtnHeight = 44.f;
static CGFloat const kBottomGap = 24.f;
static CGFloat const kYGap = 10.f;

@interface YLTagsChooser()<UICollectionViewDataSource,UICollectionViewDelegate,YLWaterFlowLayoutDelegate>
@property (nonatomic,strong) UICollectionView  *myCollectionView;
@property (nonatomic,strong) NSMutableArray    *orignalTags;
@property (nonatomic,strong) NSMutableArray    *selectedTags;
@property (nonatomic, copy) NSArray *headerTitles;

@property (nonatomic, strong) YLTagsChooserConfig *config;
@property (nonatomic, assign) BOOL hasFooter;
@end


@implementation YLTagsChooser
- (instancetype)initWithMaxSelectCount:(CGFloat)maxCount
                              delegate:(id<YLTagsChooserDelegate>)aDelegate
                                config:(YLTagsChooserConfig *)config {
    if(self = [super initWithFrame:CGRectMake(0, 0, kFrameWidth, kFrameHeight)]){
        _orignalTags = [NSMutableArray array];
        _selectedTags = [NSMutableArray array];
        self.config = config;
        self.maxSelectCount = maxCount;
        self.delegate = aDelegate;
        
        [self addSubview:self.myCollectionView];
    }
    return self;
}

-(void)refreshWithTags:(NSArray *)tags selectedTags:(NSArray *)selectedTags headerTitles:(NSArray *)headerTitles; {
    [_orignalTags removeAllObjects];
    [_orignalTags addObjectsFromArray:tags];
    
    [_selectedTags removeAllObjects];
    [_selectedTags addObjectsFromArray:selectedTags];
    self.headerTitles = headerTitles;
    
    for(NSArray *array in _orignalTags){
        for(YLTag *tag in array){
            tag.selected = [_selectedTags containsObject:tag];
        }
    }
    [self.myCollectionView reloadData];
}

- (UICollectionView *)myCollectionView {
    if(!_myCollectionView){
        YLWaterFlowLayout *layout = [[YLWaterFlowLayout alloc]init];
        layout.rowHeight = self.config.rowHeight;
        layout.delegate = self;
        
        if (!self.config.hasHeader) {
            layout.headerReferenceSize = CGSizeZero;
        } else {
            layout.headerReferenceSize = self.config.headerSize;
        }
        
        if (!self.config.hasFooter) {
            layout.footerReferenceSize = CGSizeZero;
        } else {
            layout.headerReferenceSize = self.config.footerSize;
        }
        
        _myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kYGap, kFrameWidth, _bottomHeight - 2 * kYGap - kBottomGap - kBottomBtnHeight)
                                              collectionViewLayout:layout];
        _myCollectionView.backgroundColor = [UIColor clearColor];
        [_myCollectionView registerClass:[YLCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
        [_myCollectionView registerClass:[YLCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerIdentifier];
        [_myCollectionView registerClass:[YLTagsCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
        _myCollectionView.dataSource = self;
        _myCollectionView.delegate = self;
        _myCollectionView.showsHorizontalScrollIndicator = NO;
    }
    return _myCollectionView;
}

#pragma mark---UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _orignalTags.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *sectionData = [_orignalTags objectAtIndex:section];
    if([sectionData isKindOfClass:[NSArray class]]){
        return sectionData.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YLTagsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier
                                                                               forIndexPath:indexPath];
    NSArray *sectionData = [_orignalTags objectAtIndex:indexPath.section];
    YLTag *tag = [sectionData objectAtIndex:indexPath.row];
    [cell refreshWithObject:tag];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (!self.config.hasHeader) {
            return nil;
        }
        YLCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
        NSString *title = self.headerTitles[indexPath.section];
        [header setTitle:title];
        return header;
    } else {
        if (!self.config.hasFooter) {
            return nil;
        }
        YLCollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerIdentifier forIndexPath:indexPath];
        [footer setTitle:[NSString stringWithFormat:@"Section Footer %li",(long)indexPath.section]];
        return footer;
    }
}

#pragma mark---YLWaterFlowLayoutDelegate

- (CGFloat)waterFlowLayout:(YLWaterFlowLayout *)layout widthAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *sectionData = [_orignalTags objectAtIndex:indexPath.section];
    YLTag *tag = [sectionData objectAtIndex:indexPath.row];
    CGSize size = CGSizeMake(kFrameWidth - layout.sectionInset.left - layout.sectionInset.right,CGFLOAT_MAX);
    CGRect textRect = [tag.name
                       boundingRectWithSize:size
                       options:NSStringDrawingUsesLineFragmentOrigin
                       attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}
                       context:nil];
    CGFloat width = textRect.size.width + 12 * 2;
    width = MIN(self.config.maxItemWidth, width);
    return width;
}

#pragma mark---UICollectionViewDelegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *sectionData = [_orignalTags objectAtIndex:indexPath.section];
    YLTag *tag = [sectionData objectAtIndex:indexPath.row];
    if(![_selectedTags containsObject:tag]) {
        if (_maxSelectCount == 1) { // 单选操作
            YLTag *beforeTag = [_selectedTags firstObject];
            beforeTag.selected = NO;
            [_selectedTags removeObject:beforeTag];
            
            tag.selected = YES;
            [_selectedTags addObject:tag];
            if ([self.delegate respondsToSelector:@selector(tagsChooser:selectedTags:)]) {
                [self.delegate tagsChooser:self selectedTags:@[indexPath]];
            }
        }
        if (_selectedTags.count >= _maxSelectCount) {
            
        } else{
            tag.selected = YES;
            [_selectedTags addObject:tag];
        }
    } else {
        tag.selected = NO;
        [_selectedTags removeObject:tag];
    }
    
    [collectionView reloadData];
}

#pragma mark---animation method
- (void)showInView:(UIView *)view frame:(CGRect)frame{
    [view addSubview:self];
    self.myCollectionView.frame = frame;
}

@end

#pragma mark---标签cell
@implementation YLTagsCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        
        self.gradientLayer =  [CAGradientLayer layer];
        self.gradientLayer.startPoint = CGPointMake(0, 0);
        self.gradientLayer.endPoint = CGPointMake(1, 0);
        self.gradientLayer.locations = @[@(0.5),@(1.0)];//渐变点
        [self.gradientLayer setColors:@[[UIColor redColor], [UIColor purpleColor]]];//渐变数组
        [self.contentView.layer addSublayer:self.gradientLayer];
        
        _textLabel = [[UILabel alloc]init];
        //此处可以根据需要自己使用自动布局代码实现
        _textLabel.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.font = [UIFont systemFontOfSize:13];
        _textLabel.textColor = HEXCOLOR(0x999999);
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.layer.masksToBounds = YES;
        [self.contentView addSubview:_textLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.textLabel.frame = self.bounds;
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.gradientLayer.frame = self.bounds;
    self.gradientLayer.cornerRadius = self.bounds.size.height * 0.5;
    [CATransaction commit];
    self.textLabel.layer.cornerRadius = self.bounds.size.height * 0.5;
}

- (void)refreshWithObject:(NSObject *)obj {
    if([obj isKindOfClass:[YLTag class]]) {
        YLTag *tag = (YLTag *)obj;
        UIColor *titleColor = tag.selected ? HEXCOLOR(0xffffff) : HEXCOLOR(0x999999);
        UIColor *labelBgColor = tag.selected ? [UIColor clearColor] : HEXCOLOR(0xF5F5F5);
        self.textLabel.textColor = titleColor;
        self.textLabel.backgroundColor = labelBgColor;
        self.textLabel.text = tag.name;
        self.gradientLayer.hidden = !tag.selected;
    }
}


- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    UIColor *titleColor = selected ? HEXCOLOR(0xffffff) : HEXCOLOR(0x999999);
    UIColor *labelBgColor = selected ? [UIColor clearColor] : HEXCOLOR(0xF5F5F5);
    self.textLabel.backgroundColor = labelBgColor;
    self.textLabel.textColor = titleColor;
    self.gradientLayer.hidden = !selected;
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    UIColor *titleColor = highlighted ? HEXCOLOR(0xffffff) : HEXCOLOR(0x999999);
    UIColor *labelBgColor = highlighted ? [UIColor clearColor] : HEXCOLOR(0xF5F5F5);
    self.textLabel.backgroundColor = labelBgColor;
    self.textLabel.textColor = titleColor;
    self.gradientLayer.hidden = !highlighted;
}

@end
