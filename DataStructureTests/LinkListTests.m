//
//  LinkListTests.m
//  DataStructureTests
//
//  Created by Qiang on 2018/11/13.
//  Copyright © 2018 Qiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SingleLinkedList.h"

@interface LinkListTests : XCTestCase

@end

@implementation LinkListTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    ListNode *node1 = [ListNode nodeWithData:1];
    ListNode *node2 = [ListNode nodeWithData:2];
    ListNode *node3 = [ListNode nodeWithData:3];
    ListNode *node4 = [ListNode nodeWithData:4];
    ListNode *node5 = [ListNode nodeWithData:5];
    ListNode *node6 = [ListNode nodeWithData:6];
    ListNode *node7 = [ListNode nodeWithData:7];
    ListNode *node8 = [ListNode nodeWithData:8];
    ListNode *node9 = [ListNode nodeWithData:9];
    node1.next = node2;
    node2.next = node3;
    node3.next = node4;
    node4.next = node5;
    node5.next = node6;
    node6.next = node7;
    node7.next = node8;
    node8.next = node9;
    node9.next = node5;
    
    [SingleLinkedList checkCircle:node1];
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
