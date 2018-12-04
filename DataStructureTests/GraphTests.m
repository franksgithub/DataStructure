//
//  GraphTests.m
//  DataStructureTests
//
//  Created by Qiang on 2018/12/3.
//  Copyright © 2018 Qiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Graph.h"

@interface GraphTests : XCTestCase

@end

@implementation GraphTests

- (void)setUp {

}

- (void)tearDown {
}

- (void)testBFS {
    Graph *g = [[Graph alloc] initWithVertexCount:8];
    [g addEdgeWithVertexA:1 vertexB:2];
    [g addEdgeWithVertexA:1 vertexB:3];
    [g addEdgeWithVertexA:1 vertexB:4];
    [g addEdgeWithVertexA:2 vertexB:5];
    [g addEdgeWithVertexA:2 vertexB:6];
    [g addEdgeWithVertexA:3 vertexB:7];
    [g addEdgeWithVertexA:4 vertexB:7];
    
    [g bfsWithStart:1 target:7];
    
}

- (void)testDFS {
    Graph *g = [[Graph alloc] initWithVertexCount:10];
    [g addEdgeWithVertexA:1 vertexB:2];
    [g addEdgeWithVertexA:1 vertexB:4];
    [g addEdgeWithVertexA:2 vertexB:5];
    [g addEdgeWithVertexA:2 vertexB:3];
    [g addEdgeWithVertexA:5 vertexB:4];
    [g addEdgeWithVertexA:5 vertexB:6];
    [g addEdgeWithVertexA:5 vertexB:7];
    [g addEdgeWithVertexA:6 vertexB:3];
    [g addEdgeWithVertexA:6 vertexB:8];
    [g addEdgeWithVertexA:8 vertexB:7];
    [g dfsWithStart:1 target:7];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

@end
