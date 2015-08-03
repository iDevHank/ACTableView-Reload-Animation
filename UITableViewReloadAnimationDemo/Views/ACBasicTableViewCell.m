//
//  ACBasicTableViewCell.m
//  UITableViewReloadAnimationDemo
//
//  Created by Avalon on 15/8/3.
//  Copyright (c) 2015年 Hank. All rights reserved.
//

#import "ACBasicTableViewCell.h"

@interface ACBasicTableViewCell ()

@property (strong, nonatomic) UIImageView *customImageView;

@end

@implementation ACBasicTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.customImageView];
    }
    return self;
}

- (void)setCustomImage:(UIImage *)image
{
    if (self.customImageView.image != image) {
        self.customImageView.image = image;
    }
}

- (UIImageView *)customImageView
{
    if (!_customImageView) {
        _customImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kCellHeight)];
        _customImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _customImageView;
}

@end
