//
//  BinaryTreeTest.m
//  DataStructureTests
//
//  Created by Qiang on 2018/11/12.
//  Copyright © 2018 Qiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BinaryTree.h"

@interface BinaryTreeTest : XCTestCase

@end

@implementation BinaryTreeTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testPreOrderVisit {
    TreeNode *root = [self buildTree];
    [BinaryTree preOrderVisit:root];
}

- (void)testInOrderVisit {
    TreeNode *root = [self buildTree];
    [BinaryTree inOrderVisit:root];
}

- (void)testPostOrderVisit {
    TreeNode *root = [self buildTree];
    [BinaryTree postOrderVisit:root];
}

/*
    10
  12  14
 6 34 890
 
 
 */

- (TreeNode *)buildTree {
    TreeNode *root = [TreeNode treeNodeWithData:10];
    TreeNode *node1 = [TreeNode treeNodeWithData:12];
    TreeNode *node2 = [TreeNode treeNodeWithData:14];
    TreeNode *node3 = [TreeNode treeNodeWithData:6];
    TreeNode *node4 = [TreeNode treeNodeWithData:34];
    TreeNode *node5 = [TreeNode treeNodeWithData:890];
    root.left = node1;
    root.right = node2;
    node1.left = node3;
    node1.right = node4;
    node2.left = node5;
    return root;
}

@end
