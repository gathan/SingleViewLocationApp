//
//  AllVenuesMapViewController.m
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 4/28/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import "AllVenuesMapViewController.h"
#import "ProjectLocationManager.h"
#import "GoogleMapsProjectGeocoder.h"
#import "VenueDataSource.h"
#import "Venue.h"

@interface AllVenuesMapViewController () <CLLocationManagerDelegate, GoogleMapsProjectGeocoderDelegate, FourSquareDelegate>

@property (nonatomic, strong) ProjectLocationManager *locationManager;
@property (nonatomic, strong) GoogleMapsProjectGeocoder *geocoder;
@property (nonatomic, strong) GMSAddress *latestGMSAddress;
@property (nonatomic, strong) VenueDataSource *venueDataSource;

@property (nonatomic, strong) NSMutableArray *venuesMutableArray;

@end

@implementation AllVenuesMapViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.locationManager addDelegate:self];
    [self.locationManager userExplicitlyRequestedLocationAccess];//This is the best time to ask for user's will to give location data to us. It could be when user tapped a button if there was one to activate location (Apple documentation says:   locationServicesEnabled...You may want to check this property and use location services only when explicitly requested by the user.)
    self.venueDataSource.delegate = self;
}

- (void)updateUI{
    //todo: update ui for new address for example
}

#pragma mark - Actions

- (void)reverseGeocodeLocation:(CLLocation*)location{

    [self.geocoder startReverseGeocodingGMSAddressForCLLocationCoordinate:location.coordinate];
}

#pragma mark - GoogleMapsProjectGeocoderDelegate

- (void)googleMapsProjectGeocoder:(GoogleMapsProjectGeocoder *)googleMapsProjectGeocoder successfullyReverseGeocodedGMSAddress:(GMSAddress *)gmsAddress{
    self.latestGMSAddress = gmsAddress;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self updateUI];
    });
}

- (void)googleMapsProjectGeocoder:(GoogleMapsProjectGeocoder *)googleMapsProjectGeocoder didFailReverseGeocodingGMSAddressWithError:(NSError *)error{
    if (self.locationManager.location) {
        [self reverseGeocodeLocation:self.locationManager.location];
    }else{
        [self.locationManager addDelegate:self];
        [self.locationManager startUpdatingLocation];
    }
}

#pragma mark - FourSquareDelegate

- (void)fourSquareDataSource:(FourSquareDataSource*)fourSquareDataSource successfullyFetchedFourSquareObjects:(NSArray*)foursquareObjectsArray{
    if (fourSquareDataSource == self.venueDataSource)
    {
        NSMutableArray *copyOfVenuesMutableArray = [self.venuesMutableArray copy];
        for (Venue *venue in foursquareObjectsArray) {
            if (![copyOfVenuesMutableArray containsObject:venue]) {
                [copyOfVenuesMutableArray addObject:venue];
            }
        }
        
        self.venuesMutableArray = copyOfVenuesMutableArray;
        //reload
    }
}

- (void)fourSquareDataSource:(FourSquareDataSource*)fourSquareDataSource
             failedWithError:(NSError*)error{

}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *veryFirstLocation = [locations firstObject];
    if (veryFirstLocation) {
        [self.locationManager removeDelegate:self];
        [self reverseGeocodeLocation:veryFirstLocation];
        [self.venueDataSource fetchVenuesForLocationCoordinate:veryFirstLocation.coordinate];
    }
}

#pragma mark - Properties

- (GoogleMapsProjectGeocoder*)geocoder{
    if (!_geocoder) {
        _geocoder = [[GoogleMapsProjectGeocoder alloc]init];
        _geocoder.delegate = self;
    }
    return _geocoder;
}

- (ProjectLocationManager*)locationManager{
    if (!_locationManager) {
        _locationManager = [ProjectLocationManager sharedManager];
    }
    return _locationManager;
}

- (VenueDataSource*)venueDataSource{
    if (!_venueDataSource) {
        _venueDataSource = [[VenueDataSource alloc]init];
    }
    return _venueDataSource;
}

#pragma mark - Class Methods

+ (instancetype)defaultAllVenuesMapViewController{
    AllVenuesMapViewController *allVenuesMapViewController = [[AllVenuesMapViewController alloc]initWithNibName:@"AllVenuesMapViewController" bundle:nil];
    return allVenuesMapViewController;
}

@end
