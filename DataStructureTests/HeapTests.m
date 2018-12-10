//
//  HeapTests.m
//  DataStructureTests
//
//  Created by Qiang on 2018/12/4.
//  Copyright © 2018 Qiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HeapSort.h"

@interface HeapTests : XCTestCase

@end

@implementation HeapTests

- (void)setUp {
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testBuildHeap {
    int array[] = {-1,2,1,4,0,6,9,20,3,29};
    buildHeap(array, 10);
    for (int i = 0; i <= 10; i++) {
        NSLog(@"ele : %d", array[i]);
    }
}

@end
