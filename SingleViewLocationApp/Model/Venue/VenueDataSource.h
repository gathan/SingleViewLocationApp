//
//  VenueDataSource.h
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 4/29/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import "ProjectFourSquareDataSource.h"
#import <CoreLocation/CoreLocation.h>

@interface VenueDataSource : ProjectFourSquareDataSource

- (void)fetchVenuesForLocationCoordinate:(CLLocationCoordinate2D)locationCoordinate;
- (void)fetchCompleteVenueWithVenueId:(NSString*)venueId;

@end
