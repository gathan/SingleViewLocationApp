//
//  VenueMiniInfoViewController.h
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 5/2/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import "ProjectViewController.h"

@class Venue;

@interface VenueMiniInfoViewController : ProjectViewController

@property (nonatomic, strong) Venue *venue;

+ (instancetype)defaultVenueMiniInfoViewController;

@end
