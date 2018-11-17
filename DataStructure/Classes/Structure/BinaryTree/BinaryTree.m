//
//  BinaryTree.m
//  DataStructure
//
//  Created by Qiang on 2018/11/12.
//  Copyright © 2018 Qiang. All rights reserved.
//

#import "BinaryTree.h"

@implementation TreeNode

+ (TreeNode *)treeNodeWithData:(NSInteger)data {
    TreeNode *node = [[TreeNode alloc] init];
    node.data = data;
    return node;
}

@end

@implementation BinaryTree

+ (void)preOrderVisit:(TreeNode *)tree {
    if (!tree) return;
    NSLog(@"%ld", (long)tree.data);
    [self preOrderVisit:tree.left];
    [self preOrderVisit:tree.right];
}

+ (void)inOrderVisit:(TreeNode *)tree {
    if (!tree) return;
    [self inOrderVisit:tree.left];
    NSLog(@"%ld", (long)tree.data);
    [self inOrderVisit:tree.right];
}

+ (void)postOrderVisit:(TreeNode *)tree {
    if (!tree) return;
    [self postOrderVisit:tree.left];
    [self postOrderVisit:tree.right];
    NSLog(@"%ld", (long)tree.data);
}

@end
