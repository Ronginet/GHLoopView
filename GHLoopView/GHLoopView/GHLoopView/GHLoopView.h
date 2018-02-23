//
//  GHLoopView.h
//  GHLoopView
//
//  Created by Rong on 2017/10/25.
//  Copyright © 2017年 Rong. All rights reserved.
//
// 图片的缓存由外界管理

#import <UIKit/UIKit.h>

@interface GHLoopView : UIView

/// 本地或网络图片数据源
@property (nonatomic, strong) NSArray<UIImage *> *images;
@property (nonatomic, copy) void(^itemClickedBlock)(NSInteger index);
/// 分页控件当前指示点颜色,默认红色
@property (nonatomic, strong) UIColor *currentIndicatorDotColor;
/// 分页控件其他指示点颜色,默认半透明白色
@property (nonatomic, strong) UIColor *pageIndicatorDotColor;
/// 滚动间隔时间,默认3.0秒
@property (nonatomic, assign) CGFloat scrollIntervalTime;
/// 是否隐藏分页控件,默认NO
@property (nonatomic, assign) BOOL hiddenPageControl;
/// 只有一张图片时,是否隐藏分页控件,默认YES
@property (nonatomic, assign) BOOL hiddenForSinglePage;

@end
