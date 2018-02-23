//
//  GHLoopView.m
//  GHLoopView
//
//  Created by Rong on 2017/10/25.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "GHLoopView.h"
#import "GHLoopViewLayout.h"
#import "GHLoopViewCell.h"

@interface GHLoopView () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) GHLoopViewLayout *layout;

@end

@implementation GHLoopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollIntervalTime = 3.0;
        self.hiddenPageControl = NO;
        self.hiddenForSinglePage = YES;
        [self createCollectionView];
        [self createPageControl];
    }
    return self;
}

- (void)createCollectionView {
    self.layout = [[GHLoopViewLayout alloc] init];
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self addSubview:self.collectionView];
    
    [self.collectionView registerClass:[GHLoopViewCell class] forCellWithReuseIdentifier:[GHLoopViewCell reuseIdentifier]];
}

- (void)createPageControl {
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.hidden = self.hiddenPageControl;
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    [self addSubview:self.pageControl];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.pageControl.center = CGPointMake(self.center.x, self.bounds.size.height - 15);
}

// 当轮播图用于二级页面或其他子页面时,确保定时器可以正确被销毁
- (void)willRemoveSubview:(UIView *)subview {
    [super willRemoveSubview:subview];
    
    [self invalidateTimer];
}

#pragma mark - Private

- (void)addTimer {
    self.timer = [NSTimer timerWithTimeInterval:self.scrollIntervalTime target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    [self.timer fire];
}

- (void)invalidateTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)nextPage {
    NSInteger nextIndex = (self.pageControl.currentPage + 1);
    if (nextIndex == self.images.count) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
        return;
    }
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:nextIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

#pragma mark - UICollectionViewDataSource,UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images.count * (self.images.count == 1 ? 1 : 100);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GHLoopViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[GHLoopViewCell reuseIdentifier] forIndexPath:indexPath];
    cell.image = self.images[indexPath.item % self.images.count];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.itemClickedBlock) {
        self.itemClickedBlock(indexPath.item);
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    if (offsetX < 0) {
        self.pageControl.currentPage = self.pageControl.numberOfPages - 1;
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.images.count - 1 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    } else if (offsetX > scrollView.bounds.size.width * (self.images.count)) {
        self.pageControl.currentPage = 0;
        NSIndexPath * indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    } else {
        int page = offsetX / scrollView.frame.size.width + 0.5;
        self.pageControl.currentPage = page;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self invalidateTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self addTimer];
}

#pragma mark - Getter,Setter

- (void)setImages:(NSArray<UIImage *> *)images {
    _images = images;
    
    self.pageControl.numberOfPages = images.count;
    if (images.count > 1) {  // 轮播图数量大于1时,才需要定时滚动
        [self addTimer];
        self.pageControl.hidden = self.hiddenPageControl;
    } else {
        self.pageControl.hidden = self.hiddenForSinglePage;
    }
}

- (void)setCurrentIndicatorDotColor:(UIColor *)currentIndicatorDotColor {
    _currentIndicatorDotColor = currentIndicatorDotColor;
    
    self.pageControl.currentPageIndicatorTintColor = currentIndicatorDotColor;
}

- (void)setPageIndicatorDotColor:(UIColor *)pageIndicatorDotColor {
    _pageIndicatorDotColor = pageIndicatorDotColor;
    
    self.pageControl.pageIndicatorTintColor = pageIndicatorDotColor;
}

- (void)setScrollIntervalTime:(CGFloat)scrollIntervalTime {
    _scrollIntervalTime = scrollIntervalTime;
    
    [self invalidateTimer];
    [self addTimer];
}

- (void)setHiddenPageControl:(BOOL)hiddenPageControl {
    _hiddenPageControl = hiddenPageControl;
    
    self.pageControl.hidden = hiddenPageControl;
}

- (void)setHiddenForSinglePage:(BOOL)hiddenForSinglePage {
    _hiddenForSinglePage = hiddenForSinglePage;
    
    self.pageControl.hidden = hiddenForSinglePage;
}

@end
