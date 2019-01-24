//
//  BitMapTest.m
//  DataStructureTests
//
//  Created by Qiang on 2019/1/9.
//  Copyright © 2019 Qiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BitMap.h"
#import "SimpleStack.h"

@interface BitMapTest : XCTestCase

@end

@implementation BitMapTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testBitMap {
    BitMap *map = [[BitMap alloc] initWithNumOfBits:10];
    [map setBitWithIndex:5];
    [map setBitWithIndex:8];
    BOOL bit = [map getBitWithIndex:1];
    bit  = [map getBitWithIndex:3];
    bit = [map getBitWithIndex:8];
    
    SimpleStack<NSString *> *stack = [[SimpleStack alloc] initWithCapacity:5];
    [stack push:@"1"];
    [stack push:@"2"];
    [stack push:@"3"];
    [stack push:@"4"];
    while (![stack isEmpty]) {
        NSLog(@"ele : %@", [stack pop]);
    }
}

@end
