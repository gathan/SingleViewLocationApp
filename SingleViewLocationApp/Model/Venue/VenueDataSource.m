//
//  VenueDataSource.m
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 4/29/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import "VenueDataSource.h"
#import <CoreLocation/CoreLocation.h>
#import "NSString+ProjectAdditions.h"

@implementation VenueDataSource

#pragma mark - Instance Methods

- (void)fetchVenuesForLocationCoordinate:(CLLocationCoordinate2D)locationCoordinate{
    NSString *urlForVenuesSearch = [VenueDataSource urlForVenuesSearch];
    NSDictionary *parameters;
    NSString *llParameterStringForLocation = [VenueDataSource llParameterStringForLocationCoordinate:locationCoordinate];
    
    if (![llParameterStringForLocation isEmpty]) {
        parameters = @{@"ll" : llParameterStringForLocation};
    }
    
    [self requestWithPath:urlForVenuesSearch
            andParameters:[self fullfilledDictionaryWithParametersDictionary:parameters]];
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

+ (NSString*)llParameterStringForLocationCoordinate:(CLLocationCoordinate2D)locationCoordinate{
    NSString *latitudeString = [FourSquareDataSource stringFromNumber:@(locationCoordinate.latitude)];
    NSString *longtitudeString = [FourSquareDataSource stringFromNumber:@(locationCoordinate.longitude)];
    
    NSString *llParameterStringForLocation = [NSString stringWithFormat:@"%@,%@", latitudeString, longtitudeString];
    
    return llParameterStringForLocation;
}

@end
