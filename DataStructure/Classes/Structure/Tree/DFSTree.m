//
//  DFSTree.m
//  DataStructure
//
//  Created by Qiang on 2019/1/9.
//  Copyright © 2019 Qiang. All rights reserved.
//

#import "DFSTree.h"
#import "SimpleStack.h"

@interface DFSTree()

@property (nonatomic, strong) DFSTreeNode *rootNode;

@end

@implementation DFSTree

- (instancetype)init {
    self = [super init];
    if (self) {
        _rootNode = [[DFSTreeNode alloc] initWithLabel:' ' prefix:@" " exp:nil];
    }
    return self;
}

- (void)dfsByStack {
    SimpleStack<DFSTreeNode *> *stack = [SimpleStack stack];
    [stack push:_rootNode];
    while (![stack isEmpty]) {
        DFSTreeNode *node = [stack pop];
        if (node.sons.count == 0) {
            NSLog(@"********************%@%c  ********************", node.prefix, node.label);
        } else {
            SimpleStack<DFSTreeNode *> *tempStack = [SimpleStack stack];
            [node.sons enumerateKeysAndObjectsUsingBlock:^(NSString *key, DFSTreeNode *obj, BOOL *stop) {
                [tempStack push:obj];
            }];
            //逆序
            while (![tempStack isEmpty]) {
                [stack push:[tempStack pop]];
            }
        }
    }
}

- (void)buildTreeWithCString:(char *)cStr {
    if (!cStr) {
        return;
    }
    DFSTreeNode *parentNode = _rootNode;
    while (*cStr != '\0') {
        @autoreleasepool {
            NSString *son = [NSString stringWithFormat:@"%c", *cStr];
            if (!parentNode.sons[son]) {
                NSString *prefix = [NSString stringWithFormat:@"%@%c", parentNode.prefix, parentNode.label];
                DFSTreeNode *node = [[DFSTreeNode alloc] initWithLabel:*cStr prefix:prefix exp:nil];
                [parentNode.sons setValue:node forKey:son];
            }
            parentNode = parentNode.sons[son];
            cStr++;
        }
    }
}

@end
