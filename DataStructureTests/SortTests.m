//
//  SortTests.m
//  DataStructureTests
//
//  Created by Qiang on 2018/10/15.
//  Copyright © 2018 Qiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AllSort.h"

@interface SortTests : XCTestCase

@end

@implementation SortTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testInsertionSort {
    int a[6] = {3, 8, 2, 10, 5, 20};
    insertionSort(a, 6);
    printArray(a, 6);
    NSLog(@"-----------------------------------");
    int b[6] = {3, 8, 2, 10, 20, 5};
    bubbleSort(b, 6);
    printArray(b, 6);
    NSLog(@"-----------------------------------");
    int c[11] = {3, 8, 2, 10, 20, 5, 88, -1, 100, 4, 1};
    selectionSort(c, 11);
    printArray(c, 11);
}

- (void)testMergeSort {
    int c[11] = {3, 8, 2, 10, 20, 5, 88, -1, 100, 4, 1};
    merge_sort(c, 11);
    printArray(c, 11);
}

- (void)testQuickSort {
//    int c[11] = {3, 8, 2, 10, 20, 5, 88, -1, 100, 4, 9};
    int length = 7;
    int c[7] = {5,6,7,8,2,3,4};
    quick_sort(c, length);
    printArray(c, length);
}

- (void)testCountingSort {
    int c[11] = {3, 8, 2, 10, 2, 5, 7, 5, 3, 6, 1};
    countingSort(c, 11);
    printArray(c, 11);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
