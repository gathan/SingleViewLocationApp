//
//  VenuePhotosDataSource.m
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 5/2/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import "VenuePhotosDataSource.h"
#import "VenuePhoto.h"
#import "Venue.h"
#import "NSString+ProjectAdditions.h"

@implementation VenuePhotosDataSource

#pragma mark - Instance Methods

- (NSArray*)arrayOfObjectsFromRequest:(BZFoursquareRequest*)request{
    NSArray *whatToParse;
    whatToParse = [[request.response objectForKey:@"photos"] objectForKey:@"items"];
    
    return whatToParse;
}

- (void)fetchVenuePhotosForVenue:(Venue*)venue withALimit:(BOOL)withLimit of:(NSInteger)limit
{
    NSString *urlForVenuesSearch = [VenuePhotosDataSource urlForVenuePhotoSearchForVenue:venue];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]initWithDictionary:
  @{@"group" : @"venue"}];
    
    if (withLimit) {
        [parameters setObject:@(limit).stringValue forKey:@"limit"];
    }else{
        [parameters setObject:@(10).stringValue forKey:@"limit"];
    }
    
    [self requestWithPath:urlForVenuesSearch
            andParameters:[self fullfilledDictionaryWithParametersDictionary:parameters]];
}

- (Class)classToParse{
    return [VenuePhoto class];
}

#pragma mark - Class methods

+ (NSString*)urlForVenues{
    NSString *urlForVenues = [VenuePhotosDataSource apiUrl];
    urlForVenues = [urlForVenues stringByAppendingPathComponent:@"/venues"];
    return urlForVenues;
}

+ (NSString*)urlForVenuePhotoSearchForVenue:(Venue*)venue{
    NSString *urlForVenues = [VenuePhotosDataSource urlForVenues];
    NSString *pathComponent = [NSString stringWithFormat:@"/%@/photos", venue.codeId];
//    NSString *pathComponent = [NSString stringWithFormat:@"/%@/photos", @"43a52546f964a520532c1fe3"];//JFL venue id, for testing
    NSString *urlForVenuePhotoSearch = [urlForVenues stringByAppendingPathComponent:pathComponent];
    return urlForVenuePhotoSearch;
}

+ (NSString*)llParameterStringForLocationCoordinate:(CLLocationCoordinate2D)locationCoordinate{
    NSString *latitudeString = [FourSquareDataSource stringFromNumber:@(locationCoordinate.latitude)];
    NSString *longtitudeString = [FourSquareDataSource stringFromNumber:@(locationCoordinate.longitude)];
    
    NSString *llParameterStringForLocation = [NSString stringWithFormat:@"%@,%@", latitudeString, longtitudeString];
    
    return llParameterStringForLocation;
}


@end
