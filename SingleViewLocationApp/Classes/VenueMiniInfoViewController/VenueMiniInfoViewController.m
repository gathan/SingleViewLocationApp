//
//  VenueMiniInfoViewController.m
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 5/2/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import "VenueMiniInfoViewController.h"
#import "Venue.h"
#import "NSObject+ProjectAdditions.h"

@interface VenueMiniInfoViewController ()

@property (weak, nonatomic) IBOutlet UIView *contentView;

#pragma mark - IBOutlets

#pragma mark -- Venue Info Outlets

@property (weak, nonatomic) IBOutlet UIImageView *venuePhotoImageView;
@property (weak, nonatomic) IBOutlet UILabel *venueSuperTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *venueTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *venueMiniTitleLabel;

#pragma mark -- Rating Eclipse view
@property (weak, nonatomic) IBOutlet UIView *ratingEclipseView;
@property (weak, nonatomic) IBOutlet UIView *ratingEclipseContentView;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;

@end

@implementation VenueMiniInfoViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateUI];
    [self updateVenuePhoto];
}

- (void)updateUI{
    self.venueSuperTitleLabel.text = self.venue.name;
    self.venueTitleLabel.text = self.venue.address;
    self.venueMiniTitleLabel.text = self.venue.phone;
    self.ratingLabel.text = self.venue.rating.stringValue;
    if (![self.ratingLabel.text isStringAndNotEmpty]) {
        self.ratingLabel.text = @"-/-";
    }
}

- (void)updateVenuePhoto{

}

#pragma mark - Delegates

#pragma mark -- GraphicsProtocol

- (void)updateTheme{
    [super updateTheme];
    self.view.layer.cornerRadius = 4.0f;
    self.view.clipsToBounds = YES;
    self.contentView.backgroundColor = [[ProjectGraphicsProxy sharedProxy] projectWhiteColor];
}

- (void)updateThemeViewsGeometry{
    [super updateThemeViewsGeometry];
    [self.ratingEclipseView convertToCircle];
    [self.ratingEclipseContentView convertToCircle];
}

- (void)giveGraphicsAndColorOutlets{
    [super giveGraphicsAndColorOutlets];
    
    self.ratingEclipseView.backgroundColor = [[ProjectGraphicsProxy sharedProxy] candyStoreThemeRedToBrownColor];
    
    self.ratingEclipseContentView.backgroundColor = [[ProjectGraphicsProxy sharedProxy] candyStoreThemeCoralColor];
    
    self.venuePhotoImageView.backgroundColor = [[ProjectGraphicsProxy sharedProxy] lightGrayTransparentColor];
}

- (UIColor*)viewControllerBackgroundColor{
    return [[ProjectGraphicsProxy sharedProxy] lightGrayOpaqueColor];
}

- (NSArray*)titleLabels{
    return @[self.venueSuperTitleLabel, self.venueMiniTitleLabel];
}

- (NSArray*)titleDifferentLabels{
    return @[self.venueTitleLabel];
}

- (NSArray*)titleInvertedBoldLabels{
    return @[self.ratingLabel];
}

#pragma mark - Properties

- (void)setVenue:(Venue *)venue{
    BOOL differentVenue = ![venue.codeId isEqualToString:_venue.codeId];
    _venue = venue;
    [self updateUI];
    if (differentVenue) {
        self.venuePhotoImageView.image = nil;
        [self updateVenuePhoto];
    }
}

#pragma mark - Class Methods

+ (instancetype)defaultVenueMiniInfoViewController{
    VenueMiniInfoViewController *venueMiniInfoViewController = [[VenueMiniInfoViewController alloc]initWithNibName:@"VenueMiniInfoViewController" bundle:nil];
    return venueMiniInfoViewController;
}

@end
