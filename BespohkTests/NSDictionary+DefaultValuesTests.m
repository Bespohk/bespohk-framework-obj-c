//
//  NSDictionary+DefaultValuesTests.m
//  Bespohk
//
//  Created by Simon Coulton on 8/07/2015.
//  Copyright (c) 2015 Bespohk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NSDictionary+DefaultValues.h"

@interface NSDictionary_DefaultValuesTests : XCTestCase

@end

@implementation NSDictionary_DefaultValuesTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testMissingValue
{
    NSDictionary *testDict = @{
                               @"test": [NSNull null],
                               @"blah": @"b"
                               };
    XCTAssertEqual(@"a", [testDict get:@"test" or:@"a"]);
    XCTAssertEqual(@"b", [testDict get:@"blah" or:@"c"]);
    XCTAssertEqual(@"b", [testDict get:@"missing" or:@"b"]);
}

@end
