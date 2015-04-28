//
//  GoogleMapsProjectGeocoder.h
//  Taxibeat_GA_Test
//
//  Created by Georgios Athanasopoulos on 4/28/15.
//  Copyright (c) 2015 Taxibeat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>

@class GMSAddress;
@class GoogleMapsProjectGeocoder;

@protocol GoogleMapsProjectGeocoderDelegate <NSObject>

@optional
- (void)googleMapsProjectGeocoder:(GoogleMapsProjectGeocoder*)googleMapsProjectGeocoder
successfullyReverseGeocodedGMSAddress:(GMSAddress*)gmsAddress;

- (void)googleMapsProjectGeocoder:(GoogleMapsProjectGeocoder*)googleMapsProjectGeocoder
didFailReverseGeocodingGMSAddressWithError:(NSError*)error;

@end

@interface GoogleMapsProjectGeocoder : GMSGeocoder

@property (nonatomic, weak) id <GoogleMapsProjectGeocoderDelegate> delegate;
- (void)startReverseGeocodingGMSAddressForCLLocationCoordinate:(CLLocationCoordinate2D)locationCoordinate;

@end
