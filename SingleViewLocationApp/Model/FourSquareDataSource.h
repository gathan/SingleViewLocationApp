//
//  FourSquareDataSource.h
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 4/29/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BZFoursquare.h"
#import "BZFoursquareRequest.h"

@class FourSquareDataSource;

@protocol FourSquareDelegate <NSObject>

- (void)fourSquareDataSource:(FourSquareDataSource*)fourSquareDataSource successfullyFetchedFourSquareObjects:(NSArray*)foursquareObjectsArray;

- (void)fourSquareDataSource:(FourSquareDataSource*)fourSquareDataSource
             failedWithError:(NSError*)error;

@end

@interface FourSquareDataSource : NSObject <BZFoursquareRequestDelegate, BZFoursquareSessionDelegate>

@property (nonatomic, weak) id <FourSquareDelegate> delegate;

@property (nonatomic, strong) BZFoursquare *foursquare;//for subclasses

//@property (nonatomic, readonly) BOOL mustAuthorize;

- (void)requestWithPath:(NSString*)path andParameters:(NSDictionary*)parameters;
- (NSDictionary*)fullfilledDictionaryWithParametersDictionary:(NSDictionary*)parametersDictionary;
- (NSArray*)foursquareObjectsFromResponseObjectsArray:(NSArray*)responseObjectsArray;
- (Class)classToParse;

+ (NSString*)apiKey;//please subclass foursquare datasource and ovveride this function
+ (NSString*)callbackURL;//please subclass foursquare datasource and ovveride this function
+ (NSString*)clientID;//please subclass foursquare datasource and ovveride this function
+ (NSString*)clientSecret;//please subclass foursquare datasource and ovveride this function
+ (NSString*)versionID;//please subclass foursquare datasource and ovveride this function

+ (NSString*)apiMainUrl;
+ (NSString*)apiUrl;

+ (NSNumberFormatter*)foursquareDataSourceNumberFormatter;
+ (NSString*)stringFromNumber:(NSNumber*)number;

@end
