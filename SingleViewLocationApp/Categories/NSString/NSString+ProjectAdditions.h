//
//  NSString+ProjectAdditions.h
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 4/28/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (ProjectAdditions)

+ (NSString*)allLoggedStringsStringFromNewerToOlder;
+ (NSMutableArray*)loggedStringsMutableArray;
+ (NSMutableArray*)loggedStringsMutableArrayFromNewerToOlder;
- (void)log;
- (BOOL)isEmptyOrNull;
- (BOOL)isEmpty;
- (NSString*)stringThatWillBeAfterChangedCharactersInRange:(NSRange)range replacementString:(NSString *)replacementString;
- (UIColor*)colorFromRGBABarSeparatedString;

@end
