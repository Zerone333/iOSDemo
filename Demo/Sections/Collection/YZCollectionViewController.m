//
//  YZCollectionViewController.m
//  Demo
//
//  Created by administrator on 2020/6/24.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "YZCollectionViewController.h"
#import "YZCollectionViewCell.H"

@interface YZCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *mainCollectionView;
@property (nonatomic, copy) NSArray *dataSource;
@end

@implementation YZCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];

    // 设置item的行间距和列间距
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;

    // 设置item的大小
    CGFloat itemW = 50;
    layout.itemSize = CGSizeMake(itemW, itemW);

    // 设置每个分区的 上左下右 的内边距
    layout.sectionInset = UIEdgeInsetsMake(0, 0 ,0, 0);

//    // 设置分区的头视图和尾视图 是否始终固定在屏幕上边和下边
//    layout.sectionFootersPinToVisibleBounds = YES;

    // 设置滚动条方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor redColor];
    collectionView.showsHorizontalScrollIndicator = NO;   //是否显示滚动条
    collectionView.pagingEnabled = YES;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    //3、添加到控制器的view
    [self.view addSubview:collectionView];
    _mainCollectionView = collectionView;
    collectionView.frame = CGRectMake(20, 100, itemW * 4, itemW * 2);
    
    self.mainCollectionView.delegate = self;
    self.mainCollectionView.dataSource = self;
    [self.mainCollectionView registerClass:[YZCollectionViewCell class] forCellWithReuseIdentifier:@"MAINCOLLECTIONVIEWID"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.dataSource.count %8 == 0) {
        return self.dataSource.count;
    } else {
        return self.dataSource.count / 8 * 8 + 8;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YZCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MAINCOLLECTIONVIEWID" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
    
    NSInteger index = [self  exchangeIndexPath:indexPath totalCount:self.dataSource.count maxCount:8];
    if (index >= self.dataSource.count) {
        cell.textLabel.text = @"";
    } else {
    cell.textLabel.text = self.dataSource[index];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [self  exchangeIndexPath:indexPath totalCount:self.dataSource.count maxCount:8];
       if (index >= self.dataSource.count) {
           NSLog(@"没数据的");
       } else {
           NSLog(@"%@", self.dataSource[index]);
       }
}

- (NSInteger)exchangeIndexPath:(NSIndexPath *)indexPath totalCount:(NSInteger)totalCount maxCount:(NSInteger)maxCount {
    NSInteger tempIndex = 0;
    NSInteger count = indexPath.item / 8 * 8;
    switch (indexPath.row % 8) {
        case 0:
            return 0 + count;
            break;
        case 1:
            return 4 + count;
            break;
        case 2:
            return 1 + count;
            break;
        case 3:
            return 5 + count;
            break;
        case 4:
            return 2 + count;
            break;
        case 5:
            return 3 + count;
            break;
        case 6:
            return 3 + count;
            break;
        case 7:
            return 7 + count;
            break;
        default:
            break;
    }
    return tempIndex;
}

- (NSArray *)dataSource {
    if (!_dataSource) {
        NSMutableArray *tempArray = [NSMutableArray array];
        for (int i = 0; i < 4; i ++) {
            for (int j = 0; j < 8; ++j) {
                [tempArray addObject:[NSString stringWithFormat:@"%d-%d", i, j]];
            }
        }
        [tempArray addObject:@"我"];
        [tempArray addObject:@"的"];
        _dataSource = [tempArray copy];
    }
    return _dataSource;
}

@end
