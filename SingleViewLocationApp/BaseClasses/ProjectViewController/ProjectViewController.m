//
//  ProjectViewController.m
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 4/28/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import "ProjectViewController.h"

@interface ProjectViewController ()

@end

@implementation ProjectViewController

#pragma mark - View Life Cycle

- (void)awakeFromNib{
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateTheme];
    self.automaticallyAdjustsScrollViewInsets = self.automaticallyAdjustsScrollViewInsets;    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

#pragma mark - GraphicsProtocol

- (void)updateTheme{
    if ([self respondsToSelector:@selector(viewControllerBackgroundColor)]) {
        self.view.backgroundColor = [self viewControllerBackgroundColor];
    }
    
    if ([self respondsToSelector:@selector(navigationControllerBackgroundColor)]) {
        self.navigationController.view.backgroundColor = [self navigationControllerBackgroundColor];
    }
    
    if ([self respondsToSelector:@selector(navigationBarBackgroundColor)]) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                      forBarMetrics:UIBarMetricsDefault];
        
        self.navigationController.navigationBar.shadowImage = [UIImage new];
        self.navigationController.navigationBar.translucent = YES;
        self.navigationController.view.backgroundColor = [UIColor clearColor];
        self.navigationController.navigationBar.backgroundColor = [self navigationBarBackgroundColor];
    }
    else
    {
        [self.navigationController.navigationBar setTranslucent:[[ProjectGraphicsProxy sharedProxy] translucentNavigationBar]];
    }
    
    [self giveGraphicsAndColorOutlets];
}

- (BOOL)automaticallyAdjustsScrollViewInsets{
    return NO;
}

- (void)giveGraphicsAndColorOutlets{
    
    if ([self respondsToSelector:@selector(titleLabels)]) {
        NSArray *titleLabels = [self titleLabels];
        for (UILabel *titleLabel in titleLabels) {
            [titleLabel markLabelAsTitle];
        }
    }
    
    if ([self respondsToSelector:@selector(titleInvertedLabels)]) {
        NSArray *titleInvertedLabels = [self titleInvertedLabels];
        for (UILabel *titleInvertedlabel in titleInvertedLabels) {
            [titleInvertedlabel markLabelAsTitleInverted];
        }
    }
    
    if ([self respondsToSelector:@selector(bodyLabels)]) {
        NSArray *bodyLabels = [self bodyLabels];
        for (UILabel *bodyLabel in bodyLabels) {
            [bodyLabel markLabelAsBody];
        }
    }
    
    if ([self respondsToSelector:@selector(bodyInvertedLabels)]) {
        NSArray *bodyInvertedLabels = [self bodyInvertedLabels];
        for (UILabel *bodyInvertedLabel in bodyInvertedLabels) {
            [bodyInvertedLabel markLabelAsBodyInverted];
        }
    }
}

@end
