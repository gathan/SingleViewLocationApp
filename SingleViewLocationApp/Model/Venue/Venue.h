//
//  Venue.h
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 4/29/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import "FourSquareObject.h"

@interface Venue : FourSquareObject

@property (nonatomic, strong) NSNumber *rating;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *verified;
@property (nonatomic, strong) NSString *twitter;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *formattedPhone;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *cc;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSNumber *distance;
@property (nonatomic, strong) NSString *formattedAddress;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longtitude;
@property (nonatomic, strong) NSString *postalCode;

@end
