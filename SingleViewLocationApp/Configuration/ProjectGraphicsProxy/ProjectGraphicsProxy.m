//
//  ProjectGraphicsProxy.m
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 5/1/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import "ProjectGraphicsProxy.h"

@implementation ProjectGraphicsProxy

- (UIColor*)defaultLabelColor{
    return self.candyStoreThemeCoralColor;
}

- (UIColor*)titleLabelColor{
    return self.candyStoreThemeCoralColor;
}

- (BOOL)translucentNavigationBar{
    return NO;
}

- (UIStatusBarStyle)statusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (UIFont*)titleTextFontWithSize:(CGFloat)size{
    return [UIFont fontWithName:@"HelveticaNeue" size:size];
}

- (UIFont*)bodyTextFontWithSize:(CGFloat)size{
    return [UIFont fontWithName:@"HelveticaNeue" size:size];
}

+ (UIImage*)homeIconImage{
    UIImage *homeIconImage = [UIImage imageNamed:@"ico-home"];
    return homeIconImage;
}

+ (UIImage*)myLocationPinImage{
    UIImage *myLocationPinImage = [UIImage imageNamed:@"ico-mylocation-pin"];
    return myLocationPinImage;
}

+ (UIImage*)myLocationImage{
    UIImage *myLocationImage = [UIImage imageNamed:@"ico-mylocation"];
    return myLocationImage;
}

+ (UIImage*)venueSelectedImage{
    UIImage *venueSelectedImage = [UIImage imageNamed:@"ico-venue-selected"];
    return venueSelectedImage;
}

+ (UIImage*)venueImage{
    UIImage *venueImage = [UIImage imageNamed:@"ico-venue"];
    return venueImage;
}

+ (UIImage*)logo{
    UIImage *logo = [UIImage imageNamed:@"Logo"];
    return logo;
}


@end
