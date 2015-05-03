//
//  ProjectViewController.h
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 4/28/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphicsProxy.h"
#import "ProjectGraphicsProxy.h"
#import "UIView+ProjectAdditions.h"
#import "NSString+Translations.h"
#import "ProjectLabel.h"

@interface ProjectViewController : UIViewController <GraphicsProtocol>

- (CGFloat)animationTime;

- (void)updateTranslations;

@end
