//
//  Trie.m
//  DataStructure
//
//  Created by Qiang on 2018/12/12.
//  Copyright © 2018 Qiang. All rights reserved.
//

#import "Trie.h"

#define kEmptyNode [NSNull null]

@implementation TrieNode

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

@interface Trie() {
    TrieNode *root;
}


@end


@implementation Trie

- (instancetype)init {
    self = [super init];
    if (self) {
        root = [[TrieNode alloc] initWithChar:'\\'];
    }
    return self;
}

- (void)insert:(NSString *)text {
    TrieNode *tempNode = root;
    for (int i = 0; i < text.length; i++) {
        unichar tempChar = [text characterAtIndex:i];
        int index = tempChar - 'a';
        if (tempNode.children[index] == kEmptyNode) {
            TrieNode *newNode = [[TrieNode alloc] initWithChar:tempChar];
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
    TrieNode *tempNode = root;
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

@end
