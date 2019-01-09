//
//  DijkstraTest.m
//  DataStructureTests
//
//  Created by Qiang on 2019/1/7.
//  Copyright © 2019 Qiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DijkstraGraph.h"

@interface DijkstraTest : XCTestCase

@end

@implementation DijkstraTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testDijkstra {
    DijkstraGraph *graph = [[DijkstraGraph alloc] initWithVertexCount:6];
    [graph addEdgeWithVertexA:0 vertexB:1 weight:10];
    [graph addEdgeWithVertexA:0 vertexB:4 weight:15];
    [graph addEdgeWithVertexA:1 vertexB:2 weight:15];
    [graph addEdgeWithVertexA:1 vertexB:3 weight:2];
    [graph addEdgeWithVertexA:3 vertexB:2 weight:1];
    [graph addEdgeWithVertexA:3 vertexB:5 weight:12];
    [graph addEdgeWithVertexA:2 vertexB:5 weight:5];
    [graph addEdgeWithVertexA:4 vertexB:5 weight:10];
    [graph dijkstraWithStart:0 target:5];
}

- (void)testRecArray {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:5];
    [array addObject:@(1)];
    [array addObject:@(2)];
    [array addObject:@(3)];
    [array addObject:@(4)];
    [array addObject:@(5)];
    [self reversePrintArrayWithIndex:0 array:array];
}

- (void)reversePrintArrayWithIndex:(NSInteger)index array:(NSArray *)array {
    if (index == array.count) {
        return;
    }
    [self reversePrintArrayWithIndex:index+1 array:array];
    NSLog(@"ele : %@", array[index]);
}


@end
