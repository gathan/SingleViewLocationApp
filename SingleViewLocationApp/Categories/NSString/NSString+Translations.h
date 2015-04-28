//
//  NSString+Translations.h
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 4/28/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import <Foundation/Foundation.h>

//here is the place where the translations proxy will get translations from the localizable strings and/or from a custom Translations DataSource (for example, through web services, for data translation, except for in app labels)

@interface NSString (Translations)

- (NSString*)translate;

@end
