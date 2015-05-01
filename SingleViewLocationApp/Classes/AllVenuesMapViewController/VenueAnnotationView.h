//
//  VenueAnnotationView.h
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 5/1/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import "ProjectAnnotationView.h"

@class Venue;

@interface VenueAnnotationView : ProjectAnnotationView

@property (nonatomic, strong) Venue *venue;

@end
