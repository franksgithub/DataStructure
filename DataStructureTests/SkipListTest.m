//
//  SkipListTest.m
//  DataStructureTests
//
//  Created by Qiang on 2019/1/31.
//  Copyright © 2019 Qiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SkipList.h"

@interface SkipListTest : XCTestCase

@end

@implementation SkipListTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    SkipList *skList = [[SkipList alloc] init];
    [skList insert:10];
    [skList insert:20];
    [skList insert:3];
    [skList insert:28];
    [skList insert:1];
    [skList insert:5];
    
    [skList insert:12];
    [skList insert:23];
    [skList insert:36];
    [skList insert:285];
    [skList insert:121];
    [skList insert:50];
    
    [skList insert:121];
    [skList insert:204];
    [skList insert:33];
    [skList insert:203];
    [skList insert:190];
    [skList insert:58];
    NSInteger data = [skList find:10].data;
    NSLog(@"data : %ld", data);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
