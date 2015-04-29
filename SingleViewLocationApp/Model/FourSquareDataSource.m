//
//  FourSquareDataSource.m
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 4/29/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import "FourSquareDataSource.h"
#import "BZFoursquare.h"
#import "NSString+ProjectAdditions.h"

@interface FourSquareDataSource ()

+ (NSString*)apiKey;
+ (NSString*)callbackURL;

@property (nonatomic, strong) NSMutableArray *requestsMutableArray;
//@property (nonatomic) BOOL mustAuthorize;

@end

@implementation FourSquareDataSource

- (instancetype)init{
    self = [super init];
    if (self) {
//        self.mustAuthorize = YES;
//        [self.foursquare startAuthorization];
    }
    return self;
}

#pragma mark - Actions

- (void)requestWithPath:(NSString*)path
          andParameters:(NSDictionary*)parameters
{
    BZFoursquareRequest *foursquareRequest = [self.foursquare requestWithPath:path
                                                                   HTTPMethod:[[self class]defaultHTTPMethod]
                                                                   parameters:parameters
                                                                     delegate:self];
    [foursquareRequest start];
    [self.requestsMutableArray addObject:foursquareRequest];
}

#pragma mark - Properties

- (BZFoursquare*)foursquare{
    if (!_foursquare) {
        _foursquare = [[BZFoursquare alloc]initWithClientID:[[self class] clientID] callbackURL:[[self class]callbackURL]];
        _foursquare.clientSecret = [[self class] clientSecret];
    }
    return _foursquare;
}

#pragma mark - BZFoursquareSessionDelegate

- (void)foursquareDidAuthorize:(BZFoursquare *)foursquare{
//    self.mustAuthorize = NO;
}

- (void)foursquareDidNotAuthorize:(BZFoursquare *)foursquare error:(NSDictionary *)errorInfo{
//    self.mustAuthorize = YES;
}

#pragma mark - BZFoursquareRequestDelegate

- (void)requestDidStartLoading:(BZFoursquareRequest *)request{
    [@"Foursquare Request did start loading" log];
}

- (NSArray*)foursquareObjectsFromResponseDictionary:(NSDictionary*)responseDictionary{
    
    return nil;
}

- (void)requestDidFinishLoading:(BZFoursquareRequest *)request{
    [@"Foursquare Request did finish loading" log];
    NSArray *foursquareObjects = [self foursquareObjectsFromResponseDictionary:[request.response objectForKey:@"venues"]];
    if (self.delegate && [self.delegate respondsToSelector:@selector(fourSquareDataSource:successfullyFetchedFourSquareObjects:)])
    {
        [self.delegate fourSquareDataSource:self successfullyFetchedFourSquareObjects:foursquareObjects];
    }
}

- (void)request:(BZFoursquareRequest *)request didFailWithError:(NSError *)error{
    NSString *logString = [NSString stringWithFormat:@"Foursquare Request did fail with error: %@", error.description];
    [logString log];
    if (self.delegate && [self.delegate respondsToSelector:@selector(fourSquareDataSource:failedWithError:)])
    {
        [self.delegate fourSquareDataSource:self
                            failedWithError:error];
    }
    [self.requestsMutableArray removeObject:request];
}

#pragma mark - Properties

- (NSMutableArray*)requestsMutableArray{
    if (!_requestsMutableArray) {
        _requestsMutableArray = [[NSMutableArray alloc]init];
    }
    return _requestsMutableArray;
}

#pragma mark - Class Methods

+ (NSString*)apiKey{
    return nil;//please subclass foursquare datasource and ovveride this function
}

+ (NSString*)callbackURL{
    return nil;//please subclass foursquare datasource and ovveride this function
}

+ (NSString*)clientID{
    return nil;//please subclass foursquare datasource and ovveride this function
}

+ (NSString*)clientSecret{
    return nil;//please subclass foursquare datasource and ovveride this function
}

+ (NSString*)versionId{
    return nil;
}

+ (NSString*)apiMainUrl{
    return @"";
}

+ (NSString*)apiUrl{
    return [FourSquareDataSource apiMainUrl];
}

+ (NSString*)defaultHTTPMethod{
    return @"GET";
}

+ (NSNumberFormatter*)foursquareDataSourceNumberFormatter{
    //formatters are very costy in iOS
    static NSNumberFormatter *numberFormatter;
    if (!numberFormatter) {
        numberFormatter = [[NSNumberFormatter alloc]init];
        [numberFormatter setDecimalSeparator:@"."];
    }
    return numberFormatter;
}

+ (NSString*)stringFromNumber:(NSNumber*)number{
    NSString *stringFromNumber = [[FourSquareDataSource foursquareDataSourceNumberFormatter] stringFromNumber:number];
    return stringFromNumber;
}

- (NSDictionary*)fullfilledDictionaryWithParametersDictionary:(NSDictionary*)parametersDictionary{
    NSMutableDictionary *parametersMutableDictionary = [[NSMutableDictionary alloc]init];
    [parametersMutableDictionary addEntriesFromDictionary:parametersDictionary];
    [parametersMutableDictionary addEntriesFromDictionary:[[self class] authParametersDictionary]];
    return parametersMutableDictionary;
}

+ (NSDictionary*)authParametersDictionary{
    NSString *clientID = [[self class] clientID];
    NSString *clientSecret = [[self class] clientSecret];
    NSString *versionID = [[self class] versionID];
    NSDictionary *authParametersDictionary = @{@"client_id": clientID, @"client_secret" : clientSecret, @"v" : versionID};
    return authParametersDictionary;
}

@end
