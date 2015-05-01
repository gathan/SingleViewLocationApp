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


//note: using pragma marks so much like this helps when someone other will use this class. On top file inspector for the current file, press the button on the right of the current file. All sections of pragma marks will be sorted. also pragma marking a delegate, will take you to the actual delegate with CMD+click
#pragma mark - IBOutlets

//TODO: give the right colors to the views.
#pragma mark -- Map
@property (weak, nonatomic) IBOutlet GMSMapView *gmsMapView;

#pragma mark -- Current location View
@property (nonatomic, getter = isCurrentLocationViewHidden) BOOL currentLocationViewHidden;
@property (weak, nonatomic) IBOutlet UIView *currentLocationView;

#pragma mark -- Current location Title View
@property (weak, nonatomic) IBOutlet UIView *currentLocationTitleView;
@property (weak, nonatomic) IBOutlet UILabel *currentLocationTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *currentLocationImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *currentLocationViewVerticalSpaceBottomToContainerLayoutConstraint;

#pragma mark -- Current Address View
@property (weak, nonatomic) IBOutlet UIView *addressView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

+ (BOOL)shouldStopAfterFirstReverseGeocoding;

@end

@implementation AllVenuesMapViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    BOOL hasFoundAddress = self.latestGMSAddress != nil;
    [self makeCurrentLocationViewHidden:!hasFoundAddress animated:NO];
    
    [self.locationManager addDelegate:self];
    [self.locationManager userExplicitlyRequestedLocationAccess];//This is the best time to ask for user's will to give location data to us. It could be when user tapped a button if there was one to activate location (Apple documentation says:   locationServicesEnabled...You may want to check this property and use location services only when explicitly requested by the user.)
    self.venueDataSource.delegate = self;
}

- (void)updateUI{
    self.addressLabel.text = self.latestGMSAddress.thoroughfare;
}

#pragma mark - Actions

- (void)reverseGeocodeLocation:(CLLocation*)location{

    [self.geocoder startReverseGeocodingGMSAddressForCLLocationCoordinate:location.coordinate];
}

#pragma mark - GoogleMapsProjectGeocoderDelegate

- (void)googleMapsProjectGeocoder:(GoogleMapsProjectGeocoder *)googleMapsProjectGeocoder successfullyReverseGeocodedGMSAddress:(GMSAddress *)gmsAddress{
    self.latestGMSAddress = gmsAddress;
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
        if ([AllVenuesMapViewController shouldStopAfterFirstReverseGeocoding]) {
            [self.locationManager removeDelegate:self];
        }
        [self reverseGeocodeLocation:veryFirstLocation];
        [self.venueDataSource fetchVenuesForLocationCoordinate:veryFirstLocation.coordinate];
    }
}

#pragma mark - Properties

- (void)setLatestGMSAddress:(GMSAddress *)latestGMSAddress{
    _latestGMSAddress = latestGMSAddress;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self updateUI];
    });
    
    if (_latestGMSAddress) {
        [self makeCurrentLocationViewHidden:NO animated:YES];
    }else{
        [self makeCurrentLocationViewHidden:YES animated:YES];
    }
}

- (void)makeCurrentLocationViewHidden:(BOOL)hidden animated:(BOOL)animated{
    self.currentLocationViewHidden = hidden;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        CGFloat resultAlpha;
        if (_currentLocationViewHidden) {
            self.currentLocationViewVerticalSpaceBottomToContainerLayoutConstraint.constant = -self.currentLocationView.bounds.size.height;
            resultAlpha = 0.0f;
        }else{
            self.currentLocationViewVerticalSpaceBottomToContainerLayoutConstraint.constant = 0;
            resultAlpha = 1.0f;
        }
        if (animated){
            [UIView animateWithDuration:[self animationTime] animations:^{
                self.currentLocationView.alpha = resultAlpha;
                [self.view layoutIfNeeded];
            }];
        }else{
            self.currentLocationView.alpha = resultAlpha;
            [self.view layoutIfNeeded];
        }
    });
}

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

#pragma mark - GraphicsProtocol

- (void)updateTheme{
    [super updateTheme];
}

- (void)giveGraphicsAndColorOutlets{
    [super giveGraphicsAndColorOutlets];
    
    self.currentLocationView.backgroundColor = [UIColor clearColor];
    
    self.currentLocationTitleView.backgroundColor = [[ProjectGraphicsProxy sharedProxy] lightGrayTransparentColor];
    self.addressView.backgroundColor = [[ProjectGraphicsProxy sharedProxy] candyStoreThemeRedToBrownColor];
}

- (NSArray*)titleInvertedLabels{
    return @[self.addressLabel];
}

- (NSArray*)titleLabels{
    return @[self.currentLocationTitleLabel];
}

- (UIColor*)viewControllerBackgroundColor{
    return [[ProjectGraphicsProxy sharedProxy] candyStoreThemeDarkGreenColor];
}

- (UIColor*)navigationControllerBackgroundColor{
    return [self viewControllerBackgroundColor];
}

- (UIColor*)navigationBarBackgroundColor{
    return [[ProjectGraphicsProxy sharedProxy] candyStoreThemeDarkGreenTransparentColor];
}

#pragma mark - Class Methods

+ (instancetype)defaultAllVenuesMapViewController{
    AllVenuesMapViewController *allVenuesMapViewController = [[AllVenuesMapViewController alloc]initWithNibName:@"AllVenuesMapViewController" bundle:nil];
    return allVenuesMapViewController;
}

+ (BOOL)shouldStopAfterFirstReverseGeocoding{
    return NO;//TODO: debug. This must be commented because the project is designed to stop after the first fetch for the project
    return YES;
}

@end
