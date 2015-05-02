//
//  FourSquareDataSourceAndProjectAdditionsTests.m
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 5/3/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "FourSquareDataSource+ProjectAdditions.h"

@interface FourSquareDataSourceAndProjectAdditionsTests : XCTestCase

@end

@implementation FourSquareDataSourceAndProjectAdditionsTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testBadInputShouldReturnOriginal {
    NSString *urlPhotoString = [FourSquareDataSource urlStringForFourSquarePhotoPrefix:@"https://prefix.com/"
                                                                             andSuffix:@"/suffix"
                                                                       withCustomWidth:YES
                                                                           ofWidthSize:40
                                                                      withCustomHeight:NO ofHeightSize:30
                                                                       orOriginalPhoto:NO];
    XCTAssertEqualObjects(urlPhotoString, @"https://prefix.com/original/suffix");
}

- (void)testOriginalWithBadInput {
    NSString *urlPhotoString = [FourSquareDataSource urlStringForFourSquarePhotoPrefix:@"https://prefix.com/"
                                                                             andSuffix:@"/suffix"
                                                                       withCustomWidth:YES
                                                                           ofWidthSize:40
                                                                      withCustomHeight:NO ofHeightSize:30
                                                                       orOriginalPhoto:YES];
    XCTAssertEqualObjects(urlPhotoString, @"https://prefix.com/original/suffix");
}

- (void)testOriginalWithGoodInput {
    NSString *urlPhotoString = [FourSquareDataSource urlStringForFourSquarePhotoPrefix:@"https://prefix.com/"
                                                                             andSuffix:@"/suffix"
                                                                       withCustomWidth:NO
                                                                           ofWidthSize:0
                                                                      withCustomHeight:NO ofHeightSize:0
                                                                       orOriginalPhoto:YES];
    XCTAssertEqualObjects(urlPhotoString, @"https://prefix.com/original/suffix");
}

@end
