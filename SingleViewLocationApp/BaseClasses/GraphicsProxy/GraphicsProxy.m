//
//  GraphicsProxy.m
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 5/1/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import "GraphicsProxy.h"
#import "NSString+ProjectAdditions.h"
#import "NSObject+ProjectAdditions.h"

@interface GraphicsProxy ()

@property (nonatomic, strong) NSString *flavorIdentifier;

@end

@implementation GraphicsProxy

+ (instancetype)sharedProxy{
    static GraphicsProxy *sharedProxy = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedProxy = [[self alloc] init];
    });
    return sharedProxy;
}

- (instancetype)init {
    if (self = [super init])
    {
        [self setupColors];
        [self setStatusBarColor];
    }
    return self;
}

- (NSString *)flavorIdentifier{
    if (!_flavorIdentifier) {
        _flavorIdentifier = @"DefaultFlavorIdentifier";
    }
    return _flavorIdentifier;
}

- (BOOL)translucentNavigationBar{
    return YES;
}

- (void)setupColors
{
    NSDictionary *colorsPlistDictionaryForFlavorIdentifier = [GraphicsProxy colorsPlistDictionaryForFlavorIdentifier:self.flavorIdentifier];
    for (NSString *key in colorsPlistDictionaryForFlavorIdentifier.allKeys)
    {
        NSString *rgbaBarSeparatedString = [colorsPlistDictionaryForFlavorIdentifier objectForKey:key];
        UIColor *color = [rgbaBarSeparatedString colorFromRGBABarSeparatedString];
        if (![color isNull] && color)
        {
            [self setValue:color forKey:key];
        }
    }
}

- (void)setStatusBarColor{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] setStatusBarStyle:[self statusBarStyle] animated:YES];
    });
}

- (UIStatusBarStyle)statusBarStyle{
    return UIStatusBarStyleDefault;
}

// UIFontTextStyleHeadline NS_AVAILABLE_IOS(7_0);
// UIFontTextStyleBody NS_AVAILABLE_IOS(7_0);
// UIFontTextStyleSubheadline NS_AVAILABLE_IOS(7_0);
// UIFontTextStyleFootnote NS_AVAILABLE_IOS(7_0);
// UIFontTextStyleCaption1 NS_AVAILABLE_IOS(7_0);
// UIFontTextStyleCaption2 NS_AVAILABLE_IOS(7_0);

- (UIFont*)titleTextFontWithSize:(CGFloat)size{
    return [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
}

- (UIFont*)titleBoldTextFontWithSize:(CGFloat)size{
    return [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
}

- (UIFont*)bodyTextFontWithSize:(CGFloat)size{
    return [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}

- (UIFont*)bodyBoldTextFontWithSize:(CGFloat)size{
    return [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}

+ (NSString*)colorsFileNameToUse{
    return @"Colors";
}

+ (NSString*)colorsPlistPathString{
    NSString *colorsPlistPathString = [[NSBundle mainBundle] pathForResource:[[self class] colorsFileNameToUse] ofType:@"plist"];
    return colorsPlistPathString;
}

+ (NSDictionary*)colorsPlistDictionary{
    NSString *colorsPlistPathString = [[self class] colorsPlistPathString];
    NSDictionary *colorsPlistDictionary = [NSDictionary dictionaryWithContentsOfFile:colorsPlistPathString];
    return colorsPlistDictionary;
}

+ (NSDictionary*)colorsPlistDictionaryForFlavorIdentifier:(NSString*)flavorIdentifier
{
    NSDictionary *colorsPlistDictionaryForFlavorIdentifier;
    if ([flavorIdentifier isStringAndNotEmpty])
    {
        NSDictionary *colorsPlistDictionary= [[self class] colorsPlistDictionary];
        colorsPlistDictionaryForFlavorIdentifier = [colorsPlistDictionary objectForKey:flavorIdentifier];
    }
    return colorsPlistDictionaryForFlavorIdentifier;
}

@end
