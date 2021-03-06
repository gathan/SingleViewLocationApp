//
//  GraphicsProxy.h
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 5/1/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol GraphicsProtocol <NSObject>

@optional
- (void)updateTheme;
- (void)updateThemeViewsGeometry;
- (void)giveGraphicsAndColorOutlets;
- (UIColor*)viewControllerBackgroundColor;
- (UIColor*)navigationControllerBackgroundColor;
- (UIColor*)navigationBarBackgroundColor;
- (NSArray*)titleLabels;
- (NSArray*)titleBoldLabels;
- (NSArray*)titleDifferentLabels;
- (NSArray*)titleDifferentBoldLabels;
- (NSArray*)titleInvertedLabels;
- (NSArray*)titleInvertedBoldLabels;
- (NSArray*)bodyLabels;
- (NSArray*)bodyBoldLabels;
- (NSArray*)bodyInvertedLabels;
- (NSArray*)bodyInvertedBoldLabels;

@end

@interface GraphicsProxy : NSObject

+ (instancetype)sharedProxy;

@property (nonatomic, strong, readonly) UIColor *viewControllerBackgroundColor;

@property (nonatomic, strong, readonly) UIColor *defaultLabelColor;
@property (nonatomic, strong, readonly) UIColor *defaultLabelInvertedColor;
@property (nonatomic, strong, readonly) UIColor *titleLabelColor;
@property (nonatomic, strong, readonly) UIColor *titleLabelInvertedColor;
@property (nonatomic, strong) UIColor *titleDifferentLabelColor;

- (UIStatusBarStyle)statusBarStyle;

- (BOOL)translucentNavigationBar;

- (UIFont*)titleTextFontWithSize:(CGFloat)size;
- (UIFont*)titleBoldTextFontWithSize:(CGFloat)size;

- (UIFont*)bodyTextFontWithSize:(CGFloat)size;
- (UIFont*)bodyBoldTextFontWithSize:(CGFloat)size;

+ (NSString*)colorsFileNameToUse;

@end
