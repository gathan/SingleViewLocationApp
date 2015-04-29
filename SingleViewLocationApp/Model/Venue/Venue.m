//
//  Venue.m
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 4/29/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import "Venue.h"
#import "NSObject+ProjectAdditions.h"
#import <CoreLocation/CoreLocation.h>

@implementation Venue

+ (NSDictionary*)propertiesAndKeysDictionary{
    NSDictionary *propertiesAndKeysDictionary = @{@"name"               : @"name",
                                                  @"verified"           : @"verified",
                                                  @"twitter"            : @"twitter",
                                                  @"phone"              : @"phone",
                                                  @"formattedPhone"     : @"formattedPhone",
                                                  @"address"            : @"address",
                                                  @"formattedAddress"   : @"formattedAddress",
                                                  @"cc"                 : @"cc",
                                                  @"city"               : @"city",
                                                  @"country"            : @"country",
                                                  @"distance"           : @"distance",
                                                  @"lat"                : @"latitude",
                                                  @"lng"                : @"longtitude",
                                                  @"postalCode"         : @"postalCode"};
    
    NSDictionary *superPropertiesAndKeysDictionary = [[self superclass] propertiesAndKeysDictionary];
    NSMutableDictionary *finalPropertiesAndKeysMutableDictionary = [[NSMutableDictionary alloc]init];
    
    [finalPropertiesAndKeysMutableDictionary addEntriesFromDictionary:propertiesAndKeysDictionary];
    [finalPropertiesAndKeysMutableDictionary addEntriesFromDictionary:superPropertiesAndKeysDictionary];
    
    return finalPropertiesAndKeysMutableDictionary;
}

- (NSDictionary*)parseObjectDictionaryFromObject:(NSObject*)object forKey:(NSString*)key{
    NSMutableDictionary *objectDictionary = [[NSMutableDictionary alloc]init];
    if (key) {
        NSDictionary *dictionaryForObject = (NSDictionary*)object;
        if ([key isEqualToString:@"contact"]) {
            NSString *twitter = [dictionaryForObject objectForKey:@"twitter"];
            NSString *phone = [dictionaryForObject objectForKey:@"phone"];
            NSString *formattedPhone = [dictionaryForObject objectForKey:@"formattedPhone"];
            
            [self setObject:twitter forKey:@"twitter"];
            [self setObject:phone forKey:@"phone"];
            [self setObject:formattedPhone forKey:@"formatterdPhone"];
        }
        else if ([key isEqualToString:@"location"])
        {
            NSString *address = [dictionaryForObject objectForKey:@"address"];
            NSString *cc = [dictionaryForObject objectForKey:@"cc"];
            NSString *city = [dictionaryForObject objectForKey:@"city"];
            NSString *country = [dictionaryForObject objectForKey:@"country"];
            NSNumber *distance = [dictionaryForObject objectForKey:@"distance"];
            NSString *formattedAddress = [dictionaryForObject objectForKey:@"formattedAddress"];
            
            CLLocationDegrees lat = [[dictionaryForObject objectForKey:@"lat"] doubleValue];
            CLLocationDegrees lng = [[dictionaryForObject objectForKey:@"lng"] doubleValue];

            NSString *postalCode = [dictionaryForObject objectForKey:@"postalCode"];
            NSString *state = [dictionaryForObject objectForKey:@"state"];
            
            [self setObject:address forKey:@"address"];
            [self setObject:cc forKey:@"cc"];
            [self setObject:city forKey:@"city"];
            [self setObject:country forKey:@"country"];
            [self setObject:distance forKey:@"distance"];
            [self setObject:formattedAddress forKey:@"formattedAddress"];
            [self setObject:@(lat) forKey:@"lat"];
            [self setObject:@(lng) forKey:@"lng"];
            [self setObject:postalCode forKey:@"postalCode"];
            [self setObject:state forKey:@"state"];
        }
 
        [self setObject:object forKey:key];
    }
    else
    {
        [super parseObjectDictionaryFromObject:object forKey:key];
    }
    
    return objectDictionary;
}

- (NSString*)description{
    NSMutableString *descriptionMutableString = [[NSMutableString alloc]initWithString:[super description]];
    
    if ([self.name isStringAndNotEmpty]) {
        [descriptionMutableString appendFormat:@" | name: %@", self.name];
    }
    
    if ([self.phone isStringAndNotEmpty]) {
        [descriptionMutableString appendFormat:@" | phone: %@", self.phone];
    }
    
    if ([self.formattedPhone isStringAndNotEmpty]) {
        [descriptionMutableString appendFormat:@" | formattedPhone: %@", self.formattedPhone];
    }
    
    if ([self.twitter isStringAndNotEmpty]) {
        [descriptionMutableString appendFormat:@" | twitter: %@", self.twitter];
    }
    
    if ([self.formattedAddress isStringAndNotEmpty]) {
        [descriptionMutableString appendFormat:@" | formattedAddress: %@", self.formattedAddress];
    }
    
    if ([self.address isStringAndNotEmpty]) {
        [descriptionMutableString appendFormat:@" | address: %@", self.address];
    }
    
    if ([self.name isStringAndNotEmpty]) {
        [descriptionMutableString appendFormat:@" | name: %@", self.name];
    }
    
    if ([self.phone isStringAndNotEmpty]) {
        [descriptionMutableString appendFormat:@" | phone: %@", self.phone];
    }
    
    if ([self.address isStringAndNotEmpty]) {
        [descriptionMutableString appendFormat:@" | address: %@", self.address];
    }
    
    if ([self.city isStringAndNotEmpty]) {
        [descriptionMutableString appendFormat:@" | city: %@", self.city];
    }
    
    if ([self.country isStringAndNotEmpty]) {
        [descriptionMutableString appendFormat:@" | country: %@", self.country];
    }
    
    if ([self.latitude.stringValue isStringAndNotEmpty]) {
        [descriptionMutableString appendFormat:@" | postalCode: %@", self.postalCode];
    }
    
    return descriptionMutableString;
}

@end
