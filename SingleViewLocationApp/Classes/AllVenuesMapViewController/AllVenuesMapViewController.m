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
#import <MapKit/MapKit.h>
#import "VenueAnnotationView.h"
#import "UserLocationAnnotationView.h"
#import "VenueMiniInfoViewController.h"
#import "UIView+ProjectAnimations.h"

@interface AllVenuesMapViewController () <CLLocationManagerDelegate, MKMapViewDelegate, GoogleMapsProjectGeocoderDelegate, FourSquareDelegate>

@property (nonatomic, strong) ProjectLocationManager *locationManager;
@property (nonatomic, strong) GoogleMapsProjectGeocoder *geocoder;
@property (nonatomic, strong) GMSAddress *latestGMSAddress;
@property (nonatomic, strong) VenueDataSource *venueDataSource;

@property (nonatomic, strong) NSMutableArray *venuesMutableArray;

@property (nonatomic, strong) UIImageView *navigationItemCustomImageView;

@property (nonatomic, strong) UIBarButtonItem *homeBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *closeBarButtonItem;

@property (nonatomic, strong) VenueMiniInfoViewController *venueMiniInfoViewController;

//note: using pragma marks so much like this helps when someone other will use this class. On top file inspector for the current file, press the button on the right of the current file. All sections of pragma marks will be sorted. also pragma marking a delegate, will take you to the actual delegate with CMD+click
#pragma mark - IBOutlets

#pragma mark -- Map
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

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

#pragma mark -- VenueMiniInfoView

@property (nonatomic, getter = isVenueMiniInfoViewContainerViewHidden) BOOL venueMiniInfoViewContainerViewHidden;
@property (weak, nonatomic) IBOutlet UIView *venueMiniInfoViewContainerView;


#pragma mark - Class Methods

+ (BOOL)shouldStopAfterFirstReverseGeocoding;

@end

@implementation AllVenuesMapViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = self.homeBarButtonItem;
    
//    self.mapView.rotateEnabled = NO;
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollowWithHeading];
    

    [self.locationManager addDelegate:self];
    [self.locationManager userExplicitlyRequestedLocationAccess];//This is the best time to ask for user's will to give location data to us. It could be when user tapped a button if there was one to activate location (Apple documentation says:   locationServicesEnabled...You may want to check this property and use location services only when explicitly requested by the user.)
    self.venueDataSource.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationItem.titleView = self.navigationItemCustomImageView;
    
    BOOL hasFoundAddress = self.latestGMSAddress != nil;
    [self makeCurrentLocationViewHidden:!hasFoundAddress animated:NO];
}

- (void)updateUI{
    self.addressLabel.text = self.latestGMSAddress.thoroughfare;
}


- (void)updateTranslations{
    [super updateTranslations];
    self.currentLocationTitleLabel.text = [[@"Current Location" translate] uppercaseString];
 }

#pragma mark - Actions

- (void)reverseGeocodeLocation:(CLLocation*)location{

    [self.geocoder startReverseGeocodingGMSAddressForCLLocationCoordinate:location.coordinate];
}

- (void)homeAction{
    if (self.locationManager.location) {
        MKCoordinateRegion region = MKCoordinateRegionMake(self.locationManager.location.coordinate, MKCoordinateSpanMake(0.001, 0.001));
        [self.mapView setRegion:region animated:YES];
    }
}

- (void)closeAction{
    [self makeVenueMiniInfoViewHidden:YES animated:YES completion:nil];
}

#pragma mark - Delegates

#pragma mark -- GoogleMapsProjectGeocoderDelegate

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

#pragma mark -- FourSquareDelegate

- (void)fourSquareDataSource:(FourSquareDataSource*)fourSquareDataSource successfullyFetchedFourSquareObjects:(NSArray*)foursquareObjectsArray{
    if (fourSquareDataSource == self.venueDataSource)
    {
        NSMutableArray *copyOfVenuesMutableArray = [self.venuesMutableArray copy];
        for (Venue *venue in foursquareObjectsArray) {
            if (![copyOfVenuesMutableArray containsObject:venue]) {
                [copyOfVenuesMutableArray addObject:venue];
                [self.mapView addAnnotation:venue];
            }
        }
        
        self.venuesMutableArray = copyOfVenuesMutableArray;
        //reload
    }
}

- (void)fourSquareDataSource:(FourSquareDataSource*)fourSquareDataSource
             failedWithError:(NSError*)error{

}

#pragma mark -- CLLocationManagerDelegate

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

#pragma mark -- MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    [self.venueDataSource fetchVenuesForLocationCoordinate:mapView.region.center];
}

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
    [self makeVenueMiniInfoViewHidden:YES animated:YES completion:nil];
}

- (MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    MKAnnotationView *annotationViewToReturn;
    if ([annotation isKindOfClass:[Venue class]])
    {
        VenueAnnotationView *venueAnnotationView = (VenueAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:[VenueAnnotationView defaultAnnotationIdentifier]];
        
        if (!venueAnnotationView) {
            venueAnnotationView = [[VenueAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:[VenueAnnotationView defaultAnnotationIdentifier]];
        }
        
        venueAnnotationView.venue = annotation;
        
        annotationViewToReturn = venueAnnotationView;
    }
    else if (annotation == self.mapView.userLocation)
    {
        UserLocationAnnotationView *userLocationAnnotationView = (UserLocationAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:[UserLocationAnnotationView defaultAnnotationIdentifier]];
        
        if (!userLocationAnnotationView) {
            userLocationAnnotationView = [[UserLocationAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:[UserLocationAnnotationView defaultAnnotationIdentifier]];
        }
        
        annotationViewToReturn = userLocationAnnotationView;
    }
        
    return annotationViewToReturn;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    if (view.annotation != self.mapView.userLocation) {
        [self makeVenueMiniInfoViewHidden:YES animated:YES completion:^{
             Venue *venue = (Venue*)view.annotation;
             self.venueMiniInfoViewController.venue = venue;
            [self makeVenueMiniInfoViewHidden:NO animated:YES completion:nil];
        }];
    }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view{
    [self makeVenueMiniInfoViewHidden:YES animated:YES completion:nil];
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

- (void)makeVenueMiniInfoViewHidden:(BOOL)hidden animated:(BOOL)animated  completion:(void (^)(void))completion
{
    self.venueMiniInfoViewContainerViewHidden = hidden;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        CGFloat resultAlpha;
        if (_venueMiniInfoViewContainerViewHidden) {
            resultAlpha = 0.0f;
        }else{
            resultAlpha = 1.0f;
        }
        if (animated){
            [UIView animateWithDuration:[self animationTime] animations:^{
                self.venueMiniInfoViewContainerView.alpha = resultAlpha;
            } completion:^(BOOL finished){
                if (completion) {
                    completion();
                }
                if (hidden) {
                    self.navigationItem.rightBarButtonItem = nil;
                }else{
                    self.navigationItem.rightBarButtonItem = self.closeBarButtonItem;
                }
            }];
        }else{
            self.venueMiniInfoViewContainerView.alpha = resultAlpha;
            if (completion) {
                completion();
            }
            if (hidden) {
                self.navigationItem.rightBarButtonItem = nil;
            }else{
                self.navigationItem.rightBarButtonItem = self.closeBarButtonItem;
            }
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

- (UIImageView*)navigationItemCustomImageView{
    if (!_navigationItemCustomImageView){
        UIImage *logoImage = [ProjectGraphicsProxy logo];
        _navigationItemCustomImageView = [[UIImageView alloc]initWithImage:logoImage];
    }
    return _navigationItemCustomImageView;
}

- (UIBarButtonItem*)homeBarButtonItem{
    if (!_homeBarButtonItem) {
        UIImage *homeImage = [ProjectGraphicsProxy homeIconImage];
        _homeBarButtonItem = [[UIBarButtonItem alloc]initWithImage:homeImage style:UIBarButtonItemStylePlain target:self action:@selector(homeAction)];
    }
    return _homeBarButtonItem;
}

- (UIBarButtonItem*)closeBarButtonItem{
    if (!_closeBarButtonItem) {
        UIImage *closeImage = [ProjectGraphicsProxy closeIconImage];
        _homeBarButtonItem = [[UIBarButtonItem alloc]initWithImage:closeImage style:UIBarButtonItemStylePlain target:self action:@selector(closeAction)];
    }
    return _homeBarButtonItem;
}

- (VenueMiniInfoViewController*)venueMiniInfoViewController{
    if (!_venueMiniInfoViewController) {
        _venueMiniInfoViewController = [VenueMiniInfoViewController defaultVenueMiniInfoViewController];
        _venueMiniInfoViewController.view.frame = self.venueMiniInfoViewContainerView.bounds;
        [self addChildViewController:_venueMiniInfoViewController];
        [self.venueMiniInfoViewContainerView addSubview:_venueMiniInfoViewController.view];
//        [_venueMiniInfoViewContainerView startAnimatingLikeGameCenterBalloonsFloating];
    }
    return _venueMiniInfoViewController;
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
    
    UIImage *myLocationImage = [ProjectGraphicsProxy myLocationImage];
    self.currentLocationImageView.image = myLocationImage;
    
    self.venueMiniInfoViewContainerView.backgroundColor = [UIColor clearColor];
}

- (NSArray*)titleInvertedLabels{
    return @[self.addressLabel];
}

- (NSArray*)titleBoldLabels{
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
//    return NO;//TODO: debug. This must be commented because the project is designed to stop after the first fetch for the project
    return YES;
}

@end
