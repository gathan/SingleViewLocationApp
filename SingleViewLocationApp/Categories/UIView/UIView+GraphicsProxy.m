//
//  UIView+GraphicsProxy.m
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 5/1/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import "UIView+GraphicsProxy.h"
#import <UIKit/UIKit.h>
#import "ProjectGraphicsProxy.h"

@implementation UIView (GraphicsProxy)

- (void)applyFont:(UIFont *)font{
    if ([self isKindOfClass:[UILabel class]]) {
        [UIView applyOnLabel:(UILabel*)self font:font];
    }
}

- (void)markLabelAsTitle{
    UIFont *font = [[ProjectGraphicsProxy sharedProxy] titleTextFontWithSize:0];
    [self applyFont:font];
    UILabel *label = (UILabel*)self;
    label.textColor = [[ProjectGraphicsProxy sharedProxy] titleLabelColor];
}

- (void)markLabelAsTitleInverted{
    UIFont *font = [[ProjectGraphicsProxy sharedProxy] titleTextFontWithSize:0];
    [self applyFont:font];
    UILabel *label = (UILabel*)self;
    label.textColor = [[ProjectGraphicsProxy sharedProxy] titleLabelInvertedColor];
}

- (void)markLabelAsBody{
    UIFont *font = [[ProjectGraphicsProxy sharedProxy] bodyTextFontWithSize:0];
    [self applyFont:font];
    UILabel *label = (UILabel*)self;
    label.textColor = [[ProjectGraphicsProxy sharedProxy] defaultLabelColor];
}

- (void)markLabelAsBodyInverted{
    UIFont *font = [[ProjectGraphicsProxy sharedProxy] bodyTextFontWithSize:0];
    [self applyFont:font];
    UILabel *label = (UILabel*)self;
    label.textColor = [[ProjectGraphicsProxy sharedProxy] defaultLabelInvertedColor];
}

+ (void)applyOnLabel:(UILabel*)label font:(UIFont*)font{
    label.font = [font fontWithSize:label.font.pointSize];
}

@end
