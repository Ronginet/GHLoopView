//
//  GHLoopViewLayout.m
//  GHLoopView
//
//  Created by Rong on 2017/10/25.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "GHLoopViewLayout.h"

@implementation GHLoopViewLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    self.itemSize = self.collectionView.bounds.size;
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
}

@end
