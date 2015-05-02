//
//  NSObject+ProjectAdditions.m
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 4/29/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import "NSObject+ProjectAdditions.h"

@implementation NSObject (ProjectAdditions)

- (BOOL)isNull{
    BOOL isNull = [self isKindOfClass:[NSNull class]] || self.class == [NSNull class];
    return isNull;
}

- (BOOL)isStringAndNotEmpty{
    BOOL isStringAndNotEmpty = YES;
    if (![self isKindOfClass:[NSString class]] ||
        [self isNull]) {
        isStringAndNotEmpty = NO;
    }else{
        NSString *selfString = (NSString*)self;
        selfString = [selfString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        BOOL isEmpty = selfString.length == 0;
        if (isEmpty) {
            isStringAndNotEmpty = NO;
        }
    }
    return isStringAndNotEmpty;
}

- (BOOL)isNumber{
    BOOL isNumber = YES;
    if (![self isKindOfClass:[NSNumber class]]) {
        isNumber = NO;
    }
    else
    {
    }
    
    return isNumber;
}

@end
