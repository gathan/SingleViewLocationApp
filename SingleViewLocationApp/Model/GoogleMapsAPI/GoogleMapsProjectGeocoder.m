//
//  GoogleMapsProjectGeocoder.m
//  Taxibeat_GA_Test
//
//  Created by Georgios Athanasopoulos on 4/28/15.
//  Copyright (c) 2015 Taxibeat. All rights reserved.
//

#import "GoogleMapsProjectGeocoder.h"
#import "NSString+ProjectAdditions.h"

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
            NSString *logString = [NSString stringWithFormat:@"GMSGeocoder reverse Geocoded Address: %@", address.thoroughfare];
            [logString log];
        }
        else
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(googleMapsProjectGeocoder:didFailReverseGeocodingGMSAddressWithError:)]) {
                [self.delegate googleMapsProjectGeocoder:self didFailReverseGeocodingGMSAddressWithError:error];
            }
            NSString *logString = [NSString stringWithFormat:@"GMSGeocoder failed to reverse geocode with error: %@", error.description];
            [logString log];
        }
    };
    
    dispatch_async(dispatch_get_main_queue(), ^{//'All calls to the Google Maps SDK for iOS must be made from the UI thread'
        [self reverseGeocodeCoordinate:locationCoordinate
                 completionHandler:handler];
    });
}

@end
