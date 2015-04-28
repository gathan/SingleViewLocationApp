//
//  ProjectGoogleMapsManager.h
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 4/29/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMaps/GoogleMaps.h>

@interface ProjectGoogleMapsManager : NSObject

+ (void)prepareAfterAppDidFinishLaunching;//please call on AppDelegate didFinishLaunching
+ (NSString*)apiKey; //please subclass and override

@end


/* Installation Guide
 Launch Xcode and either open an existing project, or create a new project.
 If you're new to iOS, create a Single View Application, and ensure that Use Automatic Reference Counting is on.
 Drag the GoogleMaps.framework bundle to your project. When prompted, select Copy items if needed.
 Right-click GoogleMaps.framework in your project, and select Show In Finder.
 Drag the GoogleMaps.bundle from the Resources folder to your project. When prompted, ensure Copy items into destination group's folder is not selected.
 Select your project from the Project Navigator, and choose your application's target.
 Open the Build Phases tab, and within Link Binary with Libraries, add the following frameworks:
 AVFoundation.framework
 CoreData.framework
 CoreLocation.framework
 CoreText.framework
 GLKit.framework
 ImageIO.framework
 libc++.dylib
 libicucore.dylib
 libz.dylib
 OpenGLES.framework
 QuartzCore.framework
 SystemConfiguration.framework
 Choose your project, rather than a specific target, and open the Build Settings tab.
 In the Other Linker Flags section, add -ObjC. If these settings are not visible, change the filter in the Build Settings bar from Basic to All.
 */