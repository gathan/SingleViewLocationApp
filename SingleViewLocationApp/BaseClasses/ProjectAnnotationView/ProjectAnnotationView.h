//
//  ProjectAnnotationView.h
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 5/1/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface ProjectAnnotationView : MKAnnotationView

+ (UIImage*)selectedImage; //please override on subclassing
+ (UIImage*)nonSelectedImage;  //please override on subclassing
+ (NSString*)defaultAnnotationIdentifier;  //please override on subclassing

@end
