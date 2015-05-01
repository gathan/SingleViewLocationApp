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

- (void)markLabelAsTitle;
- (void)markLabelAsTitleInverted;

- (void)markLabelAsBody;
- (void)markLabelAsBodyInverted;

@end
