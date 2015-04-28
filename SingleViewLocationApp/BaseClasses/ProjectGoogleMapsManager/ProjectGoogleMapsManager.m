//
//  ProjectGoogleMapsManager.m
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 4/29/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import "ProjectGoogleMapsManager.h"

@implementation ProjectGoogleMapsManager

+ (void)prepareAfterAppDidFinishLaunching{
    NSString *apiKey = [[self class] apiKey];//self is already the class ;)
    [GMSServices provideAPIKey:apiKey];
}

+ (NSString*)apiKey{
    return @"Must Subclass GoogleMapsProjectManager and provide your api key by overriding";
}

@end
