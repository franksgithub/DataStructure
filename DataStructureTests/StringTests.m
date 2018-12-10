//
//  StringTests.m
//  DataStructureTests
//
//  Created by Qiang on 2018/12/5.
//  Copyright © 2018 Qiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "StringMatch.h"

@interface StringTests : XCTestCase

@end

@implementation StringTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testStrMatch {
    BOOL match = str_match(@"like a bird", @"a bi");
    NSLog(@"match : %@", match ? @"YES" : @"NO");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        testDecorator();
    }];
}

@end
