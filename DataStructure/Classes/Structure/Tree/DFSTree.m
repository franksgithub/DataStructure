//
//  DFSTree.m
//  DataStructure
//
//  Created by Qiang on 2019/1/9.
//  Copyright © 2019 Qiang. All rights reserved.
//

#import "DFSTree.h"

@implementation DFSTree

+ (void)dfsByStackWithTreeNode:(DFSTreeNode *)treeNode {
    NSMutableArray<DFSTreeNode *> *stack = [NSMutableArray array];
    [stack addObject:treeNode];
    while (stack.count > 0) {
        DFSTreeNode *node = [stack lastObject];
        [stack removeLastObject];
        if (node.sons.count == 0) {
            NSLog(@"********************%@%c********************", node.prefix, node.label);
        } else {
            NSMutableArray<DFSTreeNode *> *tempStack = [NSMutableArray array];
            [node.sons enumerateKeysAndObjectsUsingBlock:^(NSString *key, DFSTreeNode *obj, BOOL *stop) {
                [tempStack addObject:obj];
            }];
            while (tempStack.count > 0) {
                [stack addObject:[tempStack lastObject]];
                [tempStack removeLastObject];
            }
        }
    }
}

@end
