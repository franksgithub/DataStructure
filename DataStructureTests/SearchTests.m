//
//  SearchTests.m
//  DataStructureTests
//
//  Created by Qiang on 2018/10/24.
//  Copyright © 2018 Qiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AllSearch.h"

@interface SearchTests : XCTestCase

@end

@implementation SearchTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testBinarySearch {
    int a[7] = {1, 4, 8, 8, 8, 11, 19};
    int index = binary_search(a, 7, 8);
    NSLog(@"index : %d", index);
}

- (void)testBinarySearchForFirstBigger {
    int a[7] = {1, 4, 8, 8, 8, 11, 19};
    int index = binary_search_first_bigger(a, 7, 8);
    NSLog(@"index : %d", index);
}

- (void)testBinarySearchForLastSmaller {
    int a[7] = {1, 4, 8, 8, 8, 11, 19};
    int index = binary_search_last_smaller(a, 7, 8);
    NSLog(@"index : %d", index);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
