//
//  DPTests.m
//  DataStructureTests
//
//  Created by Qiang on 2019/1/2.
//  Copyright © 2019 Qiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DP.h"

@interface DPTests : XCTestCase

@end

@implementation DPTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testLwstBt {
    lwstBT(0, 0, 0);
}

- (void)testLwstDP {
    char *strA = "helloworld";
    char *strB = "ahlloworld";
    lwstDP(strA, 10, strB, 10);
}

- (void)testLwstDPTest {
    char *strA = "helloworld";
    char *strB = "aelloworld";
    lwstDPTest(strA, 10, strB, 10);
}

- (void)testLcsDP {
    char *strA = "h3leoworldf";
    char *strB = "helloworrdd";
    lcsDP(strA, 10, strB, 10);
}

- (void)testMinDistBt {
    int matrix[5][5];
    int len = 5;
    for (int i = 0; i < len; ++i) {
        for (int j = 0; j < len; ++j) {
            matrix[i][j] = i + j;
        }
    }
    minDistBT(0, 0, 0, matrix, 4);
}

- (void)testMinDistDP {
    int matrix[4][4] = {{1,2,3,4}, {1,2,3,4}, {1,2,3,4}, {1,2,3,4}};
    minDistDP(matrix, 4);
}

- (void)testMinDistForMatrix {
    minDistForMatrixDP(3, 3);
}

- (void)testTrianglePath {
    trianglePath();
}

- (void)testLcs_objc {
    NSString *strA = @"h3leoworldf";
    NSString *strB = @"helloworrdd";
    NSInteger dis = lcs_objc(strA, strB);
    NSLog(@"dis : %ld", dis);
}

@end
