//
//  UIApplication+ProjectAdditions.m
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 4/28/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import "UIApplication+ProjectAdditions.h"
#import "NSString+ProjectAdditions.h"

@implementation UIApplication (ProjectAdditions)

+ (BOOL)iOSLessThan8{
    BOOL iOSLessThan8 = [[UIDevice currentDevice].systemVersion floatValue] < 8.0f;
    return iOSLessThan8;
}

+ (NSString*)applicationDocumentsDirectoryString{
    static NSString *documentsDirectoryString;
    
    if (!documentsDirectoryString) {
        documentsDirectoryString = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    }
    
    return documentsDirectoryString;
}

+ (NSURL*)applcationDocumentsDirectoryURL{
    static NSURL *documentsDirectoryURL;
    
    if (!documentsDirectoryURL) {
        documentsDirectoryURL = [NSURL URLWithString:[UIApplication applicationDocumentsDirectoryString]];
    }
    
    return documentsDirectoryURL;
}

+ (void)logApplicationDocumentsDirectoryString{
    NSString *documentsDirectoryString = [UIApplication applicationDocumentsDirectoryString];
    NSString *documentsDirectoryLogString = [NSString stringWithFormat:@"Documents Directory:\n%@", documentsDirectoryString];
    [documentsDirectoryLogString log];
}

@end
