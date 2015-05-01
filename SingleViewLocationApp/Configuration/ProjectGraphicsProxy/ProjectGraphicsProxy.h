//
//  ProjectGraphicsProxy.h
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 5/1/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import "GraphicsProxy.h"
#import "UIView+GraphicsProxy.h"

@interface ProjectGraphicsProxy : GraphicsProxy

#pragma mark - Candy Store Theme - https://color.adobe.com/Candy-store-color-theme-5951199/

@property (nonatomic, strong) UIColor *candyStoreThemeLightGreenColor;
//@property (nonatomic, strong) UIColor *candyStoreThemeLightGreenTransparentColor;

@property (nonatomic, strong) UIColor *candyStoreThemeDarkGreenColor;
@property (nonatomic, strong) UIColor *candyStoreThemeDarkGreenTransparentColor;

@property (nonatomic, strong) UIColor *candyStoreThemeGreenToCyanColor;
//@property (nonatomic, strong) UIColor *candyStoreThemeGreenToCyanTransparentColor;

@property (nonatomic, strong) UIColor *candyStoreThemeRedToBrownColor;
//@property (nonatomic, strong) UIColor *candyStoreThemeRedToBrownTransparentColor;

@property (nonatomic, strong) UIColor *candyStoreThemeCoralColor;
//@property (nonatomic, strong) UIColor *candyStoreThemeCoralTransparentColor;

@property (nonatomic, strong) UIColor *lightGrayTransparentColor;

+ (UIImage*)homeIconImage;
+ (UIImage*)myLocationPinImage;
+ (UIImage*)myLocationImage;
+ (UIImage*)venueSelectedImage;
+ (UIImage*)venueImage;
+ (UIImage*)logo;

@end
