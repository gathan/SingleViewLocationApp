//
//  VenueAnnotationView.m
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 5/1/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import "VenueAnnotationView.h"
#import "ProjectGraphicsProxy.h"

@implementation VenueAnnotationView

#pragma mark - Class Methods

+ (NSString*)defaultAnnotationIdentifier{
    return @"defaultVenueReuseIdentifier";
}

+ (UIImage*)selectedImage{
    return [ProjectGraphicsProxy venueSelectedImage];
}

+ (UIImage*)nonSelectedImage{
    return [ProjectGraphicsProxy venueImage];
}

@end
