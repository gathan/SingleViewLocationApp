//
//  ProjectAnnotationView.m
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 5/1/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import "ProjectAnnotationView.h"

@implementation ProjectAnnotationView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setImageForSelected:self.selected];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    
    [self setImageForSelected:selected];
}

- (void)setImageForSelected:(BOOL)selected{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (selected) {
            self.image = [[self class] selectedImage];
        }else{
            self.image = [[self class] nonSelectedImage];
        }
    });
}

#pragma mark - Class Methods

+ (NSString*)defaultAnnotationIdentifier{
    return @"defaultAnnotationIdentifier";
}

+ (UIImage*)selectedImage{
    return [UIImage new];
}

+ (UIImage*)nonSelectedImage{
    return [UIImage new];
}

@end
