//
//  UIApplication+ProjectAdditions.h
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 4/28/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (ProjectAdditions)

+ (BOOL)iOSLessThan8;
+ (NSString*)applicationDocumentsDirectoryString;
+ (NSURL*)applcationDocumentsDirectoryURL;
+ (void)logApplicationDocumentsDirectoryString;

@end
