//
//  VenuePhotosDataSource.h
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 5/2/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import "ProjectFourSquareDataSource.h"

@class Venue;

@interface VenuePhotosDataSource : ProjectFourSquareDataSource

- (void)fetchVenuePhotosForVenue:(Venue*)venue withALimit:(BOOL)withLimit of:(NSInteger)limit;

@end
