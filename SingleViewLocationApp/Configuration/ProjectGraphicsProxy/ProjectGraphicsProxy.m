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

- (UIFont*)titleTextFontWithSize:(CGFloat)size{
    return [UIFont fontWithName:@"HelveticaNeue" size:size];
}

- (UIFont*)bodyTextFontWithSize:(CGFloat)size{
    return [UIFont fontWithName:@"HelveticaNeue" size:size];
}

@end
