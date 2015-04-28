//
//  AllVenuesMapViewController.m
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 4/28/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import "AllVenuesMapViewController.h"

@interface AllVenuesMapViewController ()

@end

@implementation AllVenuesMapViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

#pragma mark - Class Methods

+ (instancetype)defaultAllVenuesMapViewController{
    AllVenuesMapViewController *allVenuesMapViewController = [[AllVenuesMapViewController alloc]initWithNibName:@"AllVenuesMapViewController" bundle:nil];
    return allVenuesMapViewController;
}

@end
