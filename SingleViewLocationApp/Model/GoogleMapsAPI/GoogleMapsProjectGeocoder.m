//
//  GoogleMapsProjectGeocoder.m
//  Taxibeat_GA_Test
//
//  Created by Georgios Athanasopoulos on 4/28/15.
//  Copyright (c) 2015 Taxibeat. All rights reserved.
//

#import "GoogleMapsProjectGeocoder.h"

@implementation GoogleMapsProjectGeocoder

- (void)startReverseGeocodingGMSAddressForCLLocationCoordinate:(CLLocationCoordinate2D)locationCoordinate
{
    GMSReverseGeocodeCallback handler = ^(GMSReverseGeocodeResponse *response, NSError *error) {
        GMSAddress *address = response.firstResult;
        if (address) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(googleMapsProjectGeocoder:successfullyReverseGeocodedGMSAddress:)]) {
                [self.delegate googleMapsProjectGeocoder:self
            successfullyReverseGeocodedGMSAddress:address];
            }
        }
        else
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(googleMapsProjectGeocoder:didFailReverseGeocodingGMSAddressWithError:)]) {
                [self.delegate googleMapsProjectGeocoder:self didFailReverseGeocodingGMSAddressWithError:error];
            }
        }
    };
    
    [self reverseGeocodeCoordinate:locationCoordinate
                 completionHandler:handler];
}

@end
