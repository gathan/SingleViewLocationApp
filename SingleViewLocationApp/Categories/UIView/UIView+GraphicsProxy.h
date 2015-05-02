//
//  UIView+GraphicsProxy.h
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 5/1/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GraphicsProxy)

- (void)applyFont:(UIFont*)font;

- (void)markLabelAsTitleThatIsBold:(BOOL)bold;
- (void)markLabelAsTitleInvertedThatIsBold:(BOOL)bold;
- (void)markLabelAsTitleDifferentThatIsBold:(BOOL)bold;

- (void)markLabelAsBodyThatIsBold:(BOOL)bold;
- (void)markLabelAsBodyInvertedThatIsBold:(BOOL)bold;

@end
