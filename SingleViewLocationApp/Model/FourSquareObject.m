//
//  FourSquareObject.m
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 4/29/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import "FourSquareObject.h"
#import "NSObject+ProjectAdditions.h"

@interface FourSquareObject ()

@end

@implementation FourSquareObject

- (BOOL)isEqual:(id)object{
    BOOL isEqual = NO;
    if ([object isKindOfClass:[FourSquareObject class]]) {
        FourSquareObject *otherObject = (FourSquareObject*)object;
        if ([otherObject.codeId isStringAndNotEmpty] && [self.codeId isStringAndNotEmpty] &&
            [otherObject.codeId isEqualToString:self.codeId]){
            isEqual = YES;
        }
    }
    return isEqual;
}

+ (NSDictionary*)propertiesAndKeysDictionary{
    NSDictionary *propertiesAndKeysDictionary = @{@"id" : @"codeId"};
    return propertiesAndKeysDictionary;
}

+ (NSString*)propertyNameForKey:(NSString*)key{
    NSDictionary *propertiesAndKeysDictionary = [[self class] propertiesAndKeysDictionary];
    NSString *propertyNameForKey = [propertiesAndKeysDictionary objectForKey:key];
    return propertyNameForKey;
}

- (void)setObject:(NSObject*)object forKey:(NSString*)key{
    NSString *propertyNameForKey = [[self class] propertyNameForKey:key];
    
    if (object && propertyNameForKey)
    {
        [self setValue:object forKey:propertyNameForKey];
    }
}

- (NSDictionary*)parseObjectDictionaryFromObject:(NSObject*)object forKey:(NSString*)key{
    NSMutableDictionary *objectDictionary = [[NSMutableDictionary alloc]init];
    if (key) {
        [self setObject:object forKey:key];
    }
    
    return objectDictionary;
}

- (void)fullfillDataFromFoursquareDictionary:(NSMutableDictionary*)foursquareDictionary{
    for (NSString *key in foursquareDictionary.allKeys) {
        NSObject *object = [foursquareDictionary objectForKey:key];
        [self parseObjectDictionaryFromObject:object forKey:key];
    }
}

- (NSString*)description{
    NSMutableString *descriptionMutableString = [[NSMutableString alloc]initWithString:[super description]];
    
    if ([self.codeId isStringAndNotEmpty]){
        [descriptionMutableString appendFormat:@" | codeId = %@", self.codeId];
    }
    
    return descriptionMutableString;
}

@end
