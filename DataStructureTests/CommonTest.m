//
//  CommonTest.m
//  DataStructureTests
//
//  Created by Qiang on 2018/12/5.
//  Copyright © 2018 Qiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Common.h"

@interface CommonTest : XCTestCase

@end

@implementation CommonTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    double money = 76549.28f;
    NSString *moneyStr = [Common transforMoneyWithValue:money];
    NSLog(@"money : %@", moneyStr);
}

- (void)testQueens {
    cal8Queens(0);
}

- (void)testKnapsack {
    int weight[] = {2, 2, 4, 6, 3};
    int n = 5;
    int w = 9;
    int res = knapsack(weight, n, w);
    NSLog(@"*****1 res : %d *****", res);
    res = bagDP(weight, n, w);
    NSLog(@"*****2 res : %d *****", res);
    
}

- (void)testKnapsack2 {
    int weight[] = {2, 2, 4, 6, 3};
    int n = 5;
    int w = 9;
    int res = knapsack2(weight, n, w);
    NSLog(@"res : %d", res);
    res = bagDP2(weight, n, w);
    NSLog(@"res : %d", res);
}

- (void)testKnapsack3 {
    int weight[] = {2, 2, 4, 6, 3};
    int value[] = {3,4,8,9,6};
    int n = 5;
    int w = 9;
    int res = knapsack3(weight, value, n, w);
    NSLog(@"res : %d", res);
}

- (void)testSwap {
    swapTest();
}

- (void)testBag {
    int items[] = {10, 22, 33, 55, 2, 33, 78, 23, 90, 30};
    bag(0, 0, items, 10, 100);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
