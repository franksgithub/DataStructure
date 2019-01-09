//
//  DFSTreeTest.m
//  DataStructureTests
//
//  Created by Qiang on 2019/1/9.
//  Copyright © 2019 Qiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DFSTree.h"
#import "DFSTreeNode.h"

@interface DFSTreeTest : XCTestCase

@end

@implementation DFSTreeTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testDFSTree {
    DFSTreeNode *node = [[DFSTreeNode alloc] initWithLabel:'b' prefix:nil exp:nil];
    DFSTreeNode *node1 = [[DFSTreeNode alloc] initWithLabel:'o' prefix:@"b" exp:nil];
    DFSTreeNode *node2 = [[DFSTreeNode alloc] initWithLabel:'y' prefix:@"bo" exp:nil];
    
    DFSTreeNode *node3 = [[DFSTreeNode alloc] initWithLabel:'c' prefix:@"boy" exp:nil];
    DFSTreeNode *node4 = [[DFSTreeNode alloc] initWithLabel:'e' prefix:@"boyc" exp:nil];
    
    DFSTreeNode *node5 = [[DFSTreeNode alloc] initWithLabel:'i' prefix:@"boy" exp:nil];
    DFSTreeNode *node6 = [[DFSTreeNode alloc] initWithLabel:'s' prefix:@"boyi" exp:nil];
    DFSTreeNode *node7 = [[DFSTreeNode alloc] initWithLabel:'h' prefix:@"boyis" exp:nil];
    
    [node.sons setValue:node1 forKey:@"o"];
    [node1.sons setValue:node2 forKey:@"y"];
    
    [node2.sons setValue:node3 forKey:@"c"];
    [node3.sons setValue:node4 forKey:@"e"];
    
    [node2.sons setValue:node5 forKey:@"i"];
    [node5.sons setValue:node6 forKey:@"s"];
    [node6.sons setValue:node7 forKey:@"h"];
    
    [DFSTree dfsByStackWithTreeNode:node];
}

@end
