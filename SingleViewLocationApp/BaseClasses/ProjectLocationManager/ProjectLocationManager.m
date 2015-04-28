//
//  ProjectLocationManager.m
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 4/28/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import "ProjectLocationManager.h"
#import "NSString+Translations.h"
#import "UIApplication+ProjectAdditions.h"

static ProjectLocationManager *sharedManager;//this is a singleton

@interface ProjectLocationManager () <CLLocationManagerDelegate, UIAlertViewDelegate>

@property (nonatomic, strong, readwrite) CLLocation *veryFirstFetchedLocation;

@property (nonatomic, strong) NSMutableArray *delegatesMutableArray;
@property (nonatomic, strong) UIAlertView *grantAuthorizationAlertView;
@property (nonatomic, strong) UIAlertView *thisAppNeedsAuthorizationForLocationAlertView;
@property (nonatomic, strong) UIAlertView *mustTurnOnLocationServicesAlertView;
@property (nonatomic, strong) UIAlertView *mustGrantLocationServicesAuthorizationFromSettingsAlertView;

@end

@implementation ProjectLocationManager

#pragma mark - Class Methods

+ (instancetype)sharedManager{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedManager = [[self alloc] init];
        [sharedManager loadProjectLocationSharedManagerConfiguration];
    });
    return sharedManager;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.delegate = self;
        //todo: debug clean up
        [ProjectLocationManager didShowAuthorizationMessageOnce];
    }
    return self;
}

- (NSString *)description{
    NSMutableString *descriptionMutableString = [[NSMutableString alloc]initWithString:[super description]];
    
    return descriptionMutableString;
}

#pragma mark - Class Functionality

- (void)loadProjectLocationSharedManagerConfiguration
{
    self.distanceFilter = kCLDistanceFilterNone; //whenever we move
    self.desiredAccuracy = kCLLocationAccuracyBest;
}

- (void)makeSureUserHasBeenNoticedAndTurnedOnLocationServicesAndGrantedAuthorizationIfNeeded{
    BOOL didNotice = [self noticeUserForLocationAuthorizationIfNeeded];
    if (!didNotice) {
        [self askUserToEnableLocationServicesIfNeeded];
    }
}

- (BOOL)noticeUserForLocationAuthorizationIfNeeded{ //returns YES if did notice
    BOOL shouldNotice = ![ProjectLocationManager hasShownAuthorizationMessageOnce];
    if (shouldNotice) {
        [self.grantAuthorizationAlertView show];
    }
    return shouldNotice;
}

- (void)askUserToEnableLocationServicesIfNeeded{
    BOOL locationServicesEnabled = [ProjectLocationManager locationServicesEnabled];//calling will trigger alerts if return is NO, so for debug its a BOOL var
    if (locationServicesEnabled) {
        [self requestAuthorizationIfNeededAndStartUpdating];
    }else{
        [self.mustTurnOnLocationServicesAlertView show];
    }
}

- (void)requestAuthorizationIfNeededAndStartUpdating{
    CLAuthorizationStatus authorizationStatus = [ProjectLocationManager authorizationStatus];
    if (authorizationStatus == kCLAuthorizationStatusNotDetermined) {
        [self requestWhenInUseAuthorization];
    }else if (authorizationStatus == kCLAuthorizationStatusDenied){
        [self.mustGrantLocationServicesAuthorizationFromSettingsAlertView show];
    }else if (authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse){
        [self startUpdatingLocation];
    }
}

//Apple documentation says:   locationServicesEnabled...You may want to check this property and use location services only when explicitly requested by the user.
- (void)userExplicitlyRequestedLocationAccess{
    [self makeSureUserHasBeenNoticedAndTurnedOnLocationServicesAndGrantedAuthorizationIfNeeded];
}

#pragma mark - Actions

- (void)setDelegate:(id<CLLocationManagerDelegate>)delegate{
    if ([delegate isEqual:self]){
        [super setDelegate:delegate];
    }else{
        [self addDelegate:delegate];
    }
}

- (void)addDelegate:(id<CLLocationManagerDelegate>)delegate{
    @synchronized(self){
        if (![self.delegatesMutableArray containsObject:delegate]) {
            [self.delegatesMutableArray addObject:delegate];
        }
    }
}

- (void)removeDelegate:(id<CLLocationManagerDelegate>)delegate{
    @synchronized(self){
        [self.delegatesMutableArray removeObject:delegate];
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView == self.grantAuthorizationAlertView) {
        [self askUserToEnableLocationServicesIfNeeded];
    }
}

- (void)didPresentAlertView:(UIAlertView *)alertView{
    if (alertView == self.grantAuthorizationAlertView) {
        [ProjectLocationManager didShowAuthorizationMessageOnce];
    }
}

#pragma mark - Properties

- (NSMutableArray*)delegatesMutableArray{
    if (!_delegatesMutableArray) {
        _delegatesMutableArray = [[NSMutableArray alloc]init];
    }
    return _delegatesMutableArray;
}

- (void)setVeryFirstFetchedLocation:(CLLocation *)veryFirstFetchedLocation{
    if (!_veryFirstFetchedLocation) {
        _veryFirstFetchedLocation = veryFirstFetchedLocation;
    }
}


- (UIAlertView*)grantAuthorizationAlertView{
    if (!_grantAuthorizationAlertView) {
        NSString *titleTranslation = [@"authorizeLocationAlertTitle" translate];
        NSString *messageTranslation = [@"mustAuthorizeLocationAlertMessage" translate];
        NSString *okButtonTranslation = [@"okButton" translate];
        
        _grantAuthorizationAlertView = [[UIAlertView alloc]initWithTitle:titleTranslation
                                                                 message:messageTranslation
                                                                delegate:self
                                                       cancelButtonTitle:okButtonTranslation
                                                       otherButtonTitles:nil, nil];
    }
    return _grantAuthorizationAlertView;
}

- (UIAlertView*)thisAppNeedsAuthorizationForLocationAlertView{
    if (!_thisAppNeedsAuthorizationForLocationAlertView) {
        NSString *titleTranslation = [@"authorizeLocationAlertTitle" translate];
        NSString *messageTranslation = [@"thisAppNeedsAuthorizationForLocationAlertView" translate];
        NSString *okButtonTranslation = [@"okButton" translate];
        
        _thisAppNeedsAuthorizationForLocationAlertView = [[UIAlertView alloc]initWithTitle:titleTranslation
                                                                                   message:messageTranslation
                                                                                  delegate:nil
                                                                         cancelButtonTitle:okButtonTranslation
                                                                         otherButtonTitles:nil, nil];
    }
    return _thisAppNeedsAuthorizationForLocationAlertView;
}

- (UIAlertView*)mustTurnOnLocationServicesAlertView{
    if (!_mustTurnOnLocationServicesAlertView) {
        NSString *titleTranslation = [@"authorizeLocationAlertTitle" translate];
        NSString *messageTranslation = [@"mustTurnOnLocationServicesAlertView" translate];
        NSString *okButtonTranslation = [@"okButton" translate];
        
        _mustTurnOnLocationServicesAlertView = [[UIAlertView alloc]initWithTitle:titleTranslation
                                                                         message:messageTranslation
                                                                        delegate:nil
                                                               cancelButtonTitle:okButtonTranslation
                                                               otherButtonTitles:nil, nil];
    }
    return _mustTurnOnLocationServicesAlertView;
}

- (UIAlertView*)mustGrantLocationServicesAuthorizationFromSettingsAlertView{
    if (!_mustGrantLocationServicesAuthorizationFromSettingsAlertView) {
        NSString *titleTranslation = [@"authorizeLocationAlertTitle" translate];
        NSString *messageTranslation = [@"mustGrantLocationServicesAuthorizationFromSettingsAlertView" translate];
        NSString *okButtonTranslation = [@"okButton" translate];
        
        _mustGrantLocationServicesAuthorizationFromSettingsAlertView = [[UIAlertView alloc]initWithTitle:titleTranslation
                                                                                                 message:messageTranslation
                                                                                                delegate:nil
                                                                                       cancelButtonTitle:okButtonTranslation
                                                                                       otherButtonTitles:nil, nil];
    }
    return _mustGrantLocationServicesAuthorizationFromSettingsAlertView;
}

#pragma mark - User's Defaults for Location

+ (BOOL)hasShownAuthorizationMessageOnce{
    if (![UIApplication iOSLessThan8]){//iOS will display from plist file NSLocationWhenInUseUsageDescription
        [ProjectLocationManager didShowAuthorizationMessageOnce];
    }
    
    BOOL hasShownAuthorizationMessageOnce = [[NSUserDefaults standardUserDefaults] boolForKey:@"hasShownAuthorizationMessageOnce"];
    return hasShownAuthorizationMessageOnce;
}

+ (void)didShowAuthorizationMessageOnce{
    [[NSUserDefaults standardUserDefaults] setBool:YES
                                            forKey:@"hasShownAuthorizationMessageOnce"];
}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    for (id <CLLocationManagerDelegate> delegate in [self.delegatesMutableArray mutableCopy]) {
        if ([delegate respondsToSelector:@selector(locationManager:didUpdateToLocation:fromLocation:)]) {
            [delegate locationManager:manager
                  didUpdateToLocation:newLocation
                         fromLocation:oldLocation];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations{
    
    self.veryFirstFetchedLocation = [locations firstObject];
    
    for (id <CLLocationManagerDelegate> delegate in [self.delegatesMutableArray mutableCopy]) {
        if ([delegate respondsToSelector:@selector(locationManager:didUpdateLocations:)]) {
            [delegate locationManager:manager
                   didUpdateLocations:[locations mutableCopy]];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager
       didUpdateHeading:(CLHeading *)newHeading{
    for (id <CLLocationManagerDelegate> delegate in [self.delegatesMutableArray mutableCopy]) {
        if ([delegate respondsToSelector:@selector(locationManager:didUpdateHeading:)]) {
            [delegate locationManager:manager
                     didUpdateHeading:newHeading];
        }
    }
}

- (BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager *)manager{
    BOOL shouldDisplayHeadingCalibration = NO;
    for (id <CLLocationManagerDelegate> delegate in [self.delegatesMutableArray mutableCopy]) {
        if ([delegate respondsToSelector:@selector(locationManager:didUpdateToLocation:fromLocation:)]) {
            if ([delegate respondsToSelector:@selector(locationManagerShouldDisplayHeadingCalibration:)]) {
                BOOL thisDelegateResponse = [delegate locationManagerShouldDisplayHeadingCalibration:manager];
                if (thisDelegateResponse) {
                    shouldDisplayHeadingCalibration = YES;
                    break;
                }
            }
        }
    }
    return shouldDisplayHeadingCalibration;
}

- (void)locationManager:(CLLocationManager *)manager
      didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region{
    for (id <CLLocationManagerDelegate> delegate in [self.delegatesMutableArray mutableCopy]) {
        if ([delegate respondsToSelector:@selector(locationManager:didDetermineState:forRegion:)]) {
            [delegate locationManager:manager
                    didDetermineState:state
                            forRegion:region];
        }
    }
}


- (void)locationManager:(CLLocationManager *)manager
        didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region{
    for (id <CLLocationManagerDelegate> delegate in [self.delegatesMutableArray mutableCopy]) {
        if ([delegate respondsToSelector:@selector(locationManager:didRangeBeacons:inRegion:)]) {
            [delegate locationManager:manager
                      didRangeBeacons:beacons
                             inRegion:region];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager
rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region
              withError:(NSError *)error{
    for (id <CLLocationManagerDelegate> delegate in [self.delegatesMutableArray mutableCopy]) {
        if ([delegate respondsToSelector:@selector(locationManager:rangingBeaconsDidFailForRegion:withError:)]) {
            [delegate locationManager:manager
       rangingBeaconsDidFailForRegion:region
                            withError:[error copy]];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager
         didEnterRegion:(CLRegion *)region{
    for (id <CLLocationManagerDelegate> delegate in [self.delegatesMutableArray mutableCopy]) {
        if ([delegate respondsToSelector:@selector(locationManager:didEnterRegion:)]) {
            [delegate locationManager:manager
                       didEnterRegion:region];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager
          didExitRegion:(CLRegion *)region{
    for (id <CLLocationManagerDelegate> delegate in [self.delegatesMutableArray mutableCopy]) {
        if ([delegate respondsToSelector:@selector(locationManager:didExitRegion:)]) {
            [delegate locationManager:manager
                        didExitRegion:region];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    for (id <CLLocationManagerDelegate> delegate in [self.delegatesMutableArray mutableCopy]) {
        if ([delegate respondsToSelector:@selector(locationManager:didFailWithError:)]) {
            [delegate locationManager:manager
                     didFailWithError:error];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager
monitoringDidFailForRegion:(CLRegion *)region
              withError:(NSError *)error{
    for (id <CLLocationManagerDelegate> delegate in [self.delegatesMutableArray mutableCopy]) {
        if ([delegate respondsToSelector:@selector(locationManager:monitoringDidFailForRegion:withError:)]) {
            [delegate locationManager:manager
           monitoringDidFailForRegion:region
                            withError:[error copy]];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self startUpdatingLocation];
    }else if (status == kCLAuthorizationStatusNotDetermined){
        [self requestAuthorizationIfNeededAndStartUpdating];
    }
    
    for (id <CLLocationManagerDelegate> delegate in [self.delegatesMutableArray mutableCopy]) {
        if ([delegate respondsToSelector:@selector(locationManager:didChangeAuthorizationStatus:)]) {
            [delegate locationManager:manager
         didChangeAuthorizationStatus:status];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager
didStartMonitoringForRegion:(CLRegion *)region{
    for (id <CLLocationManagerDelegate> delegate in [self.delegatesMutableArray mutableCopy]) {
        if ([delegate respondsToSelector:@selector(locationManager:didStartMonitoringForRegion:)]) {
            [delegate locationManager:manager
          didStartMonitoringForRegion:region];
        }
    }
}

- (void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager{
    for (id <CLLocationManagerDelegate> delegate in [self.delegatesMutableArray mutableCopy]) {
        if ([delegate respondsToSelector:@selector(locationManagerDidPauseLocationUpdates:)]) {
            [delegate locationManagerDidPauseLocationUpdates:manager];
        }
    }
}
- (void)locationManagerDidResumeLocationUpdates:(CLLocationManager *)manager{
    for (id <CLLocationManagerDelegate> delegate in [self.delegatesMutableArray mutableCopy]) {
        if ([delegate respondsToSelector:@selector(locationManagerDidResumeLocationUpdates:)]) {
            [delegate locationManagerDidResumeLocationUpdates:manager];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager
didFinishDeferredUpdatesWithError:(NSError *)error{
    for (id <CLLocationManagerDelegate> delegate in [self.delegatesMutableArray mutableCopy]) {
        if ([delegate respondsToSelector:@selector(locationManager:didFinishDeferredUpdatesWithError:)]) {
            [delegate locationManager:manager
    didFinishDeferredUpdatesWithError:[error copy]];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didVisit:(CLVisit *)visit{
    for (id <CLLocationManagerDelegate> delegate in [self.delegatesMutableArray mutableCopy]) {
        if ([delegate respondsToSelector:@selector(locationManager:didVisit:)]) {
            [delegate locationManager:manager
                             didVisit:visit];
        }
    }
}

@end
