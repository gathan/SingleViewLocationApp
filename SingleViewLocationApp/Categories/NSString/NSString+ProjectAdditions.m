//
//  NSString+ProjectAdditions.m
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 4/28/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import "NSString+ProjectAdditions.h"
#import "NSObject+ProjectAdditions.h"

#define LOG_ENABLED 0

@implementation NSString (ProjectAdditions)

+ (NSString*)allLoggedStringsStringFromNewerToOlder{
    NSMutableArray *loggedStringsMutableArrayFromNewerToOlder = [NSString loggedStringsMutableArrayFromNewerToOlder];
    NSString *allLoggedStringsStringFromNewerToOlder = [[loggedStringsMutableArrayFromNewerToOlder mutableCopy] componentsJoinedByString:@"\n\n"];
    return allLoggedStringsStringFromNewerToOlder;
}


+ (NSString*)allLoggedStringsString{
    NSString *allLoggedStringsString = [[NSString loggedStringsMutableArray]componentsJoinedByString:@"\n"];
    
    return allLoggedStringsString;
}

+ (NSMutableArray*)loggedStringsMutableArray{
    static NSMutableArray *loggedStringsMutableArray;
    if (!loggedStringsMutableArray) {
        loggedStringsMutableArray = [[NSMutableArray alloc]init];
    }
    return loggedStringsMutableArray;
}

+ (NSMutableArray*)loggedStringsMutableArrayFromNewerToOlder{
    static NSMutableArray *loggedStringsMutableArrayFromNewerToOlder;
    if (!loggedStringsMutableArrayFromNewerToOlder) {
        loggedStringsMutableArrayFromNewerToOlder = [[NSMutableArray alloc]init];
    }
    return loggedStringsMutableArrayFromNewerToOlder;
}

- (void)log{
    //    [[NSString loggedStringsMutableArray] addObject:@"\n"];
    [[NSString loggedStringsMutableArray] addObject:self];
    
    //    [[NSString loggedStringsMutableArrayFromNewerToOlder] insertObject:@"\n" atIndex:0];
    [[NSString loggedStringsMutableArrayFromNewerToOlder] insertObject:self atIndex:0];
    
    if (LOG_ENABLED) {
        NSLog(self, 1);
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"logged" object:nil];
}

- (BOOL)isEmptyOrNull{
    BOOL isNull = [self isNull];
    BOOL isEmpty = [self isEmpty];
    BOOL isEmptyOrNull = isEmpty || isNull;
    
    return isEmptyOrNull;
}

- (BOOL)isEmpty{
    
    BOOL isEmpty = NO;
    
    NSString *stringByTrimmingSpaceCharacters = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (stringByTrimmingSpaceCharacters.length == 0) {
        isEmpty = YES;
    }
    
    return isEmpty;
}

- (NSString*)stringThatWillBeAfterChangedCharactersInRange:(NSRange)range replacementString:(NSString *)replacementString
{
    NSString *stringThatWillBe;
    
    if (replacementString.length == 0) {//will delete...
        stringThatWillBe = [[self substringToIndex:range.location] stringByAppendingString:[self substringFromIndex:range.location+range.length]];
    }
    else{
        stringThatWillBe = [[[self substringToIndex:range.location] stringByAppendingString:replacementString] stringByAppendingString:[self substringFromIndex:range.location]];
    }
    
    return stringThatWillBe;
}

- (UIColor*)colorFromRGBABarSeparatedString
{
    NSString *colorString = [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    NSArray *colorComponents = [colorString componentsSeparatedByString:@"|"];
    float r,g,b,a;
    if (colorComponents.count > 2) {
        r = [[colorComponents objectAtIndex:0] floatValue];
        g = [[colorComponents objectAtIndex:1] floatValue];
        b = [[colorComponents objectAtIndex:2] floatValue];
    }else{
        r = 255;
        g = 255;
        b = 255;
    }
    if (colorComponents.count > 3) {
        a = [[colorComponents objectAtIndex:3] floatValue];
    }else{
        a = 100;
    }
    
    UIColor *colorFromRGBASeparatedString = [UIColor colorWithRed:((float) r / 255.0f)
                                                            green:((float) g / 255.0f)
                                                             blue:((float) b / 255.0f)
                                                            alpha:((float) a / 100.0f)];
    return colorFromRGBASeparatedString;
}

@end
