//
//  AllVenuesMapViewController.m
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 4/28/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import "AllVenuesMapViewController.h"
#import "ProjectLocationManager.h"

@interface AllVenuesMapViewController () <CLLocationManagerDelegate>

@property (nonatomic, strong) ProjectLocationManager *projectLocationManager;

@end

@implementation AllVenuesMapViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.projectLocationManager addDelegate:self];
    [self.projectLocationManager userExplicitlyRequestedLocationAccess];//This is the best time to ask for user's will to give location data to us. It could be when user tapped a button if there was one to activate location (Apple documentation says:   locationServicesEnabled...You may want to check this property and use location services only when explicitly requested by the user.)
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations{
    
}

#pragma mark - Properties

- (ProjectLocationManager*)projectLocationManager{
    if (!_projectLocationManager) {
        _projectLocationManager = [ProjectLocationManager sharedManager];
    }
    return _projectLocationManager;
}

#pragma mark - Class Methods

+ (instancetype)defaultAllVenuesMapViewController{
    AllVenuesMapViewController *allVenuesMapViewController = [[AllVenuesMapViewController alloc]initWithNibName:@"AllVenuesMapViewController" bundle:nil];
    return allVenuesMapViewController;
}

@end
