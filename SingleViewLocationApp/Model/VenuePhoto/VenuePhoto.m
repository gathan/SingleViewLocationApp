//
//  VenuePhoto.m
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 5/3/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import "VenuePhoto.h"
#import "NSObject+ProjectAdditions.h"
#import "FourSquareDataSource+ProjectAdditions.h"

@implementation VenuePhoto

+ (NSDictionary*)propertiesAndKeysDictionary{
    NSDictionary *propertiesAndKeysDictionary = @{@"prefix"             : @"prefix",
                                                  @"suffix"             : @"suffix",
                                                  @"width"              : @"width" ,
                                                  @"height"             : @"height" };
    
    NSDictionary *superPropertiesAndKeysDictionary = [[self superclass] propertiesAndKeysDictionary];
    NSMutableDictionary *finalPropertiesAndKeysMutableDictionary = [[NSMutableDictionary alloc]init];
    
    [finalPropertiesAndKeysMutableDictionary addEntriesFromDictionary:propertiesAndKeysDictionary];
    [finalPropertiesAndKeysMutableDictionary addEntriesFromDictionary:superPropertiesAndKeysDictionary];
    
    return finalPropertiesAndKeysMutableDictionary;
}

- (NSString*)description{
    NSMutableString *descriptionMutableString = [[NSMutableString alloc]initWithString:[super description]];
    
    if ([self.prefix isStringAndNotEmpty]) {
        [descriptionMutableString appendFormat:@" | prefix: %@", self.prefix];
    }
    
    if ([self.suffix isStringAndNotEmpty]) {
        [descriptionMutableString appendFormat:@" | suffix: %@", self.suffix];
    }
    
    if ([self.width isNumber]) {
        [descriptionMutableString appendFormat:@" | width: %@", self.width];
    }
    
    if ([self.height isNumber]) {
        [descriptionMutableString appendFormat:@" | height: %@", self.height];
    }
    
    if ([self.prefix isStringAndNotEmpty] &&
        [self.suffix isStringAndNotEmpty])
    {
        NSString *originalPhotoURLString = [FourSquareDataSource urlStringForFourSquarePhotoPrefix:self.prefix
                                                                                         andSuffix:self.suffix
                                                                                   withCustomWidth:NO
                                                                                       ofWidthSize:0
                                                                                  withCustomHeight:NO ofHeightSize:0
                                                                                   orOriginalPhoto:YES];
        
        [descriptionMutableString appendFormat:@" | originalPhotoURL: %@", originalPhotoURLString];
    }
    
    return descriptionMutableString;
}

@end
