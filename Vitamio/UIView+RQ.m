//
//  UIView+RQ.m
//  view上加图片
//
//  Created by sen5labs on 14-11-27.
//  Copyright (c) 2014年 sen5labs. All rights reserved.
//

#import "UIView+RQ.h"

@implementation UIView (RQ)

- (void)setImage:(NSString *)imageName
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.bounds];
    UIImage *image = [UIImage imageNamed:imageName];
    imageView.image = image;
    [imageView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self addSubview:imageView];
}

@end
