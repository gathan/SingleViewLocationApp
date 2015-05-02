//
//  NSObjectAndProjectAdditionsCategoryTests.m
//  SingleViewLocationApp
//
//  Created by Georgios Athanasopoulos on 5/3/15.
//  Copyright (c) 2015 GA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NSObject+ProjectAdditions.h"

@interface NSObjectAndProjectAdditionsCategoryTests : XCTestCase

@end

@implementation NSObjectAndProjectAdditionsCategoryTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testIsStringAndNotNullWithNullInput {
    BOOL testResult = [[NSNull null] isStringAndNotEmpty];
    XCTAssertFalse(testResult);
}

- (void)testIsStringAndNotNullWithEmptyInput {
    BOOL testResult = [@"" isStringAndNotEmpty];
    XCTAssertFalse(testResult);
}

- (void)testIsStringAndNotNullWithNewLineCharsInput {
    BOOL testResult = [@"\n\n\n \n \n " isStringAndNotEmpty];
    XCTAssertFalse(testResult);
}

- (void)testIsStringAndNotNullRunOnNil {
    NSString *nilString = nil;
    BOOL testResult = [nilString isStringAndNotEmpty];
    XCTAssertFalse(testResult);
}

- (void)testIsStringAndNotNullRunOnAGoodString {
    NSString *goodString = @"good string";
    BOOL testResult = [goodString isStringAndNotEmpty];
    XCTAssertTrue(testResult);
}

- (void)testIsNullWithNull {
    BOOL testResult = [[NSNull null] isNull];
    XCTAssertTrue(testResult);
}

- (void)testIsNullWithNil {
    NSNull *nilNull = nil;
    BOOL testResult = [nilNull isNull];
    XCTAssertFalse(testResult);
}

- (void)testIsNullWithNotNull {
    BOOL testResult = [[NSObject new] isNull];
    XCTAssertFalse(testResult);
}

- (void)testIsNumberWithNull {
    BOOL testResult = [[NSNull null] isNumber];
    XCTAssertFalse(testResult);
}

- (void)testIsNumberWithNumber {
    BOOL testResult = [@(15) isNumber];
    XCTAssertTrue(testResult);
}

- (void)testIsNumberWithString {
    BOOL testResult = [@"15" isNumber];
    XCTAssertFalse(testResult);
}

- (void)testIsNumberRunOnNil {
    NSNumber *nilNumber = nil;
    BOOL testResult = [nilNumber isNumber];
    XCTAssertFalse(testResult);
}

@end
