//
//  ProjectLocationManager.h
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 4/28/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface ProjectLocationManager : CLLocationManager

+ (instancetype)sharedManager;//you can also call init if you need a separated instance than the shared manager

//also setting .delegate will call addDelegate. Please remember to remove once dealloced.
- (void)addDelegate:(id<CLLocationManagerDelegate>)delegate;
- (void)removeDelegate:(id<CLLocationManagerDelegate>)delegate;

- (void)userExplicitlyRequestedLocationAccess;//please call this once user explicitly requested location access since Apple says that on docs for U-X. Start Updates will be called automatically once user grants authorization

@property (nonatomic, strong, readonly) CLLocation *veryFirstFetchedLocation;

@end
