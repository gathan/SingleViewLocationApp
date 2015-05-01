//
//  UserLocationAnnotationView.m
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 5/1/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import "UserLocationAnnotationView.h"
#import "ProjectGraphicsProxy.h"

@implementation UserLocationAnnotationView

#pragma mark - Class Methods

+ (NSString*)defaultAnnotationIdentifier{
    return @"defaultUserReuseIdentifier";
}

+ (UIImage*)selectedImage{
    return [ProjectGraphicsProxy myLocationPinImage];
}

+ (UIImage*)nonSelectedImage{
    return [ProjectGraphicsProxy myLocationPinImage];
}

@end
