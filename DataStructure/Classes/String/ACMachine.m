//
//  Trie.m
//  DataStructure
//
//  Created by Qiang on 2018/12/12.
//  Copyright © 2018 Qiang. All rights reserved.
//

#import "ACMachine.h"
#import "SimpleQueue.h"

#define kEmptyNode [NSNull null]

@implementation ACNode

- (instancetype)initWithChar:(char)data {
    self = [super init];
    if (self) {
        _data = data;
        _children = [NSMutableArray arrayWithCapacity:26];
        for (int i = 0; i < 26; i++) {
            _children[i] = kEmptyNode;
        }
    }
    return self;
}

@end

@interface ACMachine() {
    ACNode *root;
}

@end


@implementation ACMachine

- (instancetype)init {
    self = [super init];
    if (self) {
        root = [[ACNode alloc] initWithChar:'\\'];
    }
    return self;
}

- (void)insert:(NSString *)text {
    ACNode *tempNode = root;
    for (int i = 0; i < text.length; i++) {
        //判断字符是否在当前结点的children中存在
        //若不存在，则将保存
        //若已存在，更新当前结点
        unichar tempChar = [text characterAtIndex:i];
        int index = tempChar - 'a';
        if (tempNode.children[index] == kEmptyNode) {
            ACNode *newNode = [[ACNode alloc] initWithChar:tempChar];
            tempNode.children[index] = newNode;
            if (i == text.length - 1) {
                newNode.isEndingChar = YES;
            }
        }
        //look
        tempNode = tempNode.children[index];
    }
}

- (BOOL)find:(NSString *)pattern {
    ACNode *tempNode = root;
    for (int i = 0; i < pattern.length; i++) {
        int index = [pattern characterAtIndex:i] - 'a';
        if (tempNode.children[index] == kEmptyNode) {
            return NO;
        }
        tempNode = tempNode.children[index];
    }
    //是结尾的字符，表示完全匹配
    return tempNode.isEndingChar;
}

- (void)buildFailurePointer {
    SimpleQueue<ACNode *> *queue = [SimpleQueue queue];
    root.fail = nil;
    [queue enqueue:root];
    while (![queue isEmpty]) {
        ACNode *firstNode = [queue dequeue];
        for (int i = 0; i < 26; i++) {
            ACNode *child = firstNode.children[i];
            if ((id)child == kEmptyNode) {
                continue;
            }
            if (firstNode == root) {
                child.fail = root;
            } else {
                ACNode *failNode = firstNode.fail;
                while ((id)failNode != kEmptyNode) {
                    ACNode *childNode = failNode.children[child.data - 'a'];
                    if ((id)childNode != kEmptyNode) {
                        child.fail = childNode;
                        break;
                    }
                    failNode = failNode.fail;
                }
                if ((id)failNode == kEmptyNode) {
                    child.fail = root;
                }
            }
            [queue enqueue:child];
        }
    }
}

- (void)match:(NSString *)txt {
    NSUInteger len = txt.length;
    ACNode *p = root;
    for (int i = 0 ; i < len; i++) {
        int idx = [txt characterAtIndex:i] - 'a';
        while (p.children[idx] == kEmptyNode && p != root) {
            p = p.fail;
        }
        p = p.children[idx];
        if ((id)p == kEmptyNode) {
            p = root;
        }
        ACNode *tmp = p;
        while (tmp != root) {
            if (tmp.isEndingChar) {
                int pos = i - tmp.length + 1;
                NSLog(@"匹配起始下标 : %d, 长度 : %d", pos, tmp.length);
            }
            tmp = tmp.fail;
        }
    }
}

@end
