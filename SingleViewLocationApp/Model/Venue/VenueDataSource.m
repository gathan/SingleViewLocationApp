//
//  VenueDataSource.m
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 4/29/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import "VenueDataSource.h"
#import "Venue.h"
#import <CoreLocation/CoreLocation.h>
#import "NSString+ProjectAdditions.h"

@interface VenueDataSource ()

@property (nonatomic, strong) NSString *kindOfDataSource;

@end

#define SearchVenues @"SearchVenues"
#define CompleteVenue @"CompleteVenue"

@implementation VenueDataSource

#pragma mark - Instance Methods

- (NSArray*)arrayOfObjectsFromRequest:(BZFoursquareRequest*)request{
    NSArray *whatToParse;
    if ([self.kindOfDataSource isEqualToString:SearchVenues]) {
        whatToParse = [request.response objectForKey:@"venues"];
    }else if ([self.kindOfDataSource isEqualToString:CompleteVenue]){
        whatToParse = @[[request.response objectForKey:@"venue"]];
    }
    return whatToParse;
}


- (void)fetchVenuesForLocationCoordinate:(CLLocationCoordinate2D)locationCoordinate{
    NSString *urlForVenuesSearch = [VenueDataSource urlForVenuesSearch];
    NSDictionary *parameters;
    NSString *llParameterStringForLocation = [VenueDataSource llParameterStringForLocationCoordinate:locationCoordinate];
    
    if (![llParameterStringForLocation isEmpty]) {
        parameters = @{@"ll" : llParameterStringForLocation};
    }
    self.kindOfDataSource = SearchVenues;
    [self requestWithPath:urlForVenuesSearch
            andParameters:[self fullfilledDictionaryWithParametersDictionary:parameters]];
}

- (void)fetchCompleteVenueWithVenueId:(NSString*)venueId
{
    NSString *urlForCompleteVenue = [VenueDataSource urlForCompleteVenueWithId:venueId];
    NSDictionary *parameters = @{};
    
    self.kindOfDataSource = CompleteVenue;
    [self requestWithPath:urlForCompleteVenue
            andParameters:[self fullfilledDictionaryWithParametersDictionary:parameters]];
}

- (Class)classToParse{
    return [Venue class];
}

#pragma mark - Class methods

+ (NSString*)urlForVenues{
    NSString *urlForVenues = [VenueDataSource apiUrl];
    urlForVenues = [urlForVenues stringByAppendingPathComponent:@"/venues"];
    return urlForVenues;
}

+ (NSString*)urlForVenuesSearch{
    NSString *urlForVenuesSearch = [VenueDataSource urlForVenues];
    urlForVenuesSearch = [urlForVenuesSearch stringByAppendingPathComponent:@"/search"];
    return urlForVenuesSearch;
}

+ (NSString*)urlForCompleteVenueWithId:(NSString*)venueId{
    NSString *urlForVenuesSearch = [VenueDataSource urlForVenues];
    
    NSString *pathComponent = [NSString stringWithFormat:@"/%@", venueId];
    urlForVenuesSearch = [urlForVenuesSearch stringByAppendingPathComponent:pathComponent];
    return urlForVenuesSearch;
}

+ (NSString*)llParameterStringForLocationCoordinate:(CLLocationCoordinate2D)locationCoordinate{
    NSString *latitudeString = [FourSquareDataSource stringFromNumber:@(locationCoordinate.latitude)];
    NSString *longtitudeString = [FourSquareDataSource stringFromNumber:@(locationCoordinate.longitude)];
    
    NSString *llParameterStringForLocation = [NSString stringWithFormat:@"%@,%@", latitudeString, longtitudeString];
    
    return llParameterStringForLocation;
}

@end
