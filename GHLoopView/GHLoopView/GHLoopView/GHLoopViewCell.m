//
//  GHLoopViewCell.m
//  GHLoopView
//
//  Created by Rong on 2017/10/25.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "GHLoopViewCell.h"

@interface GHLoopViewCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation GHLoopViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createImageView];
    }
    return self;
}

- (void)createImageView {
    self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self.contentView addSubview:self.imageView];
}

#pragma mark - Public

+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

#pragma mark - Getter,Setter

- (void)setImage:(UIImage *)image {
    _image = image;
    
    self.imageView.image = image;
}

@end
