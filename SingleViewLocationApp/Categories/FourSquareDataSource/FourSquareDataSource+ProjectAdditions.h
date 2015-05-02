//
//  FourSquareDataSource+ProjectAdditions.h
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 5/2/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import "FourSquareDataSource.h"
#import <UIKit/UIKit.h>

@interface FourSquareDataSource (ProjectAdditions)

//width of height can be 36, 100, 300, or 500.
+ (NSString*)urlStringForFourSquarePhotoPrefix:(NSString*)prefix
                                     andSuffix:(NSString*)suffix
                               withCustomWidth:(BOOL)withCustomWidth
                                   ofWidthSize:(CGFloat)width
                              withCustomHeight:(BOOL)withCustomHeight
                                  ofHeightSize:(CGFloat)height
                               orOriginalPhoto:(BOOL)originalPhoto;

@end
