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

@interface ProjectViewController : UIViewController <GraphicsProtocol>

- (CGFloat)animationTime;

@end
