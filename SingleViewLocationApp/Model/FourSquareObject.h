//
//  FourSquareObject.h
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 4/29/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FourSquareObject : NSObject


@property (nonatomic, strong) NSString *codeId;

- (void)fullfillDataFromFoursquareDictionary:(NSMutableDictionary*)foursquareDictionary;
- (void)setObject:(NSObject*)object forKey:(NSString*)key;
- (NSDictionary*)parseObjectDictionaryFromObject:(NSObject*)object forKey:(NSString*)key;

+ (NSDictionary*)propertiesAndKeysDictionary;

@end
