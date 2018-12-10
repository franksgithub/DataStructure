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

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
