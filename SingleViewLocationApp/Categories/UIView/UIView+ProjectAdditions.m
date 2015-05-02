//
//  UIView+ProjectAdditions.m
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 5/2/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import "UIView+ProjectAdditions.h"

@implementation UIView (ProjectAdditions)

- (void)convertToCircle{
    self.layer.cornerRadius = self.bounds.size.width / 2;
    self.clipsToBounds = YES;
}

@end
