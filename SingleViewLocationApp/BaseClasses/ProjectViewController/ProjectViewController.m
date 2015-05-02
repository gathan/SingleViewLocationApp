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
    [self setNeedsStatusBarAppearanceUpdate];
    [self updateTheme];
    [self updateTranslations];
    self.automaticallyAdjustsScrollViewInsets = self.automaticallyAdjustsScrollViewInsets;    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateThemeViewsGeometry];
}

- (void)updateTranslations{

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
    
    self.navigationController.navigationBar.tintColor = [[ProjectGraphicsProxy sharedProxy] lightGrayTransparentColor];
    
    [self giveGraphicsAndColorOutlets];
}

- (void)updateThemeViewsGeometry{

}

- (BOOL)automaticallyAdjustsScrollViewInsets{
    return NO;
}

- (void)giveGraphicsAndColorOutlets{
    
    if ([self respondsToSelector:@selector(titleLabels)]) {
        NSArray *titleLabels = [self titleLabels];
        for (UILabel *titleLabel in titleLabels) {
            [titleLabel markLabelAsTitleThatIsBold:NO];
        }
    }
    
    if ([self respondsToSelector:@selector(titleBoldLabels)]) {
        NSArray *titleBoldLabels = [self titleBoldLabels];
        for (UILabel *titleBoldLabel in titleBoldLabels) {
            [titleBoldLabel markLabelAsTitleThatIsBold:YES];
        }
    }
    
    if ([self respondsToSelector:@selector(titleDifferentLabels)]) {
        NSArray *titleDifferentLabels = [self titleDifferentLabels];
        for (UILabel *titleDifferentLabel in titleDifferentLabels) {
            [titleDifferentLabel markLabelAsTitleDifferentThatIsBold:NO];
        }
    }
    
    if ([self respondsToSelector:@selector(titleDifferentBoldLabels)]) {
        NSArray *titleDifferentBoldLabels = [self titleDifferentBoldLabels];
        for (UILabel *titleDifferentBoldLabel in titleDifferentBoldLabels) {
            [titleDifferentBoldLabel markLabelAsTitleDifferentThatIsBold:YES];
        }
    }
    
    if ([self respondsToSelector:@selector(titleInvertedLabels)]) {
        NSArray *titleInvertedLabels = [self titleInvertedLabels];
        for (UILabel *titleInvertedlabel in titleInvertedLabels) {
            [titleInvertedlabel markLabelAsTitleInvertedThatIsBold:NO];
        }
    }
    
    if ([self respondsToSelector:@selector(titleInvertedBoldLabels)]) {
        NSArray *titleInvertedBoldLabels = [self titleInvertedBoldLabels];
        for (UILabel *titleInvertedBoldLabel in titleInvertedBoldLabels) {
            [titleInvertedBoldLabel markLabelAsTitleInvertedThatIsBold:YES];
        }
    }
    
    if ([self respondsToSelector:@selector(bodyLabels)]) {
        NSArray *bodyLabels = [self bodyLabels];
        for (UILabel *bodyLabel in bodyLabels) {
            [bodyLabel markLabelAsBodyThatIsBold:NO];
        }
    }
    
    if ([self respondsToSelector:@selector(bodyBoldLabels)]) {
        NSArray *bodyBoldLabels = [self bodyBoldLabels];
        for (UILabel *bodyBoldLabel in bodyBoldLabels) {
            [bodyBoldLabel markLabelAsBodyThatIsBold:YES];
        }
    }
    
    if ([self respondsToSelector:@selector(bodyInvertedLabels)]) {
        NSArray *bodyInvertedLabels = [self bodyInvertedLabels];
        for (UILabel *bodyInvertedLabel in bodyInvertedLabels) {
            [bodyInvertedLabel markLabelAsBodyInvertedThatIsBold:NO];
        }
    }
    
    if ([self respondsToSelector:@selector(bodyInvertedBoldLabels)]) {
        NSArray *bodyInvertedBoldLabels = [self bodyInvertedBoldLabels];
        for (UILabel *bodyInvertedBoldLabel in bodyInvertedBoldLabels) {
            [bodyInvertedBoldLabel markLabelAsBodyInvertedThatIsBold:YES];
        }
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return [[ProjectGraphicsProxy sharedProxy] statusBarStyle];
}

- (CGFloat)animationTime{
    return 0.3;
}

@end
