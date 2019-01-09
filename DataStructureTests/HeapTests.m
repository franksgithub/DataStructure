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
    int array[] = {-1,5,2,1,4,0,6,9,20,3,29};
//    buildHeap(array, 10);
    heap_sort(array, 10);
    for (int i = 0; i <= 10; i++) {
        NSLog(@"ele : %d", array[i]);
    }
}

- (void)testSmallHeap {
    HeapSort *heap = [[HeapSort alloc] initWithCapicity:6];
    [heap insertData:3];
    [heap insertData:2];
    [heap insertData:10];
    [heap insertData:9];
    [heap insertData:5];
    [heap insertData:20];
    int top = [heap removeTop];
    top = [heap removeTop];
    top = [heap removeTop];
    top = [heap removeTop];
    top = [heap removeTop];
    top = [heap removeTop];
    NSLog(@"top : %d", top);
}

@end
