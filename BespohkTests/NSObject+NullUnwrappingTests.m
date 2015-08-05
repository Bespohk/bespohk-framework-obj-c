//
//  NSObject+NullUnwrappingTests.m
//  Bespohk
//
//  Created by Simon Coulton on 8/07/2015.
//  Copyright (c) 2015 Bespohk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NSObject+NullUnwrapping.h"

@interface NSObject_NullUnwrappingTests : XCTestCase

@end

@implementation NSObject_NullUnwrappingTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testStripNull
{
    NSDictionary *testDict = @{
                               @"test": [NSNull null]
                               };
    id value = testDict[@"test"];
    XCTAssert([value isKindOfClass:[NSNull class]]);
    XCTAssert(![value valueOrNil]);
}

@end
