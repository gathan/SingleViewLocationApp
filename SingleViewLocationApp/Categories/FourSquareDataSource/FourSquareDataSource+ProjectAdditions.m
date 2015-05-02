//
//  FourSquareDataSource+ProjectAdditions.m
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 5/2/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import "FourSquareDataSource+ProjectAdditions.h"
#import <UIKit/UIKit.h>

@implementation FourSquareDataSource (ProjectAdditions)

//width of height can be 36, 100, 300, or 500.
+ (NSString*)urlStringForFourSquarePhotoPrefix:(NSString*)prefix
                                     andSuffix:(NSString*)suffix
                               withCustomWidth:(BOOL)withCustomWidth
                                   ofWidthSize:(CGFloat)width
                              withCustomHeight:(BOOL)withCustomHeight
                                  ofHeightSize:(CGFloat)height
                               orOriginalPhoto:(BOOL)originalPhoto
{
    NSMutableString *finalUrl = [[NSMutableString alloc]initWithString:prefix];
    BOOL thereWasAProblemUsingTheFunction = NO;
    if (originalPhoto) {
        [finalUrl appendString:@"/"];
        [finalUrl appendString:@"original"];
    }
    else
    {
        if (withCustomWidth &&
            withCustomHeight)
        {
            [finalUrl appendString:@"/"];
            [finalUrl appendFormat:@"%f", width];
            [finalUrl appendString:@"x"];
            [finalUrl appendFormat:@"%f", height];
            
            thereWasAProblemUsingTheFunction = !([FourSquareDataSource availablePhotoWidthOfHeight:width] &&
            [FourSquareDataSource availablePhotoWidthOfHeight:height]);
        }
        else
        {
            if (withCustomWidth)
            {
                [finalUrl appendString:@"/"];
                [finalUrl appendString:@"width"];
                [finalUrl appendFormat:@"%f", width];
                
                thereWasAProblemUsingTheFunction = ![FourSquareDataSource availablePhotoWidthOfHeight:width];
            }
            else if (withCustomHeight)
            {
                [finalUrl appendString:@"/"];
                [finalUrl appendString:@"height"];
                [finalUrl appendFormat:@"%f", height];

                thereWasAProblemUsingTheFunction = ![FourSquareDataSource availablePhotoWidthOfHeight:height];
            }
        }
    }
    
    if (thereWasAProblemUsingTheFunction)
    {
        finalUrl = [NSMutableString stringWithString:[FourSquareDataSource urlStringForFourSquarePhotoPrefix:prefix andSuffix:suffix withCustomWidth:NO ofWidthSize:0 withCustomHeight:NO ofHeightSize:0 orOriginalPhoto:YES]];
    }else{
        [finalUrl appendString:@"/"];
        [finalUrl appendString:suffix];
    }
    
    return finalUrl;
}

+ (BOOL)availablePhotoWidthOfHeight:(CGFloat)widthOrHeight{
    BOOL available = YES;
    
    if (widthOrHeight != 36 &&
        widthOrHeight != 100 &&
        widthOrHeight != 300 &&
        widthOrHeight != 500)
    {
        available = NO;
    }
    
    return available;
}

/*
 Ending of the URL for this photo.
 
 To assemble a resolvable photo URL, take prefix + size + suffix, e.g. https://irs0.4sqi.net/img/general/300x500/2341723_vt1Kr-SfmRmdge-M7b4KNgX2_PHElyVbYL65pMnxEQw.jpg.
 
 size can be one of the following, where XX or YY is one of 36, 100, 300, or 500.
 XXxYY
 original: the original photo's size
 capXX: cap the photo with a width or height of XX (whichever is larger). Scales the other, smaller dimension proportionally
 widthXX: forces the width to be XX and scales the height proportionally
 heightYY: forces the height to be YY and scales the width proportionally
 */

@end
