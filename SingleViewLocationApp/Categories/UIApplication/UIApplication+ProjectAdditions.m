//
//  UIApplication+ProjectAdditions.m
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 4/28/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import "UIApplication+ProjectAdditions.h"

@implementation UIApplication (ProjectAdditions)

+ (BOOL)iOSLessThan8{
    BOOL iOSLessThan8 = [[UIDevice currentDevice].systemVersion floatValue] < 8.0f;
    return iOSLessThan8;
}

@end
