//
//  GHLoopViewCell.h
//  GHLoopView
//
//  Created by Rong on 2017/10/25.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GHLoopViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *image;

+ (NSString *)reuseIdentifier;

@end
