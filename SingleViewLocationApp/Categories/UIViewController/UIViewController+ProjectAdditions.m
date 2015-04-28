//
//  UIViewController+ProjectAdditions.m
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 4/28/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import "UIViewController+ProjectAdditions.h"

@implementation UIViewController (ProjectAdditions)

- (BOOL)isVisible{
    BOOL isVisible = [self isViewLoaded] && self.view.window;
    return isVisible;
}

@end
