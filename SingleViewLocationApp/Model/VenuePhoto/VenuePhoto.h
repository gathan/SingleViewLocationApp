//
//  VenuePhoto.h
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 5/3/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import "FourSquareObject.h"

@interface VenuePhoto : FourSquareObject

@property (nonatomic, strong) NSString *prefix;
@property (nonatomic, strong) NSString *suffix;
@property (nonatomic, strong) NSNumber *width;
@property (nonatomic, strong) NSNumber *height;

@end
