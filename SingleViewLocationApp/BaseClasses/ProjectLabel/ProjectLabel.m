//
//  ProjectLabel.m
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 5/3/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import "ProjectLabel.h"

@implementation ProjectLabel

- (void)layoutSubviews
{
    self.preferredMaxLayoutWidth = self.frame.size.width;
    [super layoutSubviews];
}

@end
