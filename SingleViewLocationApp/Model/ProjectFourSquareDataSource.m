//
//  ProjectFourSquareDataSource.m
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 4/29/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import "ProjectFourSquareDataSource.h"

@implementation ProjectFourSquareDataSource

+ (NSString*)apiKey{
    return @"BZ2UCIU2QH3FXPRCKXGB1MVQ5BFQW1W13BDQFXJ5X5CIYESO";
}

+ (NSString*)callbackURL{
    return @"SingleViewLocationApp://foursquare";
}

+ (NSString*)clientID{
    return @"BZ2UCIU2QH3FXPRCKXGB1MVQ5BFQW1W13BDQFXJ5X5CIYESO";
}

+ (NSString*)clientSecret{
    return @"51RIDYXRRDUZS5PJKULJRZRL4JUYLWJBSDVCIKG4REIOVMGZ";
}

+ (NSString*)versionID{
    return @"20140806";
}

@end
